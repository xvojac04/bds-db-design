-- -----------------------------------------------------
-- DROP TABLES
-- -----------------------------------------------------
DROP TABLE IF EXISTS public.user;
DROP TABLE IF EXISTS public.state;
DROP TABLE IF EXISTS public.contact_r;
DROP TABLE IF EXISTS public.contact_w;
DROP TABLE IF EXISTS public.address;
DROP TABLE IF EXISTS public.reader;
DROP TABLE IF EXISTS public.library;
DROP TABLE IF EXISTS public.role;
DROP TABLE IF EXISTS public.worker;
DROP TABLE IF EXISTS public.type;
DROP TABLE IF EXISTS public.writer;
DROP TABLE IF EXISTS public.book;
DROP TABLE IF EXISTS public.bookwriter;
DROP TABLE IF EXISTS public.booktype;
DROP TABLE IF EXISTS public.borrow;



-- -----------------------------------------------------
-- CREATE TABLES
-- -----------------------------------------------------

CREATE TABLE public.user(
    user_id SERIAL NOT NULL,
    name VARCHAR(64) NOT NULL,
    surname VARCHAR(64) NOT NULL,
    password VARCHAR(64) NOT NULL,
    PRIMARY KEY(user_id));
ALTER TABLE public.user OWNER TO postgres;

CREATE TABLE public.state(
    state_id SERIAL NOT NULL,
    name VARCHAR(64) NOT NULL,
    PRIMARY KEY(state_id));
ALTER TABLE public.state OWNER TO postgres;

CREATE TABLE public.contact_r(
    contact_r_id SERIAL NOT NULL,
    mail VARCHAR(128) NOT NULL,
    phone INTEGER NULL,
    PRIMARY KEY(contact_r_id));
ALTER TABLE public.contact_r OWNER TO postgres;

CREATE TABLE public.contact_w(
    contact_w_id SERIAL NOT NULL,
    mail VARCHAR(128)NOT NULL,
    phone INTEGER NOT NULL,
    photo VARCHAR(128) NULL,
    PRIMARY KEY(contact_w_id));
ALTER TABLE public.contact_w OWNER TO postgres;

CREATE TABLE public.address(
    address_id SERIAL NOT NULL,
    state_id SERIAL NOT NULL,
    city VARCHAR(64) NOT NULL,
    street VARCHAR(64) NOT NULL,
    zipcode VARCHAR(32) NOT NULL,
    house_number VARCHAR(32) NOT NULL,
    CONSTRAINT fk_address_state
        FOREIGN KEY (state_id)
        REFERENCES public.state (state_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    PRIMARY KEY(address_id));
ALTER TABLE public.address OWNER TO postgres;

CREATE TABLE public.reader(
    reader_id SERIAL NOT NULL,
    first_name VARCHAR(64) NOT NULL,
    surname VARCHAR(64) NOT NULL,
    address_id SERIAL NOT NULL,
    contact_r_id SERIAL NOT NULL,
    CONSTRAINT fk_reader_address
        FOREIGN KEY (address_id)
        REFERENCES public.address (address_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_reader_contact
        FOREIGN KEY (contact_r_id)
        REFERENCES public.contact_R (contact_r_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    PRIMARY KEY(reader_id));
ALTER TABLE public.reader OWNER TO postgres;

CREATE TABLE public.library(
    library_id SERIAL NOT NULL,
    name VARCHAR(64) NOT NULL,
    address_id SERIAL NOT NULL,
    CONSTRAINT fk_library_address
        FOREIGN KEY (address_id)
        REFERENCES public.address (address_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    PRIMARY KEY(library_id));
ALTER TABLE public.library OWNER TO postgres;

CREATE TABLE public.role(
    role_id SERIAL NOT NULL,
    role VARCHAR(64) NOT NULL,
    salary INTEGER NOT NULL,
    PRIMARY KEY(role_id));
ALTER TABLE public.role OWNER TO postgres;

CREATE TABLE public.worker(
    worker_id SERIAL NOT NULL,
    first_name VARCHAR(64) NOT NULL,
    surname VARCHAR(64) NOT NULL,
    role_id SERIAL NOT NULL,
    library_id SERIAL NOT NULL,
    address_id SERIAL NOT NULL,
    contact_w_id SERIAL NOT NULL,
    CONSTRAINT fk_worker_role
        FOREIGN KEY (role_id)
        REFERENCES public.role (role_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_worker_library
        FOREIGN KEY (library_id)
        REFERENCES public.library (library_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_worker_address
        FOREIGN KEY (address_id)
        REFERENCES public.address (address_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_worker_contact
        FOREIGN KEY (contact_w_id)
        REFERENCES public.contact_w (contact_w_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    PRIMARY KEY(worker_id));
ALTER TABLE public.worker OWNER TO postgres;

CREATE TABLE public.type(
    type_id SERIAL NOT NULL,
    type VARCHAR(32) NOT NULL,
    PRIMARY KEY(type_id));
ALTER TABLE public.type OWNER TO postgres;

CREATE TABLE public.writer(
    writer_id SERIAL NOT NULL,
    first_name VARCHAR(64) NOT NULL,
    surname VARCHAR(64) NOT NULL,
    PRIMARY KEY(writer_id));
ALTER TABLE public.writer OWNER TO postgres;

CREATE TABLE public.book(
    book_id SERIAL NOT NULL,
    title VARCHAR(64) NOT NULL,
    public_year SMALLINT NULL,
    PRIMARY KEY(book_id));
ALTER TABLE public.book OWNER TO postgres;

CREATE TABLE public.bookwriter(
    bookwriter_id SERIAL NOT NULL,
    book_id SERIAL NOT NULL,
    writer_id SERIAL NOT NULL,
    CONSTRAINT fk_bookwriter_book
        FOREIGN KEY (book_id)
        REFERENCES public.book (book_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_bookwriter_writer
        FOREIGN KEY (writer_id)
        REFERENCES public.writer (writer_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    PRIMARY KEY(bookwriter_id));
ALTER TABLE public.bookwriter OWNER TO postgres;

CREATE TABLE public.booktype(
    booktype_id SERIAL NOT NULL,
    book_id SERIAL NOT NULL,
    type_id SERIAL NOT NULL,
    CONSTRAINT fk_booktype_book
        FOREIGN KEY (book_id)
        REFERENCES public.book (book_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_booktype_type
        FOREIGN KEY (type_id)
        REFERENCES public.type (type_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    PRIMARY KEY(booktype_id));
ALTER TABLE public.booktype OWNER TO postgres;


CREATE TABLE public.borrow(
    borrow_id SERIAL NOT NULL,
    borrow_date TIMESTAMP NOT NULL,
    return_date TIMESTAMP NULL,
    book_id SERIAL NOT NULL,
    reader_id SERIAL NOT NULL,
    CONSTRAINT fk_borrow_book
        FOREIGN KEY (book_id)
        REFERENCES public.book (book_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_borrow_reader
        FOREIGN KEY (reader_id)
        REFERENCES public.reader (reader_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    PRIMARY KEY(borrow_id));
ALTER TABLE public.borrow OWNER TO postgres;

-- -----------------------------------------------------
-- INSERT
-- -----------------------------------------------------
INSERT INTO public.user(name, surname, password) VALUES ('Leo', 'Express', 'aXqB3');
INSERT INTO public.user(name, surname, password) VALUES ('Reggio', 'Jetson', 'password');
INSERT INTO public.user(name, surname, password) VALUES ('Adam', 'Slow', 'qwerty');
INSERT INTO public.user(name, surname, password) VALUES ('Antony', 'Depress', '12345');
INSERT INTO public.user(name, surname, password) VALUES ('Mickey', 'Mouse', 'minnie#1945');


INSERT INTO public.contact_r (mail, phone) VALUES ('little_puppy@email.com', 774071309);
INSERT INTO public.contact_r (mail, phone) VALUES ('fluffyunicorn@emailaddress.com', 774071309);
INSERT INTO public.contact_r (mail, phone) VALUES ('happy_doplhin@seznam.cz', 774071309);
INSERT INTO public.contact_r (mail, phone) VALUES ('bigmouse@google.com', 774071309);
INSERT INTO public.contact_r (mail, phone) VALUES ('small_lizard@google.com', 774071309);
INSERT INTO public.contact_r (mail, phone) VALUES ('m_personal@library.com', 123456);
INSERT INTO public.contact_r (mail, phone) VALUES ('g_query@library.com', 65432);

INSERT INTO public.contact_w (mail, phone, photo) VALUES ('a_marie@library.com', 41522322, 'C:/workers/marie.jpg');
INSERT INTO public.contact_w (mail, phone, photo) VALUES ('m_newmann@library.com', 774071, 'C:/workers/newmann.jpg');
INSERT INTO public.contact_w (mail, phone) VALUES ('d_optal@library.com', 555525);
INSERT INTO public.contact_w (mail, phone) VALUES ('m_personal@library.com', 123456);
INSERT INTO public.contact_w (mail, phone) VALUES ('g_query@library.com', 65432);
INSERT INTO public.contact_w (mail, phone) VALUES ('little_puppy@email.com', 774071309);
INSERT INTO public.contact_w (mail, phone) VALUES ('fluffyunicorn@emailaddress.com', 774071309);

INSERT INTO public.state(name) VALUES ('Czech');
INSERT INTO public.state(name) VALUES ('England');
INSERT INTO public.state(name) VALUES ('Rome');
INSERT INTO public.state(name) VALUES ('Spain');
INSERT INTO public.state(name) VALUES ('Finland');
INSERT INTO public.state(name) VALUES ('Austria');
INSERT INTO public.state(name) VALUES ('Hungary');

INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (2,'London', 'Endless', 'E1 7AY', '1758');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Prague', 'Old Town Square', '602 00', '456');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (3,'Rome', 'Holloway', '888 856', '5/13A');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (4,'Barcelona', 'Finsbury', 'M3M T73', '175');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (5,'Helsinki', 'Wamforts', '12 34A', '3/13');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Brno', 'Cervinkova', '600 06', '12');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Brno', 'Samilasso', '600 06', '113');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Olomouc', 'New Street', '765 00', '378');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Olomouc', 'Old Street', '765 00', '873/A');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Brno', 'Skacelova', '600 06', '101');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Mrsklesy', 'Mrsklesy', '783 65', '515');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Bystrc', 'Lesna', '600 06', '786/A');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Bystrice', '8. May', '783 65', '899');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Chvalkovice', '8.kvetna', '783 65', '3');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Cernovir', 'Wamforts', '777 66', '2');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Chernobyl', 'Radioactive', '12 12 12', '13A');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Kromeriz', 'Zlinska', '555 45', '5');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Brno', 'Vlhka', '606 06', '6');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (2,'Manchester', 'Wamforts', 'E2 YA7', '41');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Jihlava', 'Nova', '666 66', '6');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Zlin', 'Ulicna', '333 33', '3');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Otrokovice', 'Ulicnicka', '323 23', '23');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Otrokovice', 'Ulicnakova', '323 23', '32');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Zlin', 'ABC', '323 32', '56');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Pisek', 'BCAA', '123 45', '65');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Jihlava', 'ACB', '773 21', '415');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Brnicko', 'Brnenska', '456 78', '89');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Male Brno', 'Olomoucka', '546 78', '98');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Velke Brno', 'Prazska', '606 06', '61/3');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Brnein', 'Nekonecna', '606 00', '13A');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Brno', 'Wamfortska', '333 44', '5');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Praha venkov', 'Vesnicka', '606 00', '45');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (6,'Wien', 'Wamforts', 'MP 783', '331A');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Odbocka na Viden', 'D1', '678 90', '3/13');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Vesnice', 'Vesnicka', '12 341', '9');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Sternberk', 'Sternberska', '345 67', '87');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Stramberk', 'Namesti miru', '988 98', '777');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Sumperk', 'Namesti republiky', '989 89', '90A');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Ostrava', 'Trida Klidu', '425 21', '19');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Opava', 'Trida Svornosti', '234 45', '919');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Ostrice', 'Trida Miru', '456 76', '65');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Ostrakovice', 'Novakova', '789 98', '56');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Trinec', 'Opavska', '776 00', '344');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Trsice', 'Ostravska', '789 88', '433');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Trnava', 'Spanelska', '12 123', '234');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Brno', 'Finska', '568 90', '432');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (1,'Brno', 'Ceska', '546 78', '124');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (7,'Trnava', 'Myslitelova', '123 456', '421');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (7,'Bratislava', 'Novosadska', '998 067', '876');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (7,'Trnava', 'Slovenska', '556 789', '604');
INSERT INTO public.address(state_id, city, street, zipcode, house_number) VALUES (7,'Bratislava', 'Polska', '123 546', '789');




