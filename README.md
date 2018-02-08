# luasqleet

This is a Lua binding for Sqleet, an encrypted extension to SQLite3.  This is an alpha version.

Sqleet is a cool encryption extension for SQLite, by github user Resilar. See https://github.com/resilar/sqleet.  It is a very nice and easy to read implementation of a SQLite encryption codec (much simpler than SQLCipher).  

Sqleet uses Chacha20 / Poly1305 for authenticated encryption and 
PBKDF2 for key derivation.

Luasqleet uses the (hardly modified) SQLite driver from LuaSQL.

The API is identical to luasql.sqlite3. See the [LuaSQL manual](http://htmlpreview.github.com/?https://github.com/keplerproject/luasql/blob/master/doc/us/manual.html).

The encryption key is derived from a password. The password is set with the standard SQLite syntax (`PRAGMA key = 'some password'` - see file test.lua).

Luasqleet includes the SQLite 3.21 amalgamation, so the luasqleet.so Lua extension module can be built without any dependancy.

### Credit

- Of course, D. Richard Hipp for the wonderful [SQLite](https://www.sqlite.org/)

- [Resilar](https://github.com/resilar/sqleet), for this nice encryption codec 

- The Kepler Project contributors for [LuaSQL](https://github.com/keplerproject/luasql) - The luasqleet.c, luasql.c/.h and test1.lua files come from LuaSQL. They have hardly been modified.


### License

SQLite and Sqleet are public domain.

LuaSQL uses the same license as Lua (MIT).

Luasqleet license is also MIT.








