import dataclasses
import random

from faker import Faker
from faker.providers.address.pl_PL import Provider as AddressProvider
from faker.providers.date_time.pl_PL import Provider as DateTimeProvider

from helpful.better_dict import listdict
from tables.address import Address
from tables.person import Person

INITIAL_STAGES = {
    'Kurier': 15,
    'Księgowy': 5,
    'Magazynier': 8,
    'Kierownik': 2
}

fake = Faker("pl_PL")
address_provider = AddressProvider(fake)
date_provider = DateTimeProvider(fake)


@dataclasses.dataclass
class SortingCenter:
    address: Address
    administrative_unit: str
    id: int = dataclasses.field(init=False, default=None)

    def __post_init__(self):
        self.workers = listdict(['active', 'dismissed'],
                                lambda: listdict(['Kurier', 'Księgowy', 'Magazynier', 'Kierownik']))

    @classmethod
    def generate(cls, address):
        return cls(address, address_provider.administrative_unit())

    def database(self):
        return f"{self.id}|{self.address.id}|{self.administrative_unit}"

    def active_workers(self):
        for workers in self.workers.active.values():
            for worker in workers:
                yield worker

    def dismissed_workers(self):
        for workers in self.workers.dismissed.values():
            for worker in workers:
                yield worker

    def fill_workers(self, date):
        all_people_added = []
        for worker_type, number in INITIAL_STAGES.items():
            for _ in range(number + random.randint(-1, 1)):
                worker = Person.generate().worker(date)
                worker.sorting_center = self
                worker.job = worker_type
                self.workers.active[worker_type].append(worker)
                all_people_added.append(worker.person)
        return all_people_added

    def employ(self, worker):
        jobs = list(self.find_vacancy())
        worker.job = random.choice(jobs if jobs else list(INITIAL_STAGES.keys()))
        worker.sorting_center = self
        self.workers.active[worker.job].append(worker)
        return self

    def find_vacancy(self):
        for worker_type, number in INITIAL_STAGES.items():
            if len(self.workers.active[worker_type]) < number:
                yield worker_type

    def dismiss(self, worker, date):
        self.workers.dismissed[worker.job].append(worker)
        self.workers.active[worker.job].remove(worker)
        worker.date_of_dismissal = date


if __name__ == '__main__':
    print(SortingCenter.generate(Address.generate()).workers)
