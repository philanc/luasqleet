![CI](https://github.com/philanc/luasqleet/workflows/CI/badge.svg)

# luasqleet

This is a Lua binding for Sqleet, an encrypted extension to SQLite3.  It has been tested on Linux with Lua 5.3 and 5.4.

Sqleet is a nice encryption extension for SQLite, by github user Resilar. See https://github.com/resilar/sqleet.  It is an easy-to-read implementation of a SQLite encryption codec (much simpler than SQLCipher).  

Sqleet uses Chacha20 / Poly1305 for authenticated encryption and 
PBKDF2 for key derivation.

Luasqleet uses the lsqlite3 driver written by Tiago Dionizio, Doug Currie and hosted at http://lua.sqlite.org/index.cgi/index

The API is identical to lsqlite3. See the [lsqlite3 manual](http://lua.sqlite.org/index.cgi/doc/tip/doc/lsqlite3.wiki).

The encryption key is derived from a password. The password is set with the standard SQLite syntax:
```
PRAGMA key = 'some password' 
```

For example, let's create a new encrypted database and insert some values in it:
```
local sq = require("luasqleet")

-- create an empty database
local db = sq.open('test.db') 

-- activate encryption - set the password 
-- (the password value can be any string)
db:exec[[ PRAGMA key='abc' ]] 

-- create a table and insert some values in it
db:exec[[
  CREATE TABLE test (id INTEGER PRIMARY KEY, content);
  INSERT INTO test VALUES (NULL, 'Hello World');
  INSERT INTO test VALUES (NULL, 'Hello Lua');
  INSERT INTO test VALUES (NULL, 'Hello Sqlite3')
]]

db:close()
```

Open an existing encrypted database and read the content:
```
local sq = require("luasqleet")

-- open an encrypted database created in the previous example
local db = sq.open('test.db') 

-- enter the password to enable on the fly encryption/decryption
db:exec[[ PRAGMA key='abc' ]] 

-- read and display the content
for row in db:nrows("SELECT * FROM test") do
  print(row.id, row.content)
end

db:close()
```

The encrypted database can also be examined with `sqleet`, the encrypted sqlite3 shell:
```
$ ./sqleet test.db 
  SQLite version 3.31.1 2020-01-27 19:55:54
  Enter ".help" for usage hints.
  
sqlite> # try to display database content
sqlite> # => database is encrypted so is not
sqlite> # recognized as a valid scqlite3 database
sqlite> .dump
  PRAGMA foreign_keys=OFF;
  BEGIN TRANSACTION;
  /**** ERROR: (26) file is not a database *****/
  ROLLBACK; -- due to errors

sqlite> # enter the database password
sqlite> pragma key = 'abc';
  ok

sqlite> # now it recognized as a valid sqlite3 database:
sqlite> .dump
  PRAGMA foreign_keys=OFF;
  BEGIN TRANSACTION;
  CREATE TABLE test (id INTEGER PRIMARY KEY, content);
  INSERT INTO test VALUES(1,'Hello World');
  INSERT INTO test VALUES(2,'Hello Lua');
  INSERT INTO test VALUES(3,'Hello Sqlite3');
  COMMIT;

sqlite> .quit
```


Luasqleet includes the SQLite and sqleet codec amalgamation (sqlite3 version 3.31.1) , so luasqleet.so can be built without any dependancy.

To build luasqleet.so:

```
# adjust the path to the Lua include directory (at the top of Makefile)
# then:

make
```

It also builds `sqleet`, the sqlite3 shell with the same encryption extension.


### Credit

- Of course, D. Richard Hipp for the wonderful [SQLite](https://www.sqlite.org/)

- [Resilar](https://github.com/resilar/sqleet), for this nice encryption codec 

- Tiago Dionizio and Doug Currie for the [lsqlite3](http://lua.sqlite.org/index.cgi/index) Lua wrapper


### License

SQLite and Sqleet are public domain.

lsqlite3 and luasqleet use the same license as Lua (MIT). lsqlite3 copyright and license notice are at the top of src/lsqlite3.c.








