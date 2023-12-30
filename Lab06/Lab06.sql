------------ Task First ------------

--D:\app\vlad_oracle\product\12.1.0\dbhome_1\NETWORK\ADMIN\sqlnet.ora
--D:\app\vlad_oracle\product\12.1.0\dbhome_1\NETWORK\ADMIN\tnsnames.ora

------------ Task Second ------------
SELECT NAME, DESCRIPTION, VALUE FROM V$PARAMETER;

------------ Task Third ------------
--conn system/vlad123@localhost:1521/SVY_PDB;
alter session set container=SVY_PDB;

SELECT * FROM DBA_TABLESPACES;
SELECT TABLESPACE_NAME, FILE_NAME FROM DBA_DATA_FILES;
SELECT * FROM DBA_ROLES;
SELECT * FROM DBA_USERS;

------------ Task Fourth ------------

--regedit

------------ Task Fifth ------------

--conn U1_SVY_PDB/54321@U1_SVY_PDB_SVY_PDB;

------------ Task Seventh ------------
-- insert into SVY_table values (1, 'first');
-- insert into SVY_table values (3, 'third');
SELECT * FROM SVY_TABLE;

------------ Task Eighth ------------

--help timing
--timi start;
--select * from user_segments;
--timi stop;

------------ Task Ninth ------------

--desc
--desc SVY_TABLE;

------------ Task Tenth ------------

SELECT * FROM USER_SEGMENTS;

------------ Task Eleventh ------------

CREATE VIEW view_segments AS
    SELECT COUNT(SEGMENT_NAME) segments_count, SUM(EXTENTS) extents_count,
           SUM(BLOCKS) bloks_count, SUM(BYTES) memory_size
    FROM USER_SEGMENTS;
SELECT * FROM view_segments;