import dataclasses
import random as r


def package():
    sizes = [[1, 1, 1, 0], [8, 15, 24, 1], [19, 28, 32, 4], [41, 38, 64, 9]]
    i = r.randint(1, 3)
    w, s, d, m = zip(sizes[i - 1], sizes[i])
    return r.randint(*w), r.randint(*s), r.randint(*d), round(r.randint(*m) + r.random(), 2)


@dataclasses.dataclass
class Package:
    height: int
    width: int
    length: int
    weight: float
    id: int = dataclasses.field(init=False, default=None)

    @classmethod
    def generate(cls):
        return cls(*package())

    def database(self):
        return f"{self.id}|{self.height}|{self.width}|{self.length}|{self.weight}"


if __name__ == '__main__':
    print(Package.generate().database())
