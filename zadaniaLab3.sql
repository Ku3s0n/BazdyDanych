create table pracownik (
	id_pracownika Int primary key auto_increment,
	imie varchar(40) not null,
    nazwisko varchar(60) not null,
    data_urodzenia date not null
);

insert into pracownik (imie, nazwisko, data_urodzenia) 
	values 
	('Jakub', 'Nowak', '1998-04-27'),
    ('Bartosz', 'Kikut', '2002-11-04'),
    ('Kamil', 'Git', '2006-10-21');
    
    select * from pracownik;
    
update pracownik set data_urodzenia = '2006-11-20' where id_pracownika = 1;

create table zadanie (
	id_zadania Int primary key auto_increment,
	nazwa_zadania varchar(150) not null,
    priorytet enum('normalny', 'wysoki', 'niski'),
    opis text,
    pracownik int,
    FOREIGN KEY(pracownik) 
    references pracownik(id_pracownika)
    on delete set null
);

Alter table zadanie
modify column priorytet enum('normalny', 'wysoki', 'niski') default 'normalny';

insert into zadanie (nazwa_zadania, priorytet, opis, pracownik) 
Values 
('Przygotowanie raportu miesięcznego', 'wysoki', 'Aanaliza wyników finansowych', 1),
('Aktualizacja bazy klientów', 'normalny', 'Weryfikacja danych adresowych', 2),
('Przegląd sprzętu biurowego', 'niski', 'Inwentaryzacja stanowisk pracy', 3);


create table sprint (
	id_sprintu Int primary key auto_increment,
	numer_sprintu int unsigned,
	data_rozpoczecia date,
    data_zakonczenia date
);

alter user 'infs_kowalskij'@'localhost' identified by 'A@sd12396';

alter table zadanie add column sprint int, 
add FOREIGN KEY(sprint) references sprint(id_sprintu)
on delete set null;

insert into sprint (numer_sprintu, data_rozpoczecia, data_zakonczenia )
Values (1, '2026-10-28', '2026-10-29');

update zadanie set sprint = 1 where id_zadania in (1, 2);

