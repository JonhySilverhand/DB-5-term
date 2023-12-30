------------ Task First ------------
SELECT SUM(value) AS "Sum size SGA" FROM v$sga;
------------ Task Second ------------
SELECT NAME POOL_NAME, VALUE SIZE_IN_BYTES FROM v$sga;
------------ Task Third ------------
SELECT COMPONENT, GRANULE_SIZE
FROM V$SGA_DYNAMIC_COMPONENTS WHERE CURRENT_SIZE > 0;
------------ Task Fourth ------------
SELECT CURRENT_SIZE FROM V$SGA_DYNAMIC_FREE_MEMORY;
------------ Task Fifth ------------
SELECT NAME, VALUE
FROM v$parameter
WHERE name IN ('sga_max_size', 'sga_target');
------------ Task Sixth ------------
SELECT COMPONENT, MAX_SIZE, MIN_SIZE, CURRENT_SIZE
FROM V$SGA_DYNAMIC_COMPONENTS
WHERE COMPONENT IN ('KEEP buffer cache', 'DEFAULT buffer cache', 'RECYCLE buffer cache');
------------ Task Seventh ------------
CREATE TABLE SVY_TABLE_POOL (num number) STORAGE (BUFFER_POOL KEEP);
INSERT INTO SVY_TABLE_POOL values (1);
INSERT INTO SVY_TABLE_POOL values (2);
INSERT INTO SVY_TABLE_POOL values (3);
COMMIT;

SELECT * FROM SVY_TABLE_POOL;
SELECT SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME, BUFFER_POOL
FROM USER_SEGMENTS WHERE SEGMENT_NAME LIKE 'SVY%';
------------ Task Eighth ------------
CREATE TABLE SVY_TABLE_DEFAULT (num number) STORAGE (BUFFER_POOL DEFAULT);
INSERT INTO SVY_TABLE_DEFAULT values (4);
INSERT INTO SVY_TABLE_DEFAULT values (5);
INSERT INTO SVY_TABLE_DEFAULT values (6);
COMMIT;

SELECT * FROM SVY_TABLE_DEFAULT;
SELECT SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME, BUFFER_POOL
FROM USER_SEGMENTS WHERE SEGMENT_NAME LIKE '%DEFAULT';
------------ Task Ninth ------------
--show parameter log_buffer
------------ Task Tenth ------------
SELECT POOL, NAME, BYTES FROM V$SGASTAT
WHERE POOL = 'large pool' AND NAME = 'free memory';
------------ Task Eleventh ------------
SELECT SID, STATUS, SERVER, LOGON_TIME, PROGRAM, OSUSER, MACHINE, USERNAME, STATE
FROM V$SESSION
WHERE STATUS = 'ACTIVE';
------------ Task Twelfth ------------
SELECT SID, PROCESS, NAME, DESCRIPTION, PROGRAM, STATUS
FROM v$session s JOIN V$BGPROCESS using (paddr)
WHERE s.status = 'ACTIVE';
------------ Task Thirteenth ------------
SELECT * FROM V$PROCESS;
------------ Task Fourteenth ------------
--show parameter db_writer_processes;
SELECT * FROM V$BGPROCESS WHERE NAME LIKE 'DBW%';
------------ Task Fifteenth ------------
SELECT NETWORK_NAME, NAME, PDB FROM V$SERVICES;
------------ Task Sixteenth ------------
SELECT * FROM V$DISPATCHER;
--show parameter dispatchers;
------------ Task Seventeenth ------------
-- OracleOraDB12Home1TNSListener (services.msc)
------------ Task Eighteenth ------------
-- D:\app\vlad_oracle\product\12.1.0\dbhome_1\NETWORK\ADMIN\listener.ora
------------ Task Nineteenth ------------

------------ Task Twentieth ------------
