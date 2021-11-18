
# ----------------------------------------------------------------------
# adjust the following according to your Lua install
#
#	LUADIR can be defined. In that case, 
#   Lua binary and include files are to be found repectively in 
#   $(LUADIR)/bin and $(LUADIR)/include
#
#	Or LUA and LUAINC can be directly defined as the path of the 
#	Lua executable and the path of the Lua include directory,
#	respectively.

LUADIR ?= ../lua
LUA ?= $(LUADIR)/bin/lua
LUAINC ?= $(LUADIR)/include

# ----------------------------------------------------------------------

CC ?= gcc
AR ?= ar

CFLAGS= -Os -fPIC -I$(LUAINC)
LDFLAGS= -fPIC

OBJS= lsqlite3.o sqleet.o

all: shell luasqleet.so

luasqleet.so:  src/*.c src/*.h
	$(CC) -c $(CFLAGS) src/sqleet.c src/lsqlite3.c
	$(CC) -shared $(LDFLAGS) -o luasqleet.so $(OBJS) -lpthread -ldl 

shell: luasqleet.so
	$(CC) -c $(CFLAGS) src/shell.c
	$(CC) -o sqleet shell.o sqleet.o -lpthread -ldl 
	strip sqleet

test: luasqleet.so
	$(LUA) test.lua
	
clean:
	rm -f *.o *.a *.so sqleet test.db

.PHONY: clean shell

