-- Step 1: Create the sequence (run this once)
CREATE SEQUENCE DD_PROJID_SEQ
START WITH 530
INCREMENT BY 1
NOCACHE;

-- Step 2: Create the PL/SQL block
DECLARE
    -- Define a record type based on the project table structure
    TYPE project_record IS RECORD (
        project_id            NUMBER,
        project_name          VARCHAR2(100),
        start_date            DATE,
        end_date              DATE,
        fundraising_goal      NUMBER,
        -- Add other columns as needed, setting them to NULL for now
        other_column1         VARCHAR2(100),
        other_column2         VARCHAR2(100)
    );

    -- Declare a variable of the record type
    new_project project_record;
BEGIN
    -- Populate the record variable with the new project's data
    new_project.project_id := DD_PROJID_SEQ.NEXTVAL; -- Get the next project ID
    new_project.project_name := 'HK Animal Shelter Extension';
    new_project.start_date := TO_DATE('01-JAN-2013', 'DD-MON-YYYY');
    new_project.end_date := TO_DATE('31-MAY-2013', 'DD-MON-YYYY');
    new_project.fundraising_goal := 65000;
    new_project.other_column1 := NULL; -- Assuming other columns are unknown
    new_project.other_column2 := NULL;

    -- Step 3: Insert the record into the project table
    INSERT INTO project (
        project_id,
        project_name,
        start_date,
        end_date,
        fundraising_goal,
        other_column1,
        other_column2
    ) VALUES (
        new_project.project_id,
        new_project.project_name,
        new_project.start_date,
        new_project.end_date,
        new_project.fundraising_goal,
        new_project.other_column1,
        new_project.other_column2
    );

    -- Commit the transaction
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Project added successfully with ID: ' || new_project.project_id);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK; -- Rollback in case of an error
        DBMS_OUTPUT.PUT_LINE('Error adding project: ' || SQLERRM);
END;
/
