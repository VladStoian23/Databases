Consider the database created for the first lab.

a. Implement a stored procedure for the INSERT operation on 2 tables in 1-
n relationship; the procedure’s parameters should describe the entities /
relationships in the tables; the procedure should use at least 1 user-defined
function to validate certain parameters.

b. Create a view that extract data from at least 3 tables and write a SELECT
on the view that returns useful information for a potential user.

c. Implement a trigger for a table, for INSERT, UPDATE or/and DELETE;
the trigger will introduce in a log table, the following data: the date and the
time of the triggering statement, the trigger type (INSERT / UPDATE /
DELETE), the name of the affected table and the number of added /
modified / removed records.

d. Write a query that contains at least 2 of the following operators in the
execution plan (by using WHERE, ORDER BY, JOIN’s clauses):
clustered index scan;
clustered index seek;
nonclustered index scan;
nonclustered index seek;
key lookup