import dataclasses
import datetime
from typing import Any

from tables.address import Address
from tables.worker import Worker

ETAPY = {
    'paczkomat_początkowy': [
        (
            [
                'Paczka zarejestrowana',
                'Paczka umieszczona w paczkomacie'
            ],
            None
        ),
    ],
    'transport': [
        (
            [
                'Paczka odebrana przez kuriera',
                'Paczka w trasie',
                'Paczka dostarczona do celu'
            ],
            'Kurier'
        )
    ],
    'sortownia': [
        (['Paczka odebrana w sortowni'], 'Magazynier'),
        (['Paczka zatwierdzona w sortowni'], 'Księgowy'),
        (['Paczka przygotowana do transportu'], 'Magazynier'),
        (['Paczka wydana do transportu'], 'Kierownik'),
    ],
    'paczkomat_docelowy': [
        (['Paczka odebrana'], None)
    ]
}

TRASA_PACZKI = [
    ('paczkomat_początkowy', 'input_parcel_locker', 'parcel_locker_address'),
    ('transport', 'input_parcel_locker', 'generated_address'),
    ('sortownia', 'input_parcel_locker', 'sorting_center_address'),
    ('transport', 'input_parcel_locker', 'generated_address'),
    ('sortownia', 'output_parcel_locker', 'sorting_center_address'),
    ('transport', 'output_parcel_locker', 'generated_address'),
    ('paczkomat_docelowy', 'output_parcel_locker', 'parcel_locker_address'),
]


@dataclasses.dataclass
class Stage:
    order: Any
    address: Address
    worker: Worker
    datetime: datetime.datetime
    type: str
    id: int = dataclasses.field(init=False, default=None)

    @classmethod
    def generate(cls, order, address, worker, datetime, stage_type):
        stage_type = stage_type if stage_type else 'Brak informacji'
        return cls(order, address, worker, datetime, stage_type)

    @classmethod
    def package_route(cls):
        for stage_type, parcel_locker, address in TRASA_PACZKI:
            for stages, worker_type in ETAPY[stage_type]:
                for stage in stages:
                    yield parcel_locker, address, stage, worker_type

    def database(self):
        worker_id = self.worker.id if self.worker else ""
        return f"{self.id}|{self.datetime.time()}|{self.datetime.date().strftime('%Y-%m-%d')}|" \
               f"{self.address.id}|{self.type}|" \
               f"{self.order.id}|{worker_id}"


if __name__ == '__main__':
    for stage in TRASA_PACZKI:
        [print(s) for s in ETAPY[stage]]
