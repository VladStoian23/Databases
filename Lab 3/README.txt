Instructions
Sometimes, after we design a database, we need to change its structure. But,
unfortunately, not all the changes performed are correctly every time, so they
must be reverted. The task is to create a versioning mechanism that will facilitate
the transition between different versions of the database.

For the database created for the first lab, write SQL scripts that:
add / remove a column;
add / remove a DEFAULT constraint;
create / drop a table;
add / remove a foreign key.
For each of the scripts above, write another one that reverts the operation. Also,
create a new table in which will be hold the current version of the database. For
simplicity, the version of the database is assumed to be an integer number.

Place each of the scripts in a different stored procedure and use a simple and
intuitive naming convention.

Write another stored procedure that receives as a parameter a version number and
brings the database to that version.