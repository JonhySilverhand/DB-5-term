ALTER SESSION SET nls_date_format='dd-mm-yyyy hh24:mi:ss';
ALTER SYSTEM SET JOB_QUEUE_PROCESSES = 9;

---------- First Task ---------------

CREATE TABLE TABLE_FIRST (
    A NUMBER,
    B VARCHAR2(20)
);

CREATE TABLE TABLE_SECOND (
    A NUMBER,
    B VARCHAR2(20)
);
select * from TABLE_FIRST;
select * from TABLE_SECOND;

CREATE TABLE JOB_STATUS (
    JOB_STATUS_ID NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY,
    JOB_STATUS VARCHAR2(50),
    ERROR_MESSAGE VARCHAR2(255),
    DATETIME DATE DEFAULT SYSDATE
);

BEGIN
    FOR i IN 1..8
        LOOP
            INSERT INTO TABLE_FIRST(A, B) VALUES (i, 'TABLE_F ROW ' || i);
        end loop;
end;
commit;
select * from TABLE_FIRST;

---------------------- Second & Third Task -----------------

CREATE OR REPLACE PROCEDURE JOB_PROC
IS
    CURSOR CUR_T IS SELECT * FROM TABLE_FIRST;
    ERR_MSG VARCHAR(255);
BEGIN
    FOR k IN CUR_T
        LOOP
            INSERT INTO TABLE_SECOND(A, B) VALUES (K.A, k.B);
        end loop;
    DELETE from TABLE_FIRST;
    insert into JOB_STATUS (JOB_STATUS, DATETIME) values ('SUCCESS', sysdate);
    commit;
    exception
      when others then
          ERR_MSG := sqlerrm;
          insert into JOB_STATUS (JOB_STATUS, ERROR_MESSAGE) values ('FAILURE', ERR_MSG);
          commit;
end;

DECLARE JOB_NUMBER USER_JOBS.JOB%TYPE;
BEGIN
    DBMS_JOB.SUBMIT(JOB_NUMBER, 'BEGIN JOB_PROC(); END;', SYSDATE, 'SYSDATE + 7');
    COMMIT;
    DBMS_OUTPUT.PUT_LINE(JOB_NUMBER);
end;

SELECT * FROM JOB_STATUS;
SELECT * FROM TABLE_FIRST;
SELECT * FROM TABLE_SECOND;

------------------------ Fourth Task -------------------

select job, what, last_date, last_sec, next_date, next_sec, broken from user_jobs;

------------------------ Fifth Task -------------------

BEGIN
    DBMS_JOB.RUN(21);
end;

BEGIN
    DBMS_JOB.REMOVE(21);
end;

select * from JOB_STATUS;

--------------------- Sixth Task --------------------

BEGIN
    DBMS_SCHEDULER.CREATE_SCHEDULE(
            SCHEDULE_NAME => 'SCHD_1',
            START_DATE => SYSDATE,
            REPEAT_INTERVAL => 'FREQ=WEEKLY',
            COMMENTS => 'SCHD_1 WEEKLY STARTS NOW'
        );
end;

BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
            program_name => 'PR_1',
            program_type => 'STORED_PROCEDURE',
            program_action => 'JOB_PROC',
            number_of_arguments => 0,
            enabled => true,
            comments => 'PR_1'
        );
end;

BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
            JOB_NAME => 'JOB_1',
            PROGRAM_NAME => 'PR_1',
            SCHEDULE_NAME => 'SCHD_1',
            ENABLED => TRUE
        );
end;

select * from user_scheduler_jobs;

BEGIN
    DBMS_SCHEDULER.DISABLE('JOB_1');
end;
BEGIN
    DBMS_SCHEDULER.RUN_JOB('JOB_1');
end;
BEGIN
    DBMS_SCHEDULER.DROP_JOB('JOB_1');
end;