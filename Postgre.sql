CREATE DATABASE University;

CREATE TABLE students (
student_id SERIAL PRIMARY KEY,
student_name VARCHAR(100),
age INTEGER,
email VARCHAR(100),
frontend_mark INTEGER,
backend_mark INTEGER,
status VARCHAR(50)
);



CREATE TABLE courses (
course_id SERIAL PRIMARY KEY,
course_name VARCHAR(100),
credits INTEGER
);


CREATE TABLE enrollment (
enrollment_id SERIAL PRIMARY KEY,
student_id INTEGER REFERENCES students(student_id),
course_id INTEGER REFERENCES courses(course_id)
);

INSERT INTO Students (student_id, student_name, age, email, frontend_mark, backend_mark, status)
VALUES
(1, 'Alice', 22, 'alice@example.com', 55, 57, NULL),
(2, 'Bob', 21, 'bob@example.com', 34, 45, NULL),
(3, 'Charlie', 23, 'charlie@example.com', 60, 59, NULL),
(4, 'David', 20, 'david@example.com', 40, 49, NULL),
(5, 'Eve', 24, 'newemail@example.com', 45, 34, NULL),
(6, 'Rahim', 23, 'rahim@gmail.com', 46, 42, NULL);

INSERT INTO courses (course_name, credits)
VALUES
('Next.js', 3),
('React.js', 4),
('Databases', 3),
('Prisma', 3);


INSERT INTO enrollment (student_id, course_id)
VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 2);


INSERT INTO students (student_id,student_name, age, email, frontend_mark, backend_mark, status)
VALUES (7,'Ravindiran', 21, 'ravi@gmail.com', 90, 92, NULL);


SELECT s.student_name
FROM students s
JOIN enrollment e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Next.js';

UPDATE students
SET status = 'Awarded'
WHERE student_id = (
SELECT student_id
FROM (SELECT student_id, (frontend_mark + backend_mark) AS total_mark
FROM students
ORDER BY total_mark DESC
LIMIT 1
)AS highest_mark
);

DELETE FROM courses
WHERE course_id NOT IN (SELECT DISTINCT course_id FROM enrollment);


SELECT student_name
FROM students
ORDER BY student_id
LIMIT 2 OFFSET 2;

SELECT c.course_name, COUNT(e.student_id) AS students_enrolled
FROM courses c
LEFT JOIN enrollment e ON c.course_id = e.course_id
GROUP BY c.course_name;

SELECT AVG(age) AS average_age
FROM students;

SELECT student_name
FROM students
WHERE email LIKE '%gmail.com';


1). Explain the primary key and foreign key concepts in PostgreSQL.
 
i)Foreign Key:-
A Foreign Key is a column or a group of columns used to uniquely identify a row in a different table. 
The table containing the foreign key is called the referencing table or child table, 
while the table that the foreign key references is known as the referenced table or parent table.

ii)Primary Key:-
It is a field in a table that individually identifies each row or the record in a database table, and it contains a unique value.
A primary key does not hold any null value. And for this, we can also say that the primary key is collecting 
the unique and not-null constraint of a table. If the column has a primary key constraint, then it cannot be null or empty.
It is used to identify each record in a database table distinctively. We can contain other unique columns,
but we have only one primary key in a database table including single or multiple fields.


2). What is the difference between the VARCHAR and CHAR data types?

Char datatype is used to store character strings of fixed length. 
It uses static memory location. 
Varchar datatype is used to store character strings of variable length. 
It uses dynamic memory location.

3). Explain the purpose of the WHERE clause in a SELECT statement.

The SQL WHERE clause is used to filter the results obtained by the DML statements such as SELECT, UPDATE and DELETE etc.
We can retrieve the data from a single table or multiple tables(after join operation) using the WHERE clause.
SYNTAX:-
DML_Statement column1, column2,... columnN
FROM table_name
WHERE [condition];

4). What are the LIMIT and OFFSET clauses used for?

The LIMIT clause in SQL allows users to control the amount of data retrieved and displayed in the result set.
It is useful when only a subset of records is needed for analysis or display purposes in large databases with thousands of records.

i)SYNTAX:-

SELECT column1, column2, …
FROM table_name
WHERE condition
ORDER BY column
LIMIT [offset,] row_count;

ii)OFFSET:-
The OFFSET argument is used to identify the starting point to return rows from a result set. Basically, it exclude the first set of records.
OFFSET can only be used with ORDER BY clause. It cannot be used on its own.

SYNTAX:-

SELECT column_name(s)
FROM table_name
WHERE condition
ORDER BY column_name
OFFSET rows_to_skip ROWS;

5). How can you perform data modification using UPDATE statements?

The UPDATE statement in SQL is used to update the data of an existing table in the database.
We can update single columns as well as multiple columns using the UPDATE statement as per our requirement.
SYNTAX:-
UPDATE table_name SET column1 = value1, column2 = value2,… 
WHERE condition;

6). What is the significance of the JOIN operation, and how does it work in
PostgreSQL?

In PostgreSQL, as in other relational database management systems (RDBMS),
the JOIN operation is fundamental for combining data from multiple tables based on related columns.

Data Integration: JOIN allows you to integrate data from multiple tables into a single result set.
This is crucial in relational databases where data is often split into multiple tables to minimize redundancy and improve data integrity.

Flexibility: JOINs provide flexibility in querying data by enabling complex relationships between tables to be expressed in a straightforward manner.

Normalization: Relational databases typically use normalization to reduce data redundancy.
JOINs are essential for retrieving denormalized data when needed, effectively balancing between normalized storage and denormalized retrieval.
7). Explain the GROUP BY clause and its role in aggregation operations.

In PostgreSQL (and in SQL in general), the GROUP BY clause is used in conjunction with aggregate functions 
to group rows that have the same values in one or more columns. It plays a crucial role in aggregation operations by allowing you to perform calculations
and analysis over groups of rows rather than the entire result set.
8. How can you calculate aggregate functions like COUNT, SUM, and AVG in
PostgreSQL?

i)SELECT COUNT(*)
FROM table_name;

ii)SELECT SUM(column_name)
FROM table_name;

iii)SELECT AVG(column_name)
FROM table_name;


9. What is the purpose of an index in PostgreSQL, and how does it optimize query
performance?

An index is a database object that improves the speed of data retrieval operations on a table at the cost 
of additional storage space and some overhead during insert and update operations. Indexes play a crucial role in optimizing query performance
by allowing the database server to quickly locate rows in tables based on the values of indexed columns.
Purpose of an Index:
Faster Data Retrieval: Indexes provide a quick lookup mechanism, similar to the index of a book, which allows PostgreSQL
 to locate specific rows efficiently without scanning the entire table.

Support for Constraints: Indexes are used to enforce constraints like primary keys, unique constraints, and exclusion constraints, 
ensuring data integrity
10. Explain the concept of a PostgreSQL view and how it differs from a table

A view in PostgreSQL is a virtual table created from a SQL querys result set.
 It behaves like a regular table in many ways, but it does not physically store data on its own. 
 Instead, it retrieves data dynamically from its underlying tables or other views whenever it is queried.
 
Difference
Data Storage: A table physically stores data, while a view does not store data directly but derives it from underlying tables or views dynamically.

Schema Definition: Tables have a fixed schema defined by column definitions, 
whereas a views schema is defined by the SELECT statement that creates it.

Updateability: In PostgreSQL, views can be updatable under certain conditions 
(simple SELECT statements without joins or aggregates), whereas tables are directly updatable with INSERT, UPDATE, and DELETE commands.
