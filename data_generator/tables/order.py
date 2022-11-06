import dataclasses
import datetime
import random

from tables import Package, ParcelLocker, User, Stage, Address


@dataclasses.dataclass
class Order:
    user: User
    package: Package
    input_parcel_locker: ParcelLocker
    output_parcel_locker: ParcelLocker
    status: str
    datetime: datetime.datetime
    stages: list = dataclasses.field(default_factory=list, init=False)
    id: int = dataclasses.field(init=False, default=None)

    def __post_init__(self):
        self.stages_status = Stage.package_route()

    @classmethod
    def generate(cls, user, package, input_parcel_locker, output_parcel_locker, date_time):
        order = cls(user, package, input_parcel_locker, output_parcel_locker, "Brak informacji", date_time)
        order.next_stage(date_time)
        return order

    def database(self):
        return f"{self.id}|{self.user.id}|{self.package.id}|" \
               f"{self.input_parcel_locker.id}|" \
               f"{self.output_parcel_locker.id}|{self.status} "

    def next_stage(self, date_time):
        parcel_locker, how_to_address, status, worker_needed = next(self.stages_status)
        worker = None
        if worker_needed:
            if self.stages[-1].worker:
                if self.stages[-1].worker.job == worker_needed:
                    worker = self.stages[-1].worker
                else:
                    self.stages[-1].worker.busy = False

            possible_workers = list(filter(lambda x: not x.busy, self.__getattribute__(parcel_locker).
                                           sorting_center.workers.active[worker_needed]))

            if not worker and possible_workers:
                worker = random.choice(possible_workers)
                worker.busy = True

            if not worker:
                return None, "Brak wolnych pracowników"

        to_add_address = None
        match how_to_address:
            case 'parcel_locker_address':
                address = self.__getattribute__(parcel_locker).address
            case 'sorting_center_address':
                address = self.__getattribute__(parcel_locker).sorting_center.address
            case 'generated_address':
                address = to_add_address = Address.generate()

        self.stages.append(Stage.generate(self, address, worker, date_time, status))
        self.status = status
        return to_add_address, status == 'Paczka odebrana'
