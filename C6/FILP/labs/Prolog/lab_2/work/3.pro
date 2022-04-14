domains
name=symbol
phone_number=string
surname=symbol
lastname=symbol
university=symbol

predicates
nondeterm phone(name, surname, lastname, phone_number)
nondeterm student(name, surname, lastname, university)
nondeterm person(name, surname, lastname, university, phone_number)

clauses
phone(peter, ivanov, andreevich, "8(219)-892-22-70").
phone(konstantin, knyazev, bespalovich, "8(779)-991-46-67"). 
phone(german, trofimov, semenovich, "8(441)-495-69-57").     
phone(kirill, avdeev, osipovich, "8(882)-634-60-37").        
phone(andrew, ivanov, grigorievich, "8(453)-375-89-10").     
phone(pavel, ivanov, pavlovich, "8(377)-586-23-67").
phone(konstantin, yakushev, samoilovich, "8(495)-735-20-15").
phone(pavel, knyazev, bespalovich, "8(787)-104-49-39").      
phone(german, odintsov, bespalovich, "8(333)-845-58-82").    
phone(alexander, ivanov, pavlovich, "8(353)-566-30-43").
   
student(peter, ivanov, andreevich, bmstu).
student(konstantin, knyazev, bespalovich, mipt).
student(german, trofimov, semenovich, itmo).
student(kirill, avdeev, osipovich, mipt).
student(andrew, ivanov, grigorievich, tsu).
student(pavel, ivanov, pavlovich, itmo).
student(konstantin, yakushev, samoilovich, nsu).
student(pavel, knyazev, bespalovich, mepi).
student(german, odintsov, bespalovich, bmstu).
student(alexander, ivanov, pavlovich, nsu).

person(Name, Surname, Lastname, University, Phone):-student(Name, Surname, Lastname, University),phone(Name, Surname, Lastname, Phone).
goal	
person(Name, Surname, Lastname, University, "8(441)-495-69-57").