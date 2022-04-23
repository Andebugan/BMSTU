domains
phone_number=string
surname=symbol

city=symbol
street=symbol
house_num=integer
flat_num=integer

mark=symbol
color=symbol
price=integer
bank_name=symbol
dep_num=integer
dep_size=integer

adress=adress(city, street, house_num, flat_num)

predicates
nondeterm phone(surname, phone_number, adress)
nondeterm car(surname, mark, color, price)
nondeterm bank(surname,bank_name,dep_num,dep_size)
nondeterm find_car(phone_number,surname,mark,price)
nondeterm find_mark(phone_number,mark)
nondeterm find_phone_street_bank(surname, phone_number, city, street, bank_name)
nondeterm find_owner(color, mark, surname, phone_number, city, bank_name)

clauses
phone(trofimov, "8(972)-236-88-62",adress(moscow,krasnaya,89,199)).
phone(trofimov, "8(118)-902-79-19",adress(moscow,krasnaya,89,199)).
phone(ivanov, "8(481)-716-34-95",adress(tula,imperskaya,37,179)).
phone(ivanov, "8(100)-890-60-39",adress(tula,imperskaya,37,179)).
phone(osipov, "8(541)-954-80-76",adress(samara,petrovstaya,81,184)).
phone(osipov, "8(172)-769-16-96",adress(samara,petrovstaya,81,184)).
phone(smirnov, "8(415)-724-38-49",adress(st_petersburg,kerenski_bulvar,28,192)).
phone(smirnov, "8(533)-971-59-87",adress(st_petersburg,kerenski_bulvar,28,192)).
phone(avdeev, "8(294)-313-58-75",adress(st_petersburg,imperskaya,27,118)).      
phone(avdeev, "8(716)-742-39-78",adress(st_petersburg,imperskaya,27,118)).      
phone(lebedev, "8(691)-645-30-38",adress(moscow,krasnaya,66,174)).
phone(avdeev, "8(372)-485-47-49",adress(moscow,krasnaya,76,176)).

bank(trofimov,tinkoff,8546,1252536).
bank(trofimov,alphabank,2029,2521060).
bank(ivanov,vtb,8864,1299690).
bank(ivanov,sberbank,5744,3933822).
bank(osipov,raffaizen,7899,4160502).
bank(osipov,tinkoff,7970,2237517).
bank(smirnov,vtb,9641,1012682).
bank(smirnov,sberbank,8605,4974929).
bank(avdeev,vtb,9197,1050565).
bank(avdeev,raffaizen,7828,4905040).
bank(lebedev,alphabank,9270,846207).
bank(avdeev,tinkoff,1505,3401347).

car(trofimov,volkswagen,red,1600000).
car(trofimov,volkswagen,blue,1600000).
car(ivanov,audi,red,1600000).
car(ivanov,bmw,yellow,1450000).
car(osipov,honda,grey,1300000).
car(osipov,honda,blue,1300000).
car(smirnov,bmw,green,1450000).
car(smirnov,volkswagen,black,1600000).
car(avdeev,volkswagen,green,1600000).
car(avdeev,honda,red,1300000).
car(lebedev,volkswagen,blue,1600000).
car(avdeev,hyundai,black,1470000).

find_car(Phone, Surname, Mark, Price) :- car(Surname, Mark, _, Price), phone(Surname, Phone, _).
find_mark(Phone, Mark) :- find_car(Phone, _, Mark, _).
find_phone_street_bank(Surname, Phone, City, Street, Bank) :- phone(Surname, Phone, adress(City, Street, _, _)), bank(Surname, Bank, _, _).
find_owner(Color, Mark, Surname, Phone, City, Bank) :- phone(Surname, Phone, adress(City, _, _, _)), bank(Surname, Bank, _, _), car(Surname, Mark, Color, _).
goal	
%find_car("8(972)-236-88-62", Surname, Mark, Price).
%find_mark("8(972)-236-88-62", Mark).
%find_phone_street_bank(trofimov, Phone, City, Street, Bank).
find_owner(red, audi, Surname, Phone, City, Bank).
