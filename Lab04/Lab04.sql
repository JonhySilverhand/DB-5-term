------------ Task First ------------
SELECT * FROM DBA_DATA_FILES;
SELECT * FROM DBA_TEMP_FILES;
------------ Task Second ------------
CREATE TABLESPACE SVY_QDATA
DATAFILE 'D:\University\5th_term\Oracle\Lab04\SVY_QDATA.dbf'
SIZE 10M
OFFLINE;

ALTER TABLESPACE SVY_QDATA ONLINE;
--drop tablespace SVY_QDATA including contents and datafiles;
ALTER USER SVYCORE QUOTA 2M ON SVY_QDATA;

---- FROM USER SVYCORE

CREATE TABLE SVY_T1 (
    Id INT PRIMARY KEY,
    BRAND VARCHAR2(50)
)TABLESPACE SVY_QDATA;

INSERT INTO SVY_T1 (Id, BRAND) VALUES (1, 'AUDI');
INSERT INTO SVY_T1 (Id, BRAND) VALUES (2, 'VOLKSWAGEN');
INSERT INTO SVY_T1 (Id, BRAND) VALUES (3, 'Mercedes-Benz');
COMMIT;

SELECT * FROM SVY_T1;
------------ Task Third ------------
SELECT * FROM USER_SEGMENTS WHERE TABLESPACE_NAME = 'SVY_QDATA';

------------ Task Fourth ------------
DROP TABLE SVY_T1;
SELECT * FROM USER_SEGMENTS WHERE TABLESPACE_NAME = 'SVY_QDATA';
SELECT * FROM USER_RECYCLEBIN;

------------ Task Fifth ------------
FLASHBACK TABLE SVY_T1 TO BEFORE DROP;
SELECT * FROM SVY_T1;
------------ Task Sixth ------------
BEGIN
    FOR i IN 4..10000
    LOOP
        INSERT INTO SVY_T1 (Id) VALUES (i);
        COMMIT;
    end loop;
end;
SELECT COUNT(*) FROM SVY_T1;
------------ Task Seventh------------
SELECT SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME, BYTES, BLOCKS, EXTENTS, BUFFER_POOL
FROM USER_SEGMENTS WHERE TABLESPACE_NAME = 'SVY_QDATA';
SELECT * FROM USER_EXTENTS WHERE TABLESPACE_NAME = 'SVY_QDATA';
------------ Task Eighth------------
--from system
DROP TABLESPACE SVY_QDATA INCLUDING CONTENTS AND DATAFILES;
------------ Task Ninth------------
SELECT * FROM V$LOG ORDER BY GROUP#;
------------ Task Tenth------------
SELECT * FROM V$LOGFILE ORDER BY GROUP#;
------------ Task Eleventh------------
ALTER SYSTEM SWITCH LOGFILE;
SELECT * FROM V$LOG ORDER BY GROUP#;
------------ Task Twelfth------------
ALTER DATABASE ADD LOGFILE
GROUP 4
'D:\app\vlad_oracle\oradata\orcl\RED04.log'
SIZE 50M
BLOCKSIZE 512;

ALTER DATABASE ADD LOGFILE
MEMBER
'D:\app\vlad_oracle\oradata\orcl\RED04_1.log'
TO GROUP 4;

ALTER DATABASE ADD LOGFILE
MEMBER
'D:\app\vlad_oracle\oradata\orcl\RED04_2.log'
TO GROUP 4;
--checking groups
SELECT * FROM V$LOG ORDER BY GROUP#;
--checking files
SELECT GROUP#, MEMBER FROM V$LOGFILE ORDER BY GROUP#;
--tracking SCN
SELECT * FROM V$LOG_HISTORY;
------------ Task Thirteenth------------
--alter system checkpoint;
ALTER DATABASE DROP LOGFILE GROUP 4;
SELECT * FROM V$LOG ORDER BY GROUP#;
SELECT * FROM V$LOGFILE ORDER BY GROUP#;
------------ Task Fourteenth------------

--LOG_MODE = NOARCHIVELOG; ARCHIVER = STOPPED
SELECT DBID, NAME, LOG_MODE FROM V$DATABASE;
SELECT INSTANCE_NAME, ARCHIVER, ACTIVE_STATE FROM V$INSTANCE;
------------ Task Fifteenth------------
SELECT * FROM V$ARCHIVED_LOG;
------------ Task Sixteenth------------
--shutdown immediate;
--startup mount;
--alter database archivelog;
--alter database open;
SELECT DBID, NAME, LOG_MODE FROM V$DATABASE;
SELECT INSTANCE_NAME, ARCHIVER, ACTIVE_STATE FROM V$INSTANCE;
------------ Task Seventeenth------------
ALTER SYSTEM SET LOG_ARCHIVE_DEST_1 = 'LOCATION=D:\app\vlad_oracle\oradata\orcl\Archive';
SELECT * FROM V$ARCHIVED_LOG;
ALTER SYSTEM SWITCH LOGFILE;
SELECT * FROM V$LOG ORDER BY GROUP#;
------------ Task Eighteenth------------
--shutdown immediate;
--startup mount;
--alter database noarchivelog;
--alter database open;
SELECT DBID, NAME, LOG_MODE FROM V$DATABASE;
SELECT INSTANCE_NAME, ARCHIVER, ACTIVE_STATE FROM V$INSTANCE;
------------ Task Nineteenth------------
SELECT * FROM V$CONTROLFILE;
------------ Task Twentieth------------
--show parameter control;
SELECT * FROM V$CONTROLFILE_RECORD_SECTION;
------------ Task Twenty-First------------
--show parameter spfile;
SELECT NAME, DESCRIPTION FROM V$PARAMETER;
------------ Task Twenty-Second------------
CREATE PFILE = 'SVY_PFILE.ora' FROM SPFILE;
------------ Task Twenty-Third------------
--show parameter remote_login_passwordfile;
SELECT * FROM V$PWFILE_USERS;
------------ Task Twenty-Fourth------------
SELECT * FROM V$DIAG_INFO;
------------ Task Twenty-Fifth------------
--D:\app\user_oracle\diag\rdbms\orcl\orcl\alert\log.xml