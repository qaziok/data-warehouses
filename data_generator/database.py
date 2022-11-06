import dataclasses
import datetime
import os
import random
from itertools import chain

from tables import *
from helpful import listdict

NUMBER_OF_SORTING_CENTERS = 10
NUMBER_OF_PARCEL_LOCKERS_PER_SORTING_CENTER = 50
NUMBER_OF_USERS = 100


@dataclasses.dataclass
class Database:
    T0: datetime.date
    people: list[Person] = dataclasses.field(default_factory=list, init=False)
    sorting_centers: list[SortingCenter] = dataclasses.field(default_factory=list, init=False)
    parcel_lockers: list[ParcelLocker] = dataclasses.field(default_factory=list, init=False)
    users: list[User] = dataclasses.field(default_factory=list, init=False)
    packages: list[Package] = dataclasses.field(default_factory=list, init=False)

    def __post_init__(self):
        self.__addresses = listdict(['parcel_lockers', 'sorting_centers', 'stages'])
        self.__orders = listdict(['open', 'closed'])

        for _ in range(NUMBER_OF_SORTING_CENTERS):
            self.__addresses.sorting_centers.append(address := Address.generate())
            self.sorting_centers.append(sorting_center := SortingCenter.generate(address))
            self.people.extend(sorting_center.fill_workers(self.T0))

        for sorting_center in self.sorting_centers:
            for _ in range(NUMBER_OF_PARCEL_LOCKERS_PER_SORTING_CENTER):
                self.__addresses.parcel_lockers.append(address := Address.generate())
                self.parcel_lockers.append(ParcelLocker.generate(address, sorting_center))

        for _ in range(NUMBER_OF_USERS):
            self.person_creates_account()

    @property
    def addresses(self):
        return list(chain(*self.__addresses.values()))

    @property
    def workers(self):
        workers = []
        for sorting_center in self.sorting_centers:
            workers.extend(sorting_center.active_workers())
            workers.extend(sorting_center.dismissed_workers())
        return sorted(workers, key=lambda worker: (worker.date_of_employment, worker.salary, worker.person.surname))

    @property
    def orders(self):
        return sorted(list(chain(*self.__orders.values())), key=lambda order: order.datetime)

    @property
    def stages(self):
        return sorted([stage for order in self.orders for stage in order.stages], key=lambda stage: stage.datetime)

    def __active_workers(self):
        workers = []
        for sorting_center in self.sorting_centers:
            workers.extend(sorting_center.active_workers())
        return workers

    def __workers_per_sorting_center(self):
        workers = []
        for sorting_center in self.sorting_centers:
            workers_per_sorting_center = list(sorting_center.active_workers())
            workers_per_sorting_center.extend(sorting_center.dismissed_workers())

            workers.append((sorting_center, workers_per_sorting_center))
        return workers

    def __export_to_database(self, file_dir=''):
        to_save = {
            'addresses': self.addresses,
            'people': self.people,
            'users': self.users,
            'sorting_centers': self.sorting_centers,
            'parcel_lockers': self.parcel_lockers,
            'packages': self.packages,
            'workers': self.workers,
            'orders': self.orders,
            'stages': self.stages,
        }

        for table_name, table_data in to_save.items():
            with open(f"data/{file_dir}/{table_name}_{file_dir}.bulk", "w") as file:
                for i, row in enumerate(table_data):
                    row.id = i + 1
                    file.write(f"{row.database()}\n")

    def __export_to_excel(self, file_dir=''):
        from pandas import DataFrame
        excel_workers = DataFrame(
            [worker.excel() for worker in self.workers],
            columns=['id', 'imie', 'nazwisko', 'data urodzenia', 'płeć', 'stanowisko', 'sortownia',
                     'data zatrudnienia', 'data zwolnienia', 'wynagrodzenie'])
        excel_workers.to_excel(f'data/{file_dir}/workers_{file_dir}.xlsx', index=False)

    def export_data(self, file_dir=''):
        if not os.path.exists("data"):
            os.mkdir("data")

        if not os.path.exists(f"data/{file_dir}"):
            os.mkdir(f"data/{file_dir}")

        self.__export_to_database(file_dir)
        self.__export_to_excel(file_dir)

    def person_creates_account(self):
        self.people.append(person := Person.generate())
        self.users.append(user := person.user())
        return user

    def person_starts_working(self, date):
        self.people.append(person := Person.generate())
        employment = list(filter(lambda sc: sc.find_vacancy(), self.sorting_centers))
        sorting_center = random.choice(employment if employment else self.sorting_centers)
        sorting_center.employ(worker := person.worker(date))
        return worker

    def user_sends_package(self, date_time):
        user = random.choice(self.users)
        self.packages.append(package := Package.generate())
        input_parcel_locker, output_parcel_locker = random.sample(self.parcel_lockers, k=2)
        self.__orders.open.append(
            order := Order.generate(user, package, input_parcel_locker, output_parcel_locker, date_time))
        return order

    def orders_update(self, numer_of_orders, date_time):
        last_time = date_time
        for order in self.__orders.open[:numer_of_orders]:
            address, to_close = order.next_stage(last_time)
            if to_close == "Brak wolnych pracowników":
                continue
            last_time = date_time + datetime.timedelta(minutes=random.randint(1, 420))
            if address:
                self.__addresses.stages.append(address)
            if to_close:
                self.__orders.closed.append(order)
                self.__orders.open.remove(order)

    def worker_stops_working(self, date):
        worker = random.choice(self.__active_workers())
        worker.sorting_center.dismiss(worker, date)
        return worker
