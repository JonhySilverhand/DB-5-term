DROP TABLE LAB12T;
-------------- First task ------------------

CREATE TABLE LAB12T(
  COLUMN1 NUMBER NOT NULL PRIMARY KEY,
  COLUMN2 VARCHAR2(50)
);

-------------- Second task --------------

BEGIN
    FOR i IN 1..10
        LOOP
            INSERT INTO LAB12T VALUES (i, 'row ' || i);
        end loop;
end;

----------- Third & Fourth task ---------------

CREATE OR REPLACE TRIGGER BEFORE_INSERT_TRIGGER
BEFORE INSERT ON LAB12T
BEGIN
    DBMS_OUTPUT.PUT_LINE('BEFORE_INSERT_TRIGGER');
end;

CREATE OR REPLACE TRIGGER BEFORE_UPDATE_TRIGGER
BEFORE UPDATE ON LAB12T
BEGIN
    DBMS_OUTPUT.PUT_LINE('BEFORE_UPDATE_TRIGGER');
end;

CREATE OR REPLACE TRIGGER BEFORE_DELETE_TRIGGER
BEFORE DELETE ON LAB12T
BEGIN
    DBMS_OUTPUT.PUT_LINE('BEFORE_DELETE_TRIGGER');
end;

INSERT INTO LAB12T VALUES (11, 'TRIG 11');
UPDATE LAB12T SET COLUMN2 = 'UPD TRIG 10' WHERE COLUMN1 = 10;
DELETE FROM LAB12T WHERE COLUMN1 = 11;
COMMIT;

------------ Fifth task ---------------

CREATE OR REPLACE TRIGGER BEFORE_INSERT_TRIGGER_ROW
BEFORE INSERT ON LAB12T
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('BEFORE_INSERT_TRIGGER_ROW');
end;

CREATE OR REPLACE TRIGGER BEFORE_UPDATE_TRIGGER_ROW
BEFORE UPDATE ON LAB12T
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('BEFORE_UPDATE_TRIGGER_ROW');
end;

CREATE OR REPLACE TRIGGER BEFORE_DELETE_TRIGGER_ROW
BEFORE DELETE ON LAB12T
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('BEFORE_DELETE_TRIGGER_ROW');
end;

INSERT INTO LAB12T VALUES (12, 'row_TRIG_ROW 12');
UPDATE LAB12T SET COLUMN2 = 'UPD row_TRIG_ROW 6' WHERE COLUMN1 = 6;
DELETE FROM LAB12T WHERE COLUMN1 = 11;
COMMIT;

--------------- Sixth task ---------------

drop table LAB12T;
CREATE OR REPLACE TRIGGER TRIGGER_DML
BEFORE INSERT OR UPDATE OR DELETE ON LAB12T
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('INSERTING_TRIGGER');
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('UPDATING_TRIGGER');
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('DELETING_TRIGGER');
    end if;
end;

INSERT INTO LAB12T VALUES (13, 'TRIGGER_DML 13');
UPDATE LAB12T SET COLUMN2 = 'UPD TRIGGER_DML 13' WHERE COLUMN1 = 13;
DELETE FROM LAB12T WHERE COLUMN1 = 13;
COMMIT;

----------------- Seventh task ----------------

CREATE OR REPLACE TRIGGER AFTER_INSERT_TRIGGER
AFTER INSERT ON LAB12T
BEGIN
    DBMS_OUTPUT.PUT_LINE('AFTER_INSERT_TRIGGER');
end;

CREATE OR REPLACE TRIGGER AFTER_UPDATE_TRIGGER
AFTER UPDATE ON LAB12T
BEGIN
    DBMS_OUTPUT.PUT_LINE('AFTER_UPDATE_TRIGGER');
end;

CREATE OR REPLACE TRIGGER AFTER_DELETE_TRIGGER
AFTER DELETE ON LAB12T
BEGIN
    DBMS_OUTPUT.PUT_LINE('AFTER_DELETE_TRIGGER');
end;

INSERT INTO LAB12T VALUES (15, 'AFTER_INS_TRIG 15');
UPDATE LAB12T SET COLUMN2 = 'AFTER_UPD_TRIG 15' WHERE COLUMN1 = 15;
DELETE FROM LAB12T WHERE COLUMN1 = 15;
COMMIT;

---------------------- Eighth task -----------------

CREATE OR REPLACE TRIGGER AFTER_INSERT_TRIGGER_ROW
AFTER INSERT ON LAB12T
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('AFTER_INSERT_TRIGGER_ROW');
end;

CREATE OR REPLACE TRIGGER AFTER_UPDATE_TRIGGER_ROW
AFTER UPDATE ON LAB12T
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('AFTER_UPDATE_TRIGGER_ROW');
end;

CREATE OR REPLACE TRIGGER AFTER_DELETE_TRIGGER_ROW
AFTER DELETE ON LAB12T
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('AFTER_DELETE_TRIGGER_ROW');
end;

INSERT INTO LAB12T VALUES (16, 'AFT_TRIG_INS_ROW 16');
UPDATE LAB12T SET COLUMN2 = 'AFT_UPD_TRIG_ROW 4' WHERE COLUMN1 = 4;
DELETE FROM LAB12T WHERE COLUMN1 = 16;
COMMIT;

----------------- Ninth task ------------

CREATE TABLE AUDIT_T(
  OperationDate DATE,
  OperationType VARCHAR2(50),
  TriggerName VARCHAR2(50),
  Data VARCHAR2(60)
);

----------------- Tenth task ---------------

CREATE OR REPLACE TRIGGER DML_BEFORE_TRIGGER_ROW
BEFORE INSERT OR UPDATE OR DELETE
ON LAB12T FOR EACH ROW
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('DML_BEFORE_TRIGGER_ROW INSERT');
        INSERT INTO AUDIT_T (OperationDate, OperationType, TriggerName, Data)
        VALUES (sysdate, 'INSERT', 'DML_BEFORE_TRIGGER_ROW', :new.COLUMN1 || ' ' || :new.COLUMN2);
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('DML_BEFORE_TRIGGER_ROW UPDATE');
        INSERT INTO AUDIT_T (OperationDate, OperationType, TriggerName, Data)
        VALUES (sysdate, 'UPDATE', 'DML_BEFORE_TRIGGER_ROW', :old.COLUMN1 || ' ' || :old.COLUMN2 ||
                                                            '->' || :new.COLUMN1 || ' ' || :new.COLUMN2);
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('DML_BEFORE_TRIGGER_ROW DELETE');
        INSERT INTO AUDIT_T (OperationDate, OperationType, TriggerName, Data)
        VALUES (sysdate, 'DELETE', 'DML_BEFORE_TRIGGER_ROW', :old.COLUMN2 || ' ' || :old.COLUMN2);
    end if;
end;

CREATE OR REPLACE TRIGGER DML_AFTER_TRIGGER_ROW
AFTER INSERT OR UPDATE OR DELETE
ON LAB12T FOR EACH ROW
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('DML_AFTER_TRIGGER_ROW INSERT');
        INSERT INTO AUDIT_T (OperationDate, OperationType, TriggerName, Data)
        VALUES (sysdate, 'INSERT', 'DML_AFTER_TRIGGER_ROW', :new.COLUMN1 || ' ' || :new.COLUMN2);
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('DML_AFTER_TRIGGER_ROW UPDATE');
        INSERT INTO AUDIT_T (OperationDate, OperationType, TriggerName, Data)
        VALUES (sysdate, 'UPDATE', 'DML_AFTER_TRIGGER_ROW', :old.COLUMN1 || ' ' || :old.COLUMN2 ||
                                                            '->' || :new.COLUMN1 || ' ' || :new.COLUMN2);
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('DML_AFTER_TRIGGER_ROW DELETE');
        INSERT INTO AUDIT_T (OperationDate, OperationType, TriggerName, Data)
        VALUES (sysdate, 'DELETE', 'DML_AFTER_TRIGGER_ROW', :old.COLUMN1 || ' ' || :old.COLUMN2);
    end if;
end;

CREATE OR REPLACE TRIGGER DML_BEFORE_TRIGGER
BEFORE INSERT OR UPDATE OR DELETE ON LAB12T
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('DML_BEFORE_TRIGGER INSERT');
        INSERT INTO AUDIT_T (OperationDate, OperationType, TriggerName, Data)
        VALUES (sysdate, 'INSERT', 'DML_BEFORE_TRIGGER', :new.COLUMN1 || ' ' || :new.COLUMN2);
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('DML_BEFORE_TRIGGER UPDATE');
        INSERT INTO AUDIT_T (OperationDate, OperationType, TriggerName, Data)
        VALUES (sysdate, 'UPDATE', 'DML_BEFORE_TRIGGER', :old.COLUMN1 || ' ' || :old.COLUMN2 ||
                                                            '->' || :new.COLUMN1 || ' ' || :new.COLUMN2);
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('DML_BEFORE_TRIGGER DELETE');
        INSERT INTO AUDIT_T (OperationDate, OperationType, TriggerName, Data)
        VALUES (sysdate, 'DELETE', 'DML_BEFORE_TRIGGER', :old.COLUMN1 || ' ' || :old.COLUMN2);
    END IF;
end;

CREATE OR REPLACE TRIGGER DML_AFTER_TRIGGER
AFTER INSERT OR UPDATE OR DELETE ON LAB12T
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('DML_BEFORE_TRIGGER INSERT');
        INSERT INTO AUDIT_T (OperationDate, OperationType, TriggerName, Data)
        VALUES (sysdate, 'INSERT', 'DML_AFTER_TRIGGER', :new.COLUMN1 || ' ' || :new.COLUMN2);
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('DML_BEFORE_TRIGGER UPDATE');
        INSERT INTO AUDIT_T (OperationDate, OperationType, TriggerName, Data)
        VALUES (sysdate, 'UPDATE', 'DML_AFTER_TRIGGER', :old.COLUMN1 || ' ' || :old.COLUMN2 ||
                                                            '->' || :new.COLUMN1 || ' ' || :new.COLUMN2);
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('DML_BEFORE_TRIGGER DELETE');
        INSERT INTO AUDIT_T (OperationDate, OperationType, TriggerName, Data)
        VALUES (sysdate, 'DELETE', 'DML_AFTER_TRIGGER', :old.COLUMN1 || ' ' || :old.COLUMN2);
    END IF;
end;

INSERT INTO LAB12T VALUES (20, 'TRIGGER 20');
UPDATE LAB12T SET COLUMN2 = 'UPD TRIGGER 20' WHERE COLUMN1 = 20;
DELETE FROM LAB12T WHERE COLUMN1 = 20;
COMMIT;

--------------------- Eleventh task ----------------------

INSERT INTO LAB12T (COLUMN1, COLUMN2) VALUES ('FFF', 2);

-------------------- Twelfth task -----------------------

DROP TABLE LAB12T;
DROP TRIGGER PREVENTING_DROP_TABLE_TRIGGER;
CREATE OR REPLACE TRIGGER PREVENTING_DROP_TABLE_TRIGGER
BEFORE DROP ON U1_SVY_PDB.SCHEMA
DECLARE
    table_name VARCHAR2(30);
BEGIN
     SELECT TABLE_NAME INTO table_name FROM user_tables WHERE TABLE_NAME = 'LAB12T';
    IF table_name = 'LAB12T' THEN
    RAISE_APPLICATION_ERROR(-20000, 'You can not drop table LAB12T');
    end if;
end;

DROP TRIGGER PREVENTING_DROP_TABLE_TRIGGER;

---------------------- Thirteenth task --------------------

DROP TABLE AUDIT_T;

--------------------- Fourteenth task ---------------------

CREATE VIEW Lab12T_VIEW AS SELECT * FROM LAB12T;

CREATE OR REPLACE TRIGGER INSTEAD_OF_INSERT_TRIGGER
INSTEAD OF INSERT ON Lab12T_VIEW
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('INSTEAD_OF_INSERT_TRIGGER');
        INSERT INTO LAB12T (COLUMN1, COLUMN2) VALUES (44, 'Instead of action');
    end if;
end INSTEAD_OF_INSERT_TRIGGER;

------------------------------ Fifteenth task -------------------

INSERT INTO LAB12T VALUES (55, 'SOME NEW ROW IN VIEW FOR TABLE12T');

SELECT * FROM LAB12T_VIEW;


------ Триггер, который проверяет если есть такая строка в таблице,
------ если есть обновляет, и типа выбивает нет такой строки

CREATE TABLE Task_T (
    COLUMN1 NUMBER
);

CREATE OR REPLACE TRIGGER beforeItem
BEFORE INSERT ON Task_T
FOR EACH ROW

DECLARE
    chk_no NUMBER;
BEGIN
    chk_no  :=0;
    SELECT COUNT(COLUMN1) INTO  chk_no FROM Task_T;
    IF chk_no = 0 THEN
        NULL;
    ELSE
        SELECT MAX(COLUMN1) INTO chk_no FROM Task_T;
        update Task_T set COLUMN1 = chk_no + 1 where COLUMN1 = :new.COLUMN1;
    end if;
end;

truncate table Task_T;
insert into Task_T (COLUMN1) values (22);
select * from Task_T;

commit;

SELECT * from USER_TRIGGERS;