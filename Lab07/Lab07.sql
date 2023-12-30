------------ Task First ------------
grant create sequence, create cluster,
    create synonym, create public synonym, create materialized view
    to U1_SVY_PDB;
-- sys in pdb
grant select on SYS.DBA_CLUSTERS to U1_SVY_PDB;
grant select on SYS.DBA_TABLES to U1_SVY_PDB;
grant execute on DBMS_MVIEW to U1_SVY_PDB;
------------ Task Second ------------
--drop sequence U1_SVY_PDB.S1;

CREATE SEQUENCE U1_SVY_PDB.S1
    start with 1000
    increment by 10
    nominvalue
    nomaxvalue
    nocycle
    nocache
    noorder;
SELECT S1.nextval FROM DUAL;
SELECT S1.currval FROM DUAL;
------------ Task Third ------------
--DROP SEQUENCE U1_SVY_PDB.S2
CREATE SEQUENCE U1_SVY_PDB.S2
    START WITH 10
    INCREMENT BY 10
    MAXVALUE 100
    NOCYCLE;
SELECT S2.nextval FROM DUAL;
SELECT S2.currval FROM DUAL;
------------ Task Fourth ------------
--DROP SEQUENCE U1_SVY_PDB.S3
CREATE SEQUENCE U1_SVY_PDB.S3
    START WITH 10
    INCREMENT BY -10
    MINVALUE -100
    MAXVALUE 10
    NOCYCLE
    ORDER;
SELECT S3.nextval FROM DUAL;
SELECT S3.currval FROM DUAL;
------------ Task Fifth ------------
--DROP SEQUENCE U1_SVY_PDB.S4
CREATE SEQUENCE U1_SVY_PDB.S4
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 10
    CYCLE
    CACHE 5
    NOORDER;
SELECT S4.nextval FROM DUAL;
SELECT S4.currval FROM DUAL;
------------ Task Sixth ------------
SELECT * FROM USER_SEQUENCES;
------------ Task Seventh ------------

CREATE TABLE T1(
  N1 NUMBER(20),
  N2 NUMBER(20),
  N3 NUMBER(20),
  N4 NUMBER(20)
) CACHE STORAGE ( BUFFER_POOL KEEP);
BEGIN
    FOR i IN 1..7 LOOP
        INSERT INTO T1 (N1, N2, N3, N4)
        VALUES (U1_SVY_PDB.S1.nextval,
                U1_SVY_PDB.S2.nextval,
                U1_SVY_PDB.S3.nextval,
                U1_SVY_PDB.S4.nextval);
        end loop;
end;

SELECT * FROM T1;
------------ Task Eighth ------------
--DROP CLUSTER U1_SVY_PDB.ABC;
CREATE CLUSTER U1_SVY_PDB.ABC(
    X NUMBER(10),
    V VARCHAR2(12)
    )
    HASHKEYS 200
    TABLESPACE TS_PDB_SVY;
------------ Task Ninth ------------
--DROP TABLE A;
CREATE TABLE A
(
    XA NUMBER(10),
    VA VARCHAR2(12),
    Y INT
) CLUSTER U1_SVY_PDB.ABC (XA, VA);
------------ Task Tenth ------------
--DROP TABLE B;
CREATE TABLE B
(
    XB NUMBER(10),
    VB VARCHAR2(12),
    Y INT
) CLUSTER U1_SVY_PDB.ABC (XB, VB);
------------ Task Eleventh ------------
--DROP TABLE C;
CREATE TABLE C
(
    XC NUMBER(10),
    VC VARCHAR2(12),
    Y INT
) CLUSTER U1_SVY_PDB.ABC (XC, VC);
------------ Task Twelfth ------------
SELECT * FROM SYS.DBA_CLUSTERS;
SELECT * FROM SYS.DBA_TABLES
WHERE CLUSTER_NAME = 'ABC';
------------ Task Thirteenth ------------
--DROP SYNONYM SYN_C;
CREATE SYNONYM SYN_C FOR U1_SVY_PDB.C;
INSERT INTO SYN_C VALUES (1, 'A', 7);
SELECT * FROM SYN_C;
------------ Task Fourteenth ------------
--DROP SYNONYM SYN_B;
CREATE SYNONYM SYN_B FOR U1_SVY_PDB.B;
INSERT INTO SYN_B VALUES (2, 'B', 8);
SELECT * FROM SYN_B;
------------ Task Fifteenth ------------
--DROP TABLE TABLE_A;
--DROP TABLE TABLE_B;
CREATE TABLE TABLE_A (
  ID INT PRIMARY KEY,
  NAME VARCHAR2(15)
);
CREATE TABLE TABLE_B (
    ID_A INT,
    DESCRIPTION VARCHAR2(15),
    CONSTRAINT FK_ID_A FOREIGN KEY (ID_A) REFERENCES TABLE_A (ID)
);

INSERT INTO TABLE_A(ID, NAME) VALUES (1, 'VLAD');
INSERT INTO TABLE_A(ID, NAME) VALUES (2, 'ALEH');
INSERT INTO TABLE_B(ID_A, DESCRIPTION) VALUES (1, 'STUDENT');
INSERT INTO TABLE_B(ID_A, DESCRIPTION) VALUES (2, 'DRIVER');
COMMIT;

--DROP VIEW VI1;

CREATE VIEW VI1 AS SELECT * FROM TABLE_A INNER JOIN TABLE_B TB on TABLE_A.ID = TB.ID_A;
SELECT * FROM VI1;
------------ Task Sixteenth ------------
--DROP MATERIALIZED VIEW MV;
CREATE MATERIALIZED VIEW MV
    REFRESH COMPLETE
    START WITH SYSDATE NEXT SYSDATE + 2/(24*60)
AS SELECT * FROM TABLE_A FULL JOIN TABLE_B TB on TABLE_A.ID = TB.ID_A;

SELECT * FROM MV;

INSERT INTO TABLE_A(ID, NAME) VALUES (3, 'KIRILL');
--DELETE FROM TABLE_A WHERE ID = 3;
COMMIT;