import dataclasses
import random

from tables import Address, SortingCenter


@dataclasses.dataclass
class ParcelLocker:
    address: Address
    sorting_center: SortingCenter
    small: int
    medium: int
    large: int
    id: int = dataclasses.field(init=False, default=None)

    @classmethod
    def generate(cls, address, sorting_center):
        small = random.randint(10, 30)
        medium = random.randint(5, 15)
        large = random.randint(3, 10)
        return cls(address, sorting_center, small, medium, large)

    def database(self):
        return f"{self.id}|{self.address.id}|" \
                f"{self.large}|{self.medium}|{self.small}|{self.sorting_center.id}"
