ALTER SESSION SET nls_date_format = 'DD-MM-YYYY';

------------------------------------ Задание №1

ALTER TABLE TEACHER
    add BIRTHDAY date;
ALTER TABLE TEACHER
    add SALARY number;

UPDATE TEACHER
SET BIRTHDAY = '08-04-1966'
WHERE TEACHER = 'СМЛВ';
UPDATE TEACHER
SET BIRTHDAY = '23-03-1989'
WHERE TEACHER = 'АКНВЧ';
UPDATE TEACHER
SET BIRTHDAY = '06-01-1994'
WHERE TEACHER = 'КЛСНВ';
UPDATE TEACHER
SET BIRTHDAY = '13-04-1975'
WHERE TEACHER = 'ГРМН';
UPDATE TEACHER
SET BIRTHDAY = '13-07-1998'
WHERE TEACHER = 'ЛЩНК';
UPDATE TEACHER
SET BIRTHDAY = '05-10-1966'
WHERE TEACHER = 'БРКВЧ';
UPDATE TEACHER
SET BIRTHDAY = '10-08-1976'
WHERE TEACHER = 'ДДК';
UPDATE TEACHER
SET BIRTHDAY = '11-09-1989'
WHERE TEACHER = 'КБЛ';
UPDATE TEACHER
SET BIRTHDAY = '24-12-1983'
WHERE TEACHER = 'УРБ';
UPDATE TEACHER
SET BIRTHDAY = '03-06-1990'
WHERE TEACHER = 'РМНК';
UPDATE TEACHER
SET BIRTHDAY = '10-05-1970'
WHERE TEACHER = 'ПСТВЛВ';
UPDATE TEACHER
SET BIRTHDAY = '26-10-1999'
WHERE TEACHER = '?';
UPDATE TEACHER
SET BIRTHDAY = '30-07-1984'
WHERE TEACHER = 'ГРН';
UPDATE TEACHER
SET BIRTHDAY = '11-03-1975'
WHERE TEACHER = 'ЖЛК';
UPDATE TEACHER
SET BIRTHDAY = '12-07-1969'
WHERE TEACHER = 'БРТШВЧ';
UPDATE TEACHER
SET BIRTHDAY = '26-02-1983'
WHERE TEACHER = 'ЮДНКВ';
UPDATE TEACHER
SET BIRTHDAY = '13-12-1991'
WHERE TEACHER = 'БРНВСК';
UPDATE TEACHER
SET BIRTHDAY = '20-01-1968'
WHERE TEACHER = 'НВРВ';
UPDATE TEACHER
SET BIRTHDAY = '21-12-1969'
WHERE TEACHER = 'РВКЧ';
UPDATE TEACHER
SET BIRTHDAY = '28-01-1975'
WHERE TEACHER = 'ДМДК';
UPDATE TEACHER
SET BIRTHDAY = '10-07-1983'
WHERE TEACHER = 'МШКВСК';
UPDATE TEACHER
SET BIRTHDAY = '08-10-1988'
WHERE TEACHER = 'ЛБХ';
UPDATE TEACHER
SET BIRTHDAY = '30-07-1984'
WHERE TEACHER = 'ЗВГЦВ';
UPDATE TEACHER
SET BIRTHDAY = '16-04-1964'
WHERE TEACHER = 'БЗБРДВ';
UPDATE TEACHER
SET BIRTHDAY = '12-05-1985'
WHERE TEACHER = 'ПРКПЧК';
UPDATE TEACHER
SET BIRTHDAY = '20-10-1980'
WHERE TEACHER = 'НСКВЦ';
UPDATE TEACHER
SET BIRTHDAY = '21-08-1990'
WHERE TEACHER = 'МХВ';
UPDATE TEACHER
SET BIRTHDAY = '13-08-1966'
WHERE TEACHER = 'ЕЩНК';
UPDATE TEACHER
SET BIRTHDAY = '11-11-1978'
WHERE TEACHER = 'ЖРСК';

