
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

db:close()

print[[
------------------------------------------------------------------------
An encrypted database has been created in 'test.db' with password 'abc'.
Now, let's dump it with the shell 'sqleet':
------------------------------------------------------------------------
]]

assert(os.execute [[
./sqleet test.db << EOF
pragma key = 'abc' ;
.dump
.quit
EOF
]])

print[[

luasqleet test:  ok.
------------------------------------------------------------------------
]]


