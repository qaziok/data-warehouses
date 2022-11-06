import datetime
import random

import numpy as np


def randomly_distributed(data, n):
    if len(data) < n:
        return equally_distributed(data, n)

    indices = np.arange(1, len(data))
    np.random.shuffle(indices)
    indices = indices[:n - 1]
    indices.sort()

    data_split = np.split(data, indices)
    return data_split


def equally_distributed(data, n):
    return np.array_split(data, n)


def find(what, where):
    return f"{where.index(what)}" if what in where else None


def dateiterator(start, end):
    for n in range(int((end - start).days)):
        yield start + datetime.timedelta(n)


def random_hour(after: datetime.time = datetime.time(0, 0, 0)):
    for _ in range(100):
        time = datetime.time(np.random.randint(after.hour, 24), np.random.randint(0, 60), np.random.randint(0, 60))
        if time > after:
            return time
    return datetime.time(23, 59, 59)


def days(t0, t1, *,orders, to_employ, to_dismiss):
    days = (t1 - t0).days

    orders_distribution = randomly_distributed(range(orders), days)

    employment = random.sample(range(days), to_employ)
    employment_distribution = [i in employment for i in range(days)]

    dismissal = random.sample(range(days), to_dismiss)
    dismissal_distribution = [i in dismissal for i in range(days)]

    return zip(dateiterator(t0, t1), orders_distribution, employment_distribution, dismissal_distribution)


