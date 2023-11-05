CREATE TABLE SVY_t
(
  x number(3) PRIMARY KEY,
  s varchar2(50)
);



INSERT INTO SVY_t (x, s) VALUES (1, 'Vlad');
INSERT INTO SVY_t (x, s) VALUES (2, 'Alex');
INSERT INTO SVY_t (x, s) VALUES (3, 'Anton');
COMMIT;

UPDATE SVY_t SET s='Vera' where x = 2;
UPDATE SVY_t SET s='Oleg' where x = 3;
COMMIT;

SELECT x FROM SVY_t WHERE s = 'Vera';
SELECT COUNT(*) AS Row_Count FROM SVY_t;

DELETE FROM SVY_t where x = 3;
COMMIT;

CREATE TABLE SVY_t1
(
  student_id number(3) CONSTRAINT fk_id REFERENCES SVY_t(x),
  speciality varchar2(10)
);

INSERT INTO SVY_t1 (student_id, speciality) VALUES (1, 'ПОИТ');
INSERT INTO SVY_t1 (student_id, speciality) VALUES (2, 'ИСиТ');
COMMIT;

SELECT s, speciality FROM SVY_t LEFT OUTER JOIN SVY_t1 on SVY_t.x = SVY_t1.student_id;
SELECT s, speciality FROM SVY_t RIGHT OUTER JOIN SVY_t1 on SVY_t.x = SVY_t1.student_id;
SELECT s, speciality FROM SVY_t INNER JOIN SVY_t1 on SVY_t.x = SVY_t1.student_id;

DROP TABLE SVY_t;
DROP TABLE SVY_t1;