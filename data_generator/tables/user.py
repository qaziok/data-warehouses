import dataclasses
from typing import Any


@dataclasses.dataclass
class User:
    person: Any
    username: str
    id: int = dataclasses.field(init=False, default=None)

    def database(self):
        return f"{self.id}|{self.person.id}|{self.username}"
