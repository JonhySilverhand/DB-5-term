---------------- Task First ----------------
BEGIN
    NULL;
end;
---------------- Task Second ----------------
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World!');
end;
---------------- Task Third ----------------
DECLARE
    x NUMBER(3) := 3;
    y NUMBER(3) := 0;
    z NUMBER(10, 2);
BEGIN
    z := x / y;
    DBMS_OUTPUT.PUT_LINE('z = ' || z);
EXCEPTION
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE(SQLCODE || ': ERROR = ' || SQLERRM);
end;

---------------- Task Fourth ----------------
declare
    x number(3) := 3;
    y number(3) := 0;
    z number(10, 2);
begin
    dbms_output.put_line('x = ' || x || ', y = ' || y);
    begin
        z := x / y;
    exception
        when others
            then dbms_output.put_line('error = ' || sqlerrm);
    end;
    dbms_output.put_line('z = ' || z);
end;
---------------- Task Fifth ----------------

--show parameter plsql_warnings;
SELECT NAME, VALUE FROM V$PARAMETER
WHERE NAME = 'plsql_warnings';
--alter system set plsql_warnings='ENABLE:INFORMATIONAL';

---------------- Task Sixth ----------------

SELECT KEYWORD FROM V$RESERVED_WORDS
WHERE LENGTH = 1 AND KEYWORD != 'A';

---------------- Task Seventh ----------------
SELECT KEYWORD FROM V$RESERVED_WORDS
WHERE LENGTH > 1 AND KEYWORD != 'A'
ORDER BY KEYWORD;
---------------- Task Eight ----------------
SELECT NAME, VALUE
FROM V$PARAMETER
WHERE NAME LIKE 'plsql%';
--show parameter plsql;
---------------- Task from Ninth to Seventh ----------------
DECLARE
    t10     NUMBER(3)      := 10;
    t11     NUMBER(3)      := 23;
    sum_var NUMBER(10, 2);
    dwr     NUMBER(10, 2);
    t12     NUMBER(10, 2)  := 3.14;
    t13     NUMBER(10, -3) := 111777.15;
    t14     BINARY_FLOAT   := 123456789.123456789;
    t15     BINARY_DOUBLE  := 123456789.123456789;
    t16     NUMBER(38, 10) := 12345E+10;
    t17_1   BOOLEAN        := TRUE;
    t17_2   BOOLEAN        := FALSE;
BEGIN
    sum_var := t10 + t11;
    dwr := mod(t10, t11);

    dbms_output.put_line('t10 = ' || t10);
    dbms_output.put_line('t11 = ' || t11);
    dbms_output.put_line('remainder = ' || dwr);
    dbms_output.put_line('SUM = ' || sum_var);
    dbms_output.put_line('FIXED = ' || t12);
    dbms_output.put_line('ROUNDED = ' || t13);
    dbms_output.put_line('BINARY FLOAT = ' || t14);
    dbms_output.put_line('BINARY DOUBLE = ' || t15);
    dbms_output.put_line('E+10 = ' || t16);
    IF t17_1
    THEN
        DBMS_OUTPUT.PUT_LINE('BOOL = ' || 'TRUE');
    end if;
    IF NOT t17_2
        THEN
            DBMS_OUTPUT.PUT_LINE('BOOL = ' || 'FALSE');
    end if;
end;
---------------- Task Eighteenth ----------------
DECLARE
    NUM CONSTANT NUMBER        := 69;
    VCHR CONSTANT VARCHAR2(10) := 'ORACLE';
    CR  CHAR(6)        := 'CHAR';
BEGIN
    CR := 'REGION';
    DBMS_OUTPUT.PUT_LINE(NUM);
    DBMS_OUTPUT.PUT_LINE(VCHR);
    DBMS_OUTPUT.PUT_LINE(CR);
EXCEPTION
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
end;
---------------- Task Nineteenth ----------------
DECLARE
    PULP U1_SVY_PDB.PULPIT.PULPIT%TYPE;
BEGIN
    PULP := 'ПИ';
    DBMS_OUTPUT.PUT_LINE(PULP);
end;
---------------- Task Twenty ----------------
DECLARE
    FACULTY_RESULT U1_SVY_PDB.FACULTY%ROWTYPE;
BEGIN
    FACULTY_RESULT.FACULTY := 'ИТ';
    FACULTY_RESULT.FACULTY_NAME := 'Информационные технологии';
    DBMS_OUTPUT.PUT_LINE(FACULTY_RESULT.FACULTY || ' - ' || FACULTY_RESULT.FACULTY_NAME);
end;
---------------- Task from Twenty-First to Twenty-Second ----------------
DECLARE
    x PLS_INTEGER := 44;
BEGIN
    IF x < 20 THEN
        DBMS_OUTPUT.PUT_LINE('x < 20');
    ELSIF x > 20 THEN
        DBMS_OUTPUT.PUT_LINE('x > 20');
    ELSE
        DBMS_OUTPUT.PUT_LINE('x = 20');
    end if;
end;
---------------- Task Twenty-Third ----------------
DECLARE
    x PLS_INTEGER := 21;
BEGIN
    CASE
        WHEN x BETWEEN 10 AND 20 THEN DBMS_OUTPUT.PUT_LINE('10 <= x <= 20');
        WHEN x BETWEEN 21 AND 40 THEN DBMS_OUTPUT.PUT_LINE('21 <= x <= 40');
        ELSE DBMS_OUTPUT.PUT_LINE('else block');
        END CASE;
END;
---------------- Task Twenty-Fourth ----------------
DECLARE
    x PLS_INTEGER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('LOOP: ');
    LOOP
        x := x + 2;
        dbms_output.put_line(x);
        EXIT WHEN x >= 10;
    END LOOP;
END;
---------------- Task Twenty-Fifth ----------------
DECLARE
    x PLS_INTEGER := 5;
BEGIN
    DBMS_OUTPUT.PUT_LINE('WHILE: ');
    WHILE (x > 0)
        LOOP
            dbms_output.put_line(x);
            x := x - 1;
        END LOOP;
END;
---------------- Task Twenty-Sixth ----------------
BEGIN
    DBMS_OUTPUT.PUT_LINE('FOR: ');
    FOR k IN 1..5
        LOOP
            dbms_output.put_line(k);
        END LOOP;
END;