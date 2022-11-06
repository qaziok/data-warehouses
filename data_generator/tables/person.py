import dataclasses
import random
from datetime import datetime

from faker import Faker
from faker.providers.person.pl_PL import Provider as PersonProvider
from faker.providers.date_time.en_US import Provider as DateTimeProvider
from faker.providers.profile.en_US import Provider as ProfileProvider

from tables.user import User
from tables.worker import Worker

fake = Faker("pl_PL")
profile_provider = ProfileProvider(fake)
date_provider = DateTimeProvider(fake)
person_provider = PersonProvider(fake)


def person():
    profile = profile_provider.profile(fields=['username', 'name', 'sex', 'mail'])
    date_of_birth = date_provider.date_of_birth(minimum_age=18, maximum_age=85)
    profile['surname'] = profile['name'].split(" ")[-2:][1]
    profile['name'] = profile['name'].split(" ")[-2:][0]
    profile['birthdate'] = date_of_birth
    profile['ssn'] = person_provider.pesel(date_of_birth)
    return profile


@dataclasses.dataclass
class Person:
    name: str
    surname: str
    birthdate: datetime.date
    sex: str
    mail: str
    ssn: str
    username: str
    id: int = dataclasses.field(init=False, default=None)

    @classmethod
    def generate(cls):
        return cls(**person())

    def database(self):
        return f"{self.id}|{self.name}|{self.surname}|{self.birthdate}|{self.mail}"

    def worker(self, date_of_employment):
        worker = Worker(self, date_of_employment)
        worker.salary = random.randint(2000, 5000) + random.randint(0, 99) / 100
        return worker

    def user(self):
        return User(self, self.username)


if __name__ == '__main__':
    print(Person.generate().worker().excel())
    print(Person.generate().user().database())
