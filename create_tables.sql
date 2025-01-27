-- create table co_employees
CREATE TABLE co_employees (
  id INT PRIMARY KEY AUTO_INCREMENT,
  em_name VARCHAR(255) NOT NULL,
  gender CHAR(1) NOT NULL,
  contact_number VARCHAR(255),
  age INT NOT NULL,
  date_created TIMESTAMP NOT NULL DEFAULT NOW()
  );

-- create table mentorships
CREATE TABLE mentorships (
    mentor_id INT NOT NULL,
    mentee_id INT NOT NULL,
    status VARCHAR(255) NOT NULL,
    project VARCHAR(255) NOT NULL,
    PRIMARY KEY (mentor_id, mentee_id, project),
    CONSTRAINT fk1 FOREIGN KEY(mentor_id) REFERENCES co_employees(id)
      ON DELETE CASCADE ON UPDATE RESTRICT, -- constraint named fk1
    CONSTRAINT fk2 FOREIGN KEY(mentee_id) REFERENCES co_employees(id)
      ON DELETE CASCADE ON UPDATE RESTRICT, -- ON DELETE, ON UPDATE
    CONSTRAINT mm_constraint UNIQUE(mentor_id, mentee_id)
); 

-- rename table co_employees to employees
RENAME TABLE co_employees TO employees;

-- making several alterations to employees
/*
ALTER TABLE employees
  DROP COLUMN age, 
  ADD COLUMN salary FLOAT NOT NULL AFTER contact_number,
  ADD COLUMN years_in_company INT NOT NULL AFTER salary;
*/

-- making more alterations to mentorships
/*
ALTER TABLE mentorships
  DROP FOREIGN KEY fk2;

ALTER TABLE mentorships
  ADD CONSTRAINT fk2 FOREIGN KEY(mentee_id) 
    REFERENCES employees(id) ON DELETE CASCADE ON UPDATE CASCADE, -- in order to modify fk constraints, we need to drop the fk first and then add it back in
  DROP INDEX mm_constraint;
*/ 

-- deleting tables
/*
DROP TABLE [IF EXISTS] mentorships;
*/ 
