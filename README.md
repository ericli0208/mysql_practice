# MySQL Notes  

## Basics
SQL (Structure Query Language) is a language

A database is a structured collection of data

A DBMS (database management system) is a software that we use to manage our databases

Each DMBS has its own version of SQL, but all support major commands
- SELECT
- DELETE
- UPDATE
- INSERT

Ways to add SQL comments
- '--' 
- '#'
- '/* */'

## Creating and Dropping Databases and Tables
```
-- create database
CREATE DATABASE companyHR;

-- drop database
DROP DATABASE IF EXISTS companyHR;
DROP DATABASE companyHR;

-- use database
USE companyHR;
```

```
-- create table syntax
CREATE TABLE table_name (
    column_name1 datatype [column constraints],
    column_name2 datatype [column constraints],
    ...
    [table constraints],
    [table constraints]
);
```

## Data Types 
| Type                          | Name          | Stores                                                                                                                                                                                                                                                                                                           |
|-------------------------------|---------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Character (Textual)           | CHAR(size)    | stores fixed length strings of up to 255 characters <br> you can also specify the desired length in parentheses after CHAR <br> error for strings longer than specified length <br> spaces for strings shorter|
| Variable Characters (Textual) | VARCHAR(size) | stores variable length strings of up to 255 characters <br> if you store a string lower than the specified amount, no spaces will be added <br> more flexible and uses less storage than CHAR, but it can be slower|
| Integer (Numerical)           | INT           | integers (numbers with no fractional parts) <br> can hold numbers -2147483648 - 2147483647 <br> INT UNSIGNED holds numbers  0 - 4294967295|
| Float (Numerical)             | FLOAT(m, d)   | stores non integers (numbers with fractional parts) of up to 4 bytes of storage <br> m parameter refers to the total number of digits the FLOAT stores <br> d parameter refers to the number of digits after the decimal point <br> discrepancies are rounded (digits that surpass the parameters)|
| Double (Numerical)            | DOUBLE(m, d)  | also used to store non ints, but with 8 bytes of storage <br> same m and d parameters|
| Decimal (Numerical)           | DECIMAL(m, d) | used to store non ints as exact values <br> commonly used to store monetary data where precision is important|
| Year (Date & Time)            | YEAR          | used to store a year in either a 2- or 4-digit format from 1901 - 2155 <br> values allowed in two-digit format are from 01 - 69 (2001 - 2069), and 70 - 99 (1970 - 1999)|
| Date (Date & Time)            | DATE          | stores a data in the YYYY-MM-DD format <br> supports range of '1000-01-01' to '9999-12-31'|
| Time (Date & Time)            | TIME          | stores a time in the HH:MI:SS format <br> supports range of '-838:59:59' to '838:59:59'|
| DateTime (Date & Time)        | DATETIME      | stores a date and time combination in the YYYY-MM-DD HH:MI:SS format <br> supports range of '1000-01-01 00:00:00' to '9999-12-31 23:59:59'|
| TimeStamp (Date & Time)       | TIMESTAMP     | same format as DATETIME <br> supports range of '1970-01-01 00:00:01 UTC' to '2038-01-09 UTC' <br> MySQL converts TIMESTAMP values from the current time zone to UTC for storage, and back from UTC to the current time zone for retrieval <br> This makes it useful for databased used by users across different time zones |

## Column Constraints
| Name                    | Purpose                                                                                                                                              |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| NOT NULL                | specifies a column cannot be empty, must have a value for all rows                                                                                   |
| UNIQUE                  | specifies that all values in the column must be unique                                                                                               |
| DEFAULT                 | sets a default value for a column when no value is specified                                                                                         |
| PRIMARY KEY             | specifies that a column is a primary key, which uniquely identifies each row in a table (PKs are NOT NULL & UNIQUE)                                  |
| AUTO_INCREMENT          | specifies a value that automatically increases by 1 for each new record/row often used to generate a PK for a table  the default starting value is 1 |
| Decimal (Numerical)     | DECIMAL(m, d)                                                                                                                                        |
| Year (Date & Time)      | YEAR                                                                                                                                                 |
| Date (Date & Time)      | DATE                                                                                                                                                 |
| Time (Date & Time)      | TIME                                                                                                                                                 |
| DateTime (Date & Time)  | DATETIME                                                                                                                                             |
| TimeStamp (Date & Time) | TIMESTAMP                                                                                                                                            |

## Table Constraints

Table constraints can affect more than one column

### Primary Key Constraints
- you can delare a column a PK through the table constraint section (esp if the PK is made up of 2 or more columns - composite PK)

### Foreign Key Constraints
- a FK is a column (or collection of columns) in one table that links to the PK in another table
- to specify a FK, we add them into the table constraints section
```
-- syntax to make FK
CONSTRAINT FOREIGN KEY(column_name) REFERENCES parent_table(column_name) ON ...
```
### Unique Constraints
- unique constraints are used to require that a combination of column values be unique
```
-- syntax to make unique constraint
CONSTRAINT UNIQUE(column_name1, column_name2)
```
### Named Constraints
- creating named constraints follows the syntax:

```
-- general syntax to name constraints
CONSTRAINT name_of_constraint
```
### ON DELETE Clauses (for deletion of parent table row):
- ON DELETE CASCADE indicates if a certain employee is deleted from the co_employees table (parent table), any record of that employee in the mentorships table will also be deleted
- ON DELETE RESTRICT  - the row in the parent table cannot be deleted if a row in the child table references that parent row
- ON DELETE SET NULL - the child row FK value will be set to NULL if the parent row is deleted (the relevant column in the child row must allow for NULL values)
- ON DELETE SET DEFAULT - the child row FK value will be set to the default value if the parent row is deleted

***ON UPDATE Clauses follow similar clause definitions, applied to when updating the parent table***

## Altering Tables and Table Values
- renaming tables uses rename feature
```
-- rename from old to new name
RENAME TABLE old_name TO new_name;
```
- using alter to update columns and table constraints
```
-- general syntax
ALTER TABLE table_name ...
-- changing auto increment starting value
    AUTO_INCREMENT = starting_value
-- adding a new table constraint
    ADD CONSTRAINT [name_of_constraint] details_of_constraint
-- dropping a table constraint (excl. fk constraints)
    DROP INDEX name_of_constraint
-- dropping a foreign key constraint
    DROP FOREIGN KEY name_of_fk
-- modifying a column
    MODIFY COLUMN column_name data_type [constraints]
-- dropping a column
    DROP COLUMN column_name
-- adding a column
    ADD COLUMN column_name data_type [constraints]
```
- NOTE: you may use FIRST after column constraints or AFTER [column_name] to specify where you'd like to place newly added columns

## Inserting, Updating, and Deleting Data

- inserting data into tables follows this syntax:
```
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...)
```

- updating table data uses a WHERE clause
```
UPDATE table_name
SET column1 = value1, column2 = value2,
WHERE condition;
```
- typically the condition would be the unique identifier or PK (e.g., WHERE id = 1)
- but you can also use it as a filter to change data values for ALL rows that meet a certain condition
- not using the WHERE clause will change all values in the entire table

- deleting table data follows this syntax:
```
-- deleting a full row
DELETE FROM table_name
WHERE condition;
```

## Selects
- basic select syntax:
```
SELECT column_names_or_other_information [AS alias]
FROM table_name
WHERE [condition]
```

- selecting everything:
```
SELECT *
FROM table_name
```

- 