UPDATE TEACHER
SET SALARY = 1030
WHERE TEACHER = 'СМЛВ';
UPDATE TEACHER
SET SALARY = 1030
WHERE TEACHER = 'АКНВЧ';
UPDATE TEACHER
SET SALARY = 980
WHERE TEACHER = 'КЛСНВ';
UPDATE TEACHER
SET SALARY = 1050
WHERE TEACHER = 'ГРМН';
UPDATE TEACHER
SET SALARY = 590
WHERE TEACHER = 'ЛЩНК';
UPDATE TEACHER
SET SALARY = 870
WHERE TEACHER = 'БРКВЧ';
UPDATE TEACHER
SET SALARY = 815
WHERE TEACHER = 'ДДК';
UPDATE TEACHER
SET SALARY = 995
WHERE TEACHER = 'КБЛ';
UPDATE TEACHER
SET SALARY = 1460
WHERE TEACHER = 'УРБ';
UPDATE TEACHER
SET SALARY = 1120
WHERE TEACHER = 'РМНК';
UPDATE TEACHER
SET SALARY = 1250
WHERE TEACHER = 'ПСТВЛВ';
UPDATE TEACHER
SET SALARY = 333
WHERE TEACHER = '?';
UPDATE TEACHER
SET SALARY = 1520
WHERE TEACHER = 'ГРН';
UPDATE TEACHER
SET SALARY = 1430
WHERE TEACHER = 'ЖЛК';
UPDATE TEACHER
SET SALARY = 900
WHERE TEACHER = 'БРТШВЧ';
UPDATE TEACHER
SET SALARY = 875
WHERE TEACHER = 'ЮДНКВ';
UPDATE TEACHER
SET SALARY = 970
WHERE TEACHER = 'БРНВСК';
UPDATE TEACHER
SET SALARY = 780
WHERE TEACHER = 'НВРВ';
UPDATE TEACHER
SET SALARY = 1150
WHERE TEACHER = 'РВКЧ';
UPDATE TEACHER
SET SALARY = 805
WHERE TEACHER = 'ДМДК';
UPDATE TEACHER
SET SALARY = 905
WHERE TEACHER = 'МШКВСК';
UPDATE TEACHER
SET SALARY = 1200
WHERE TEACHER = 'ЛБХ';
UPDATE TEACHER
SET SALARY = 1500
WHERE TEACHER = 'ЗВГЦВ';
UPDATE TEACHER
SET SALARY = 905
WHERE TEACHER = 'БЗБРДВ';
UPDATE TEACHER
SET SALARY = 715
WHERE TEACHER = 'ПРКПЧК';
UPDATE TEACHER
SET SALARY = 880
WHERE TEACHER = 'НСКВЦ';
UPDATE TEACHER
SET SALARY = 735
WHERE TEACHER = 'МХВ';
UPDATE TEACHER
SET SALARY = 595
WHERE TEACHER = 'ЕЩНК';
UPDATE TEACHER
SET SALARY = 850
WHERE TEACHER = 'ЖРСК';


------------------------------------ Задание №2
SELECT regexp_substr(teacher_name, '(\S+)', 1, 1) || ' ' ||
       substr(regexp_substr(teacher_name, '(\S+)', 1, 2), 1, 1) || '. ' ||
       substr(regexp_substr(teacher_name, '(\S+)', 1, 3), 1, 1) || '. ' AS ФИО
FROM TEACHER;

------------------------------------ Задание №3
SELECT *
FROM TEACHER
WHERE TO_CHAR(birthday, 'd') = 2;

------------------------------------ Задание №4
--drop view next_month

CREATE OR REPLACE VIEW next_month AS
SELECT *
FROM TEACHER
WHERE TO_CHAR(birthday, 'mm') =
      (SELECT substr(to_char(trunc(lASt_day(sysdate)) + 1), 4, 2)
       FROM dual);

SELECT *
FROM next_month;

------------------------------------ Задание №5
--drop view number_months
CREATE OR REPLACE VIEW number_months AS
SELECT to_char(birthday, 'Month') Месяц,
       count(*)                   Количество
FROM teacher
GROUP BY to_char(birthday, 'Month')
HAVING count(*) >= 1
ORDER BY Количество DESC;

SELECT *
FROM number_months;

------------------------------------ Задание №6
DECLARE
    CURSOR teacher_birthday
        return teacher%rowtype is
        SELECT *
        FROM teacher
        WHERE MOD((TO_CHAR(sysdate, 'yyyy') - TO_CHAR(birthday, 'yyyy') + 1), 10) = 0;
    v_teacher  TEACHER%rowtype;
