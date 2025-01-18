Create table Jalu_chaudhary(
    id number (6) primary key,
    first_name VARCHAR2 (30) not null,
    last_name VARCHAR2 (50),
    email char(50) unique,
    birth_date DATE

);
INSERT INTO Jalu_chaudhary (id, first_name, last_name, email, birth_date)
VALUES (1, 'Jalu', 'Chaudhary', 'jcahudh@email.com', TO_DATE('2000-01-01', 'YYYY-MM-DD'));

INSERT INTO Jalu_chaudhary (id, first_name, email)
VALUES (5, 'Anjali', 'anjali@email.com');

update JALU_CHAUDHARY
set first_name = 'Pooja updated', email = 'tharu.poja@gmail.com'
where id= 4;
 delete from JALU_CHAUDHARY where id= 5;
 
 COMMIT;
 ROLLBACK;
 DROP TABLE Jalu_chaudhary;
 SELECT*
 FROM JALU_CHAUDHARY;