import datetime

from database import Database
from helpful.functions import random_hour, days

T0 = datetime.datetime(2020, 1, 1)
T1 = datetime.datetime(2021, 1, 1)
T2 = datetime.datetime(2022, 1, 1)


def loop(db, iterator):
    for date, orders, to_employ, to_dismiss in iterator:
        time = random_hour()
        for _ in orders:
            db.user_sends_package(datetime.datetime.combine(date, time))

        if to_employ:
            db.person_starts_working(date)

        if to_dismiss:
            db.worker_stops_working(date)

        db.orders_update(30, datetime.datetime.combine(date, random_hour(time)))


if __name__ == '__main__':
    db = Database(T0)

    loop(db, days(T0, T1, orders=1000, to_employ=300, to_dismiss=250))

    db.export_data("T0_T1")

    loop(db, days(T1, T2, orders=500, to_employ=100, to_dismiss=150))

    db.export_data("T1_T2")