INSERT INTO public.reader(first_name, surname, address_id, contact_r_id) VALUES ('Kevin', 'Minion', 6, 1);
INSERT INTO public.reader(first_name, surname, address_id, contact_r_id) VALUES ('Shrek', 'Ogre', 7, 2);
INSERT INTO public.reader(first_name, surname, address_id, contact_r_id) VALUES ('Fiona', 'Ogre', 8, 3);
INSERT INTO public.reader(first_name, surname, address_id, contact_r_id) VALUES ('Doris', 'Fish', 9, 4);
INSERT INTO public.reader(first_name, surname, address_id, contact_r_id) VALUES ('Bob Robert', 'Minion', 10, 5);


INSERT INTO public.library (name, address_id) VALUES ('Library of Bukowski', 1);
INSERT INTO public.library (name, address_id) VALUES ('Library of Golden', 2);
INSERT INTO public.library (name, address_id) VALUES ('Library of King', 3);
INSERT INTO public.library (name, address_id) VALUES ('Library of Bryndza', 4);
INSERT INTO public.library (name, address_id) VALUES ('Library of Green', 5);


INSERT INTO public.role (role, salary) VALUES ('Librarian', 18500);
INSERT INTO public.role (role, salary) VALUES ('Bookkeeper', 21500);
INSERT INTO public.role (role, salary) VALUES ('Manager', 30000);
INSERT INTO public.role (role, salary) VALUES ('Charlady', 14500);
INSERT INTO public.role (role, salary) VALUES ('Receptionist', 19000);


INSERT INTO public.worker (first_name, surname, role_id, library_id, address_id, contact_w_id) VALUES ('Anna', 'Marie', 1, 3, 1, 1);
INSERT INTO public.worker (first_name, surname, role_id, library_id, address_id, contact_w_id) VALUES ('Martin', 'Newmann', 1, 3, 2, 2);
INSERT INTO public.worker (first_name, surname, role_id, library_id, address_id, contact_w_id) VALUES ('Daniel', 'Optal', 2, 3, 3, 3);
INSERT INTO public.worker (first_name, surname, role_id, library_id, address_id, contact_w_id) VALUES ('Miguel', 'Personal', 4, 3, 5, 4);
INSERT INTO public.worker (first_name, surname, role_id, library_id, address_id, contact_w_id) VALUES ('George', 'Query', 5, 4, 4, 5);


INSERT INTO public.type (type) VALUES ('Sci-fi');
INSERT INTO public.type (type) VALUES ('Romantic');
INSERT INTO public.type (type) VALUES ('Fantasy');
INSERT INTO public.type (type) VALUES ('Horror');
INSERT INTO public.type (type) VALUES ('Drama');


INSERT INTO public.writer(first_name, surname) VALUES ('Sheldon', 'Platon');
INSERT INTO public.writer(first_name, surname) VALUES ('Sandy', 'Cheeks');
INSERT INTO public.writer(first_name, surname) VALUES ('Eugine', 'Crabs');
INSERT INTO public.writer(first_name, surname) VALUES ('Spongebob', 'Squarepants');
INSERT INTO public.writer(first_name, surname) VALUES ('Squidward', 'Tentacles');


INSERT INTO public.book(title, public_year) VALUES ('How to make crusty crab', 1992);
INSERT INTO public.book(title, public_year) VALUES ('How to steal crusty crab', 1991);
INSERT INTO public.book(title, public_year) VALUES ('How to eat crusty crab', 1987);
INSERT INTO public.book(title, public_year) VALUES ('How be always happy', 1990);
INSERT INTO public.book(title, public_year) VALUES ('How to make spaceship', 1995);
INSERT INTO public.book(title, public_year) VALUES ('How to make time machine', 1999);
INSERT INTO public.book(title, public_year) VALUES ('Who is my neighbor?', 1997);
INSERT INTO public.book(title, public_year) VALUES ('I hate my neighbor', 1998);
INSERT INTO public.book(title, public_year) VALUES ('Something', 2000);
INSERT INTO public.book(title, public_year) VALUES ('How to be amazing artist', 2001);
INSERT INTO public.book(title, public_year) VALUES ('How to become scientist', 2010);
INSERT INTO public.book(title, public_year) VALUES ('How to win music awards', 2020);
INSERT INTO public.book(title, public_year) VALUES ('How to anything', 2021);
INSERT INTO public.book(title, public_year) VALUES ('How to survive pandemic', 2019);
INSERT INTO public.book(title, public_year) VALUES ('How to make it stop', 1992);
INSERT INTO public.book(title, public_year) VALUES ('How to make it stop 2', 1999);
INSERT INTO public.book(title, public_year) VALUES ('How to make it stop 3', 2020);
INSERT INTO public.book(title, public_year) VALUES ('Let it snow', 1456);
INSERT INTO public.book(title, public_year) VALUES ('Let it die', 1776);
INSERT INTO public.book(title, public_year) VALUES ('Napoleon was fool', 1887);
INSERT INTO public.book(title, public_year) VALUES ('VUT is better than MUNI', 1888);
INSERT INTO public.book(title, public_year) VALUES ('MUNI is better than VUT', 1889);
INSERT INTO public.book(title, public_year) VALUES ('UTB is here too', 2005);
INSERT INTO public.book(title, public_year) VALUES ('We dont talk about it', 2005);
INSERT INTO public.book(title, public_year) VALUES ('Harry Potter', 2003);
INSERT INTO public.book(title, public_year) VALUES ('Harry Potter 2', 2013);
INSERT INTO public.book(title, public_year) VALUES ('Harry Potter 3', 2014);
INSERT INTO public.book(title, public_year) VALUES ('Grinch', 2014);
INSERT INTO public.book(title, public_year) VALUES ('This', 1992);
INSERT INTO public.book(title, public_year) VALUES ('Book', 1992);
INSERT INTO public.book(title, public_year) VALUES ('Is', 1992);
INSERT INTO public.book(title, public_year) VALUES ('Fvckng', 1992);
INSERT INTO public.book(title, public_year) VALUES ('Lit', 1992);
INSERT INTO public.book(title, public_year) VALUES ('Just girly things', 1995);
INSERT INTO public.book(title, public_year) VALUES ('Just boys things', 1999);
INSERT INTO public.book(title, public_year) VALUES ('It', 1997);
INSERT INTO public.book(title, public_year) VALUES ('This is spoiler', 1996);
INSERT INTO public.book(title, public_year) VALUES ('And this too', 1993);
INSERT INTO public.book(title, public_year) VALUES ('Doctor Who', 1994);
INSERT INTO public.book(title, public_year) VALUES ('How to build tardis', 1991);
INSERT INTO public.book(title, public_year) VALUES ('Meatlovers', 1999);
INSERT INTO public.book(title, public_year) VALUES ('Breakfast club', 2000);
INSERT INTO public.book(title, public_year) VALUES ('TinTin', 2020);
INSERT INTO public.book(title, public_year) VALUES ('Phineas and Ferb', 2018);
INSERT INTO public.book(title, public_year) VALUES ('Overthinking', 1982);
INSERT INTO public.book(title, public_year) VALUES ('Futurella', 1972);
INSERT INTO public.book(title, public_year) VALUES ('SpongeBob', 1962);
INSERT INTO public.book(title, public_year) VALUES ('Mickey Mouse', 1952);
INSERT INTO public.book(title, public_year) VALUES ('Tangled', 1942);
INSERT INTO public.book(title, public_year) VALUES ('SnowWhite', 1932);


INSERT INTO public.bookwriter (book_id, writer_id) VALUES (1,4);
INSERT INTO public.bookwriter (book_id, writer_id) VALUES (5,2);
INSERT INTO public.bookwriter (book_id, writer_id) VALUES (2,1);
INSERT INTO public.bookwriter (book_id, writer_id) VALUES (4,3);
INSERT INTO public.bookwriter (book_id, writer_id) VALUES (8,5);


INSERT INTO public.booktype (book_id, type_id) VALUES (1,2);
INSERT INTO public.booktype (book_id, type_id) VALUES (2,5);
INSERT INTO public.booktype (book_id, type_id) VALUES (3,1);
INSERT INTO public.booktype (book_id, type_id) VALUES (4,2);
INSERT INTO public.booktype (book_id, type_id) VALUES (5,1);


INSERT INTO public.borrow (borrow_date, return_date, book_id, reader_id) VALUES ('2017-03-14', '2017-04-23', 1, 1);
INSERT INTO public.borrow (borrow_date, return_date, book_id, reader_id) VALUES ('2016-03-23', '2016-04-19', 3, 2);
INSERT INTO public.borrow (borrow_date, return_date, book_id, reader_id) VALUES ('2017-06-13', '2017-08-14', 5, 5);
INSERT INTO public.borrow (borrow_date, return_date, book_id, reader_id) VALUES ('2017-08-27', '2017-09-19', 2, 3);
INSERT INTO public.borrow (borrow_date, return_date, book_id, reader_id) VALUES ('2017-08-27', '2017-10-19', 3, 3);

-- -----------------------------------------------------
-- QUERIES
-- -----------------------------------------------------
-- 1.1
SELECT city, street FROM public.address;

-- 1.2
SELECT r.first_name, r.surname
    FROM public.reader r
    JOIN public.contact_r cr ON r.contact_r_id = cr.contact_r_id
    WHERE cr.mail = 'fluffyunicorn@emailaddress.com';

SELECT w.first_name, w.surname
    FROM public.worker w
    JOIN public.contact_w cw ON w.contact_w_id = cw.contact_w_id
    WHERE cw.mail = 'm_newmann@library.com';

-- 1.3
UPDATE public.role SET salary = salary + 1750;
SELECT role, salary FROM public.role;

-- 1.4
SELECT first_name, surname FROM public.writer;
INSERT INTO public.writer(first_name, surname) VALUES ('Squilliam', 'Fancyson');

-- 1.5
SELECT writer_id, first_name, surname FROM public.writer;
DELETE FROM public.writer WHERE writer_id = 6;

-- 1.6
ALTER TABLE public.writer ADD COLUMN birth_year SMALLINT;
SELECT * FROM public.writer;

-- 1.7
SELECT r.first_name, r.surname FROM public.reader r WHERE surname = 'Ogre';

-- 1.8
SELECT title FROM public.book WHERE title LIKE '%Potter%';
SELECT city FROM public.address WHERE city NOT LIKE 'Brno';

-- 1.9
INSERT INTO public.writer (first_name, surname, birth_year) VALUES ('   Maximus  ','  Horse',2000);
UPDATE public.writer
    SET first_name = TRIM (first_name), surname = TRIM (surname);
SELECT first_name, surname FROM public.writer WHERE birth_year = 2000;

SELECT surname, SUBSTRING(first_name, 1, 1) FROM public.writer;

-- 1.10
SELECT COUNT(b.title), b.public_year
    FROM public.book b
    GROUP BY b.public_year
    ORDER BY b.public_year;

SELECT w.library_id,SUM(r.salary)
    FROM public.role r
    JOIN public.worker w ON r.role_id =w.role_id
    GROUP BY w.library_id;

SELECT MIN(salary) AS min_salary FROM public.role;
SELECT MAX(salary) AS max_salary FROM public.role;
SELECT AVG(salary) AS avg_salary FROM public.role;

-- 1.11
SELECT library_id, COUNT(worker_id) AS num_of_empl
    FROM public.worker
    GROUP BY library_id;

SELECT library_id, COUNT(worker_id) AS num_of_empl
    FROM public.worker
    GROUP BY library_id
    HAVING COUNT(worker_id)>1;

SELECT public_year, COUNT(title)
    FROM public.book
    WHERE public_year > 1999
    GROUP BY public_year
    HAVING COUNT(title)>1;

-- 1.12
SELECT mail, phone FROM contact_r
UNION ALL
SELECT mail, phone FROM contact_w;

-- 1.13

-- 1.14
SELECT r.first_name, r.surname, cr.mail, cr.phone
    FROM public.reader r
    LEFT JOIN public.contact_r cr ON r.contact_r_id = cr.contact_r_id;

SELECT r.first_name, r.surname, cr.mail, cr.phone
    FROM public.reader r
    RIGHT JOIN public.contact_r cr ON r.contact_r_id = cr.contact_r_id;

SELECT b.title, t.type
    FROM public.book b
    FULL OUTER JOIN booktype bt ON b.book_id = bt.book_id
    FULL OUTER JOIN type t ON bt.type_id = t.type_id;

-- 1.15
SELECT l.name, AVG(r.salary)
    FROM public.library l
    LEFT JOIN public.worker w ON l.library_id = w.library_id
    LEFT JOIN public.role r ON w.role_id = r.role_id
    GROUP BY l.name
    HAVING AVG(r.salary) > 0
    ORDER BY AVG(r.salary);

-- 1.16
INSERT INTO public.borrow (borrow_date, return_date, book_id, reader_id) VALUES ('2021-11-08', '2022-10-19', 3, 3);
INSERT INTO public.borrow (borrow_date, book_id, reader_id) VALUES ('2021-11-07', 4, 4);
SELECT borrow_date, book_id, reader_id
    FROM public.borrow
    WHERE borrow_date > now() - interval '36 hours';

-- 1.17
INSERT INTO public.borrow (borrow_date, book_id, reader_id) VALUES ('2021-10-01', 12, 2);
INSERT INTO public.borrow (borrow_date, book_id, reader_id) VALUES ('2021-10-31', 12, 2);
SELECT borrow_date, book_id, reader_id
    FROM public.borrow
    WHERE borrow_date >= date_trunc('month', current_date - interval '1' month)
        and borrow_date < date_trunc('month', current_date);

-- 1.18
INSERT INTO public.writer (first_name, surname, birth_year) VALUES ('Evžen', 'Houžvička', 1998);
SELECT first_name, surname FROM public.writer WHERE first_name = 'Evžen';
CREATE EXTENSION unaccent;

SELECT first_name, unaccent(surname) FROM public.writer WHERE unaccent(surname) = unaccent('Houžvička');
UPDATE public.writer SET first_name = unaccent(first_name);

-- 1.19
SELECT city, street FROM public.address
    ORDER BY address_id
    LIMIT 5
    OFFSET (2 - 1) * 5;

-- 1.20
SELECT abc.first_name, abc.surname, abc.city
    FROM (SELECT w.first_name, w.surname, a.city, a.street, a.zipcode
            FROM public.worker w
            JOIN public.address a ON w.address_id = a.address_id) abc
    WHERE zipcode = '606 06';

-- 1.21
SELECT w.first_name, w.surname, r.salary
    FROM public.worker w
    JOIN public.role r ON w.role_id = r.role_id
    WHERE r.salary > (SELECT AVG(ro. salary) FROM public.role ro);

-- 1.22
SELECT l.name, COUNT(w.worker_id), AVG(r.salary) AS num_of_empl
    FROM public.worker w
    JOIN public.role r ON r.role_id = w.role_id
    JOIN public.library l ON l.library_id = w.library_id
    GROUP BY l.name
    HAVING COUNT(w.worker_id) > 1;

-- 1.23
SELECT br.borrow_id, r.first_name, r.surname, bk.title, t.type, w.first_name AS AuthorName, w.surname AS AuthorSurname
    FROM public.borrow br
    JOIN public.reader r ON br.reader_id = r.reader_id
    JOIN public.book bk ON br.book_id = bk.book_id
    JOIN public.bookwriter bw ON bk.book_id =bw.book_id
    JOIN public.writer w ON bw.writer_id = w.writer_id
    JOIN public.booktype bt ON bk.book_id = bt.book_id
    JOIN public.type t ON bt.type_id = t.type_id;

-- 1.24
SELECT l.name, COUNT(w.worker_id) AS num_of_empl
    FROM public.worker w
    JOIN public.library l ON w.library_id = l.library_id
    JOIN public.role r ON r.role_id = w.role_id
    WHERE r.salary > 15000
    GROUP BY l.name
    HAVING COUNT(w.worker_id) > 1;


-- 2


-- 3
EXPLAIN SELECT b.borrow_id, b.borrow_date, b.book_id, b.reader_id FROM public.borrow b WHERE borrow_date = '2021-10-01';
DROP INDEX IF EXISTS date_index;
CREATE INDEX IF NOT EXISTS date_index ON public.borrow USING btree(borrow_date);
CREATE INDEX IF NOT EXISTS date_index ON public.borrow(borrow_date);

-- 4


-- 5
CREATE OR REPLACE FUNCTION salary_verification_func()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
AS
$$
BEGIN
	IF NEW.salary < 0 THEN
		    RAISE EXCEPTION 'Salary must be positive.';
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER salary_varification
    BEFORE INSERT ON public.role
    FOR EACH ROW EXECUTE PROCEDURE salary_verification_func();

INSERT INTO role(salary) VALUES(-100);

-- 6
DROP VIEW IF EXISTS worker_info;
CREATE VIEW worker_info
    AS SELECT w.first_name, w.surname, l.name, cw.mail
    FROM public.worker w
    JOIN public.contact_w cw ON w.contact_w_id = cw.contact_w_id
    JOIN public.library l ON w.library_id = l.library_id;
SELECT * FROM worker_info;

-- 7
CREATE MATERIALIZED VIEW something AS SELECT ...;

-- 8
DROP ROLE IF EXISTS teacher;
CREATE ROLE teacher NOSUPERUSER;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.role TO teacher;

DROP ROLE IF EXISTS student;
CREATE ROLE student NOSUPERUSER;
GRANT SELECT ON public.borrow, public.book TO student;


