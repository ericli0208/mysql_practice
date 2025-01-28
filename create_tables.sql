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
ALTER TABLE employees
  DROP COLUMN age, 
  ADD COLUMN salary FLOAT NOT NULL AFTER contact_number,
  ADD COLUMN years_in_company INT NOT NULL AFTER salary;

-- making more alterations to mentorships
ALTER TABLE mentorships
  DROP FOREIGN KEY fk2;

ALTER TABLE mentorships
  ADD CONSTRAINT fk2 FOREIGN KEY(mentee_id) 
    REFERENCES employees(id) ON DELETE CASCADE ON UPDATE CASCADE, -- in order to modify fk constraints, we need to drop the fk first and then add it back in
  DROP INDEX mm_constraint;


-- deleting tables
/*
DROP TABLE [IF EXISTS] mentorships;
*/ 

-- inserting data into employees
INSERT INTO employees (em_name, gender, contact_number, salary, years_in_company)
VALUES ('James Lee', 'M', '516-514-6568', 3500, 11),
  ('Peter Pasternak', 'M', '845-644-7919', 6010, 10),
  ('Ciara Couto', 'F', '845-641-5236', 3900, 8),
  ('Walker Welch', 'M', NULL, 2500, 4),
  ('Li Xiao Ting', 'F', '646-218-7733', 5600, 4), 
  ('Joyce Jones', 'F', '523-172-2191', 8000, 3),
  ('Jason Cerrone', 'M', '725-441-7172', 7980, 2),
  ('Prudence Phelps', 'F', '546-312-5112', 11000, 2),
  ('Larry Zucker', 'M', '817-267-9799', 3500, 1),
  ('Serena Parker', 'F', '621-211-7342', 12000, 1); 
-- note that id and date_created did not need to be specified due to their default values

-- inserting data into mentorships
INSERT INTO mentorships -- no need to specify column names, as we are using all of them
VALUES (1, 2, 'Ongoing', 'SQF Limited'),
  (1, 3, 'Past', 'Wayne Fibre'),
  (2, 3, 'Ongoing', 'SQF Limited'),
  (3, 4, 'Ongoing', 'SQF Limited'),
  (6, 5, 'Past', 'Flynn Tech');
