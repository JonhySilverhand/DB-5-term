--------------- First Task
select * from V$PDBS;
--------------- Second Task
select * from V$INSTANCE;
--------------- Third Task
select * from V$OPTION;
--------------- Fifth Task
select * from dba_pdbs;
--------------- Sixth Task
create pluggable database SVY_PDB admin user pdb_admin identified by 1234
roles = (DBA) file_name_convert =('D:\app\vlad_oracle\oradata\orcl\pdbseed', 'D:\app\vlad_oracle\oradata\orcl\SVY_PDB');
alter pluggable database SVY_PDB open;
--admin_pdb (PDB)
--drop pluggable database SVY_PDB including datafiles;
--drop tablespace TS_PDB_SVY including contents and datafiles;
create tablespace TS_PDB_SVY
  datafile 'TS_PDB_SVY.dbf'
  size 7M
  autoextend on next 5M
  maxsize 20M
  extent management local;

--drop tablespace TS_PDB_SVY_TEMP including contents and datafiles;
create temporary tablespace TS_PDB_SVY_TEMP
  tempfile 'TS_PDB_SVY_TEMP.dbf'
  size 5M
  autoextend on next 3M
  maxsize 30M;

alter session set "_ORACLE_SCRIPT"=TRUE;
--drop role RL_PDB_SVYCORE;
create role RL_PDB_SVYCORE;

grant connect, create session, create any table, drop any table, create any view,
drop any view, create any procedure, drop any procedure to RL_PDB_SVYCORE;

--drop profile PF_PDB_SVYCORE;
create profile PF_PDB_SVYCORE limit
  password_life_time 365
  sessions_per_user 5
  failed_login_attempts 5
  password_lock_time 1
  password_reuse_time 10
  password_grace_time default
  connect_time 180
  idle_time 45;

--drop user U1_SVY_PDB;
create user U1_SVY_PDB identified by 12345
default tablespace TS_PDB_SVY quota unlimited on TS_PDB_SVY
temporary tablespace TS_PDB_SVY_TEMP
profile PF_PDB_SVYCORE
account unlock
password expire;

grant RL_PDB_SVYCORE to U1_SVY_PDB;

--------------- Seventh Task
-- U1_SVY_PDB (PDB)
create table SVY_table ( x number(2), y varchar(5));

insert into SVY_table values (1, 'first');
insert into SVY_table values (3, 'third');
commit;

select * from SVY_table;
--------------- Eighth Task
-- SYSTEM
select * from DBA_TABLESPACES;

select * from DBA_ROLES;
select * from DBA_ROLE_PRIVS;
select * from DBA_PROFILES;
select * from ALL_USERS;
select * from USER_ROLE_PRIVS;

select *  FROM SYS.PRODUCT_COMPONENT_VERSION;
select * from DBA_DATA_FILES;
select * from DBA_TEMP_FILES;
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS;
--------------- Ninth Task
-- CDB (SVY_Connection)

--drop user C##SVY
create user C##SVY identified by 12345;
grant connect, create session, alter session, create any table,
drop any table to C##SVY container = all;
-- PDB
grant create session to C##SVY;


--------------- Thirteenth Task
alter pluggable database SVY_PDB close immediate;
drop pluggable database SVY_PDB including datafiles;
drop user C##SVY;