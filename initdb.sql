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


INSERT INTO public.contact_w (mail, phone, photo) VALUES ('a_marie@library.com', 41522322, 'C:/workers/marie.jpg');
INSERT INTO public.contact_w (mail, phone, photo) VALUES ('m_newmann@library.com', 774071, 'C:/workers/newmann.jpg');
INSERT INTO public.contact_w (mail, phone) VALUES ('d_optal@library.com', 555525);
INSERT INTO public.contact_w (mail, phone) VALUES ('m_personal@library.com', 123456);
INSERT INTO public.contact_w (mail, phone) VALUES ('g_query@library.com', 65432);

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
SELECT city, street FROM public.address;

SELECT r.first_name, r.surname
    FROM public.reader r
    JOIN public.contact_r cr ON r.contact_r_id = cr.contact_r_id
    WHERE cr.mail = 'fluffyunicorn@emailaddress.com';

UPDATE public.role SET salary = salary + 1750;
SELECT role, salary FROM public.role;

SELECT first_name, surname FROM public.writer;
INSERT INTO public.writer(first_name, surname) VALUES ('Squilliam', 'Fancyson');

SELECT writer_id, first_name, surname FROM public.writer;
DELETE FROM public.writer WHERE writer_id = 6;

ALTER TABLE public.writer ADD COLUMN birth_year SMALLINT;
SELECT * FROM public.writer;

