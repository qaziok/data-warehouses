import dataclasses
import datetime
from typing import Any


@dataclasses.dataclass
class Worker:
    person: Any
    date_of_employment: datetime.datetime
    job: str = dataclasses.field(default=None)
    salary: float = dataclasses.field(default=0.0, init=False)
    date_of_dismissal: datetime.datetime = dataclasses.field(default=None, init=False)
    id: int = dataclasses.field(init=False, default=None)

    def __post_init__(self):
        self.sorting_center = None
        self.busy = False

    def database(self):
        return f"{self.id}|{self.person.id}"

    def excel(self):
        date_of_dismissal = self.date_of_dismissal.date() if self.date_of_dismissal else ""
        return self.id, self.person.name, self.person.surname, self.person.birthdate, self.person.sex, \
               self.job, self.sorting_center.id, self.date_of_employment.date(), date_of_dismissal,\
               self.salary
