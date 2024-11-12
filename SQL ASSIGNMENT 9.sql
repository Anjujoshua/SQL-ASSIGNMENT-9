#database name is workers
create database workers;
use workers;
-- consider the worker table with following fields:
-- Worker_Id INT, FirstName CHAR (25), LastName CHAR (25),
-- Salary INT(15), JoiningDate DATETIME ,Department CHAR(25)

create table worker (worker_Id INT primary key, FirstName CHAR (25) not null , LastName CHAR(25), Salary INT, JoiningDate DATETIME,
Department CHAR(25));

    INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department)
    VALUES ( 1,'jo','tom',60000,'2023-11-15','SALES'),
    (2,'jim','jacob',50000,'2021-12-24','HR'),
    (3,'john','james',70000,'2022-07-30','IT'),
    (4,'Anna','george',80000,'2020-08-05','FINANCE'),
    (5,'joshua','alby',60000,'2023-06-12','IT');
desc worker;
select* from worker;

-- Create a stored procedure that takes in IN parameters for all the columns in the 
-- Worker table and adds a new record to the table and then invokes the procedure call.
DELIMITER $$

CREATE PROCEDURE new_record(IN Worker_Id INT,
    IN FirstName CHAR(25),IN LastName CHAR(25),
    IN Salary INT,IN JoiningDate DATETIME,
    IN Department CHAR(25))

BEGIN

    INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department)
    VALUES (6,'mathew','peter',55000,'2024-06-12','SALES'),
    (7,'jeon','kim',60000,'2024-03-11','IT');
END $$
DELIMITER ;
 CALL new_record(7,'jeon','kim',60000,'2024-03-11','IT');
 
 -- Write stored procedure takes in an IN parameter for WORKER_ID and an OUT parameter for SALARY. 
 -- It should retrieve the salary of the worker with the given ID and returns
 -- it in the p_salary parameter. Then make the procedure call. 
 
 DELIMITER $$

CREATE PROCEDURE Worker_Salary(IN p_worker_Id INT, OUT p_Salary INT )
BEGIN
SELECT Salary INTO p_Salary
    FROM Worker WHERE Worker_Id =p_Worker_Id;
END $$

DELIMITER ;

CALL Worker_Salary(1, @Salary);
SELECT @Salary AS Worker_Salary;

 --  Create a stored procedure that takes in IN parameters for WORKER_ID and DEPARTMENT. It should update the department 
 -- of the worker with the given ID. Then make a procedure call.
 
 DELIMITER $$

CREATE PROCEDURE Update_Worker_Department(IN p_Worker_Id INT, IN p_Department CHAR(25)) 
BEGIN
    UPDATE Worker
    SET Department = p_Department
    WHERE Worker_Id = p_Worker_Id;
END $$

DELIMITER ;

CALL Update_Worker_Department(1, 'IT');
SELECT * FROM Worker WHERE Worker_Id = 1;


-- Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter for p_workerCount. 
-- It should retrieve the number of workers in the given department and returns 
-- it in the p_workerCount parameter. Make procedure call.

DELIMITER $$

CREATE PROCEDURE Worker_Count_By_Department(IN p_Department CHAR(25), 
    OUT p_workerCount INT )
    BEGIN
    SELECT COUNT(*) INTO p_workerCount
    FROM Worker
    WHERE Department = p_Department;
    END $$

DELIMITER ;

CALL Worker_Count_By_Department('SALES', @WorkerCount);
SELECT @WorkerCount AS Number_Of_Workers_In_Sales;

-- Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT 
-- parameter for p_avgSalary. It should retrieve the average salary of all workers in 
-- the given department and returns it in the p_avgSalary parameter and call the procedure.

DELIMITER $$

CREATE PROCEDURE Average_Salary_By_Department(IN p_Department CHAR(25),  
    OUT p_avgSalary DECIMAL(10, 2))
BEGIN

    SELECT AVG(Salary) INTO p_avgSalary
    FROM Worker
    WHERE Department = p_Department;
END $$

DELIMITER ;

CALL Average_Salary_By_Department('Sales', @AvgSalary);

SELECT @AvgSalary AS Average_Salary_In_Sales;





 
 