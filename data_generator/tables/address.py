import dataclasses

from faker import Faker
from faker.providers.address.pl_PL import Provider as AddressProvider

fake = Faker("pl_PL")
address_provider = AddressProvider(fake)


@dataclasses.dataclass
class Address:
    city: str
    street: str
    number: str
    latlng: tuple[float]
    id: int = dataclasses.field(init=False, default=None)

    @classmethod
    def generate(cls):
        return cls(*address())

    def database(self):
        return f"{self.id}|{self.city}|{self.street}|{self.number}|{self.latlng[0]}|{self.latlng[1]}"


def address():
    return (address_provider.city(),
            address_provider.street_name(),
            address_provider.building_number().split("/")[0],
            fake.local_latlng("PL", True))


if __name__ == '__main__':
    print(Address.generate())
