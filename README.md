# luasqleet

This is a Lua binding for Sqleet, an encrypted extension to SQLite3.  This is an alpha version, tested on Linux with Lua 5.3.

Sqleet is a cool encryption extension for SQLite, by github user Resilar. See https://github.com/resilar/sqleet.  It is a very nice and easy to read implementation of a SQLite encryption codec (much simpler than SQLCipher).  

Sqleet uses Chacha20 / Poly1305 for authenticated encryption and 
PBKDF2 for key derivation.

Luasqleet uses the lsqlite3 driver written by Tiago Dionizio, Doug Currie and hosted at http://lua.sqlite.org/index.cgi/index

The API is identical to lsqlite3. See the [lsqlite3 manual](http://lua.sqlite.org/index.cgi/doc/tip/doc/lsqlite3.wiki).

The encryption key is derived from a password. The password is set with the standard SQLite syntax:
```
PRAGMA key = 'some password' 
```
See file test.lua.

Luasqleet includes the SQLite amalgamation (sqlite3 version 3.31.1) , so luasqleet.so can be built without any dependancy.

To build luasqleet.so:

```
# adjust the path to the Lua include directory (at the top of Makefile)
# then:

make
```

It also build `sqleet`, the sqlite3 shell with the same encryption extension.


### Credit

- Of course, D. Richard Hipp for the wonderful [SQLite](https://www.sqlite.org/)

- [Resilar](https://github.com/resilar/sqleet), for this nice encryption codec 

- Tiago Dionizio and Doug Currie for the [lsqlite3](http://lua.sqlite.org/index.cgi/index) Lua wrapper


### License

SQLite and Sqleet are public domain.

lsqlite3 and luasqleet use the same license as Lua (MIT). lsqlite3 copyright and license notice are at the top of src/lsqlite3.c.