BEGIN
    open teacher_birthday;

    fetch teacher_birthday into v_teacher;

    while (teacher_birthday%found)
        loop
            DBMS_OUTPUT.PUT_LINE(v_teacher.teacher || ' ' || v_teacher.teacher_name || ' ' || v_teacher.pulpit || ' ' ||
                                 v_teacher.birthday || ' ' || v_teacher.salary);
            fetch teacher_birthday into v_teacher;
        end loop;

    close teacher_birthday;
end;

------------------------------------ Задание №7
DECLARE
    CURSOR teachers_avg_sal is
        SELECT pulpit, floor(avg(salary)) AS AVG_SALARY
        FROM TEACHER
        GROUP BY pulpit;
    CURSOR faculty_avg_sal is
        SELECT FACULTY, AVG(SALARY)
        FROM TEACHER
                 join PULPIT P on TEACHER.PULPIT = P.PULPIT
        GROUP BY FACULTY;
    CURSOR faculties_avg_salary is
        SELECT AVG(SALARY)
        FROM TEACHER;
    m_pulpit  TEACHER.PULPIT%type;
    m_salary  TEACHER.SALARY%type;
    m_faculty PULPIT.FACULTY%type;
BEGIN

    DBMS_OUTPUT.PUT_LINE('--------------- По кафедрам -----------------');
    open teachers_avg_sal;
    fetch teachers_avg_sal into m_pulpit, m_salary;

    while (teachers_avg_sal%found)
        loop
            DBMS_OUTPUT.PUT_LINE(m_pulpit || ' ' || m_salary);
            fetch teachers_avg_sal into m_pulpit, m_salary;
        end loop;
    close teachers_avg_sal;

    DBMS_OUTPUT.PUT_LINE('--------------- По факультетам -----------------');
    open faculty_avg_sal;
    fetch faculty_avg_sal into m_faculty, m_salary;

    while (faculty_avg_sal%found)
        loop
            DBMS_OUTPUT.PUT_LINE(m_faculty || ' ' || m_salary);
            fetch faculty_avg_sal into m_faculty, m_salary;
        end loop;
    close faculty_avg_sal;

    DBMS_OUTPUT.PUT_LINE('--------------- По всем факультетам -----------------');
    open faculties_avg_salary;
    fetch faculties_avg_salary into m_salary;
    DBMS_OUTPUT.PUT_LINE(round(m_salary, 2));
    close faculties_avg_salary;
end;


------------------------------------ Задание №8
DECLARE
    RECL TEACHER%ROWTYPE;    TYPE ADDRESS IS RECORD
    (
        ADRESS1 VARCHAR2(100),
        ADRESS2 VARCHAR2(100),
        ADRESS3 VARCHAR2(100)
    );
    TYPE PERSON IS RECORD    (
        CODE TEACHER.TEACHER%TYPE,
        NAME TEACHER.TEACHER_NAME%TYPE,
        HOMEADDRESS ADDRESS
                             );
    REC2 PERSON;
    REC3 PERSON;
BEGIN
    RECL.TEACHER := 'СМЛВ';
    RECL.TEACHER_NAME := 'Смелов Владимир Владиславович';
    REC2.CODE := RECL.TEACHER;
    REC2.NAME := RECL.TEACHER_NAME;
    REC2.HOMEADDRESS.ADRESS1 := 'Belarus';
    REC2.HOMEADDRESS.ADRESS2 := 'Minsk';
    REC2.HOMEADDRESS.ADRESS3 := 'Bobruiskaya 25';
    REC3 := REC2;
    DBMS_OUTPUT.PUT_LINE('Code: ' || REC3.CODE);    DBMS_OUTPUT.PUT_LINE('Name: ' || REC3.NAME);
    DBMS_OUTPUT.PUT_LINE('Address1: ' || REC3.HOMEADDRESS.ADRESS1);    DBMS_OUTPUT.PUT_LINE('Address2: ' || REC3.HOMEADDRESS.ADRESS2);
    DBMS_OUTPUT.PUT_LINE('Address3: ' || REC3.HOMEADDRESS.ADRESS3);EXCEPTION
    WHEN OTHERS THEN        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' ' || SQLERRM);
END;