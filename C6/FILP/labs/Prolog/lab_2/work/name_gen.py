surname = [
    'smirnov',
    'ivanov',
    'lebedev',
    'zuev',
    'avdeev',
    'birukov',
    'odintsov',
    'yakushev',
    'lapin',
    'knyazev',
    'agafonov',
    'trofimov',
    'gavrilov',
    'osipov'
]

cars_types = [
    ['honda', 1300000],
    ['ferrari', 5000000],
    ['bmw', 1450000],
    ['volkswagen', 1600000],
    ['ford', 1300000],
    ['hyundai', 1470000],
    ['audi', 1600000],
    ['porsche', 1900000],
    ['nissan', 2430000]
]

colors = [
    'red',
    'blue',
    'black',
    'grey',
    'yellow',
    'green'
]

banks_bd = [
    'sberbank',
    'alphabank',
    'vtb',
    'tinkoff',
    'raffaizen'
]

cities = [
    'moscow',
    'st_petersburg',
    'samara',
    'ryazan',
    'tula'
]

streets = [
    'novoterskaya',
    'kerenski_bulvar',
    'petrovstaya',
    'oktyabrskaya',
    'imperskaya',
    'krasnaya'
]

from itertools import chain
from random import choice, randint
from random import randrange

names = []
phones = []
cars = []
banks = []
adresses = []

for i in range(0, 10):
    name = choice(surname)
    adress = 'adress(' + choice(cities) + ',' + choice(streets) + ',' + str(randint(1, 100)) + ',' + str(randint(100, 200)) + ')'
    for i in range(0, randrange(0, 3)):
        phone = str(randrange(100, 999)) + ')-' + str(randrange(100, 999)) + '-' + str(randrange(10, 99)) + '-' + str(randrange(10, 99))
        phone = 'phone(' + name +\
            ', "8(' + phone + '",' + adress + ').'
        phones.append(phone)
        car_type = choice(cars_types)
        car = 'car(' + name + ',' + car_type[0] + ',' + choice(colors) + ',' + str(car_type[1]) + ').'
        cars.append(car)
        bank = 'bank(' + name + ',' + choice(banks_bd) + ',' + str(randint(1000, 10000)) + ',' + str(randint(0, 5000000)) + ').'
        banks.append(bank)

for phone in phones:
    print(phone)
print()

for bank in banks:
    print(bank)
print()

for car in cars:
    print(car)