
local sq = require("luasqleet")

local db = sq.open('test.db')

db:exec[[ PRAGMA key='abc' ]]
db:exec[[ DROP TABLE test]]


db:exec[[
  CREATE TABLE test (id INTEGER PRIMARY KEY, content);

  INSERT INTO test VALUES (NULL, 'Hello World');
  INSERT INTO test VALUES (NULL, 'Hello Lua');
  INSERT INTO test VALUES (NULL, 'Hello Sqlite3')
]]

print[[
------------------------------------------------------------------------
Table 'test' content:
]]

for row in db:nrows("SELECT * FROM test") do
  print(row.id, row.content)
end

print[[
------------------------------------------------------------------------
An encrypted database has been created in 'test.db' with password 'abc'.
Open test.db with the shell 'sqleet':

   ./sqleet test.db

Try to dump the content of the DB:

   .dump
   
test.db is not recognized as a sqlite file. Password must be entered:

   pragma key = 'abc' ;
   
Now,  the DB can be accessed. '.dump' display its content.
------------------------------------------------------------------------
]]

db:close()

