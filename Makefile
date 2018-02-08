

# ----------------------------------------------------------------------
# adjust the following to the location of your Lua include file

INCFLAGS= -I../lua/include

# ----------------------------------------------------------------------

CC= gcc
AR= ar

CFLAGS= -Os -fPIC $(INCFLAGS) 
LDFLAGS= -fPIC

LUASQLEET_O= luasqleet.o luasql.o sqleet.o

luasqleet.so:  src/*.c src/*.h
	$(CC) -c $(CFLAGS) src/sqleet.c src/luasql.c src/luasqleet.c
	$(CC) -shared $(LDFLAGS) -o luasqleet.so $(LUASQLEET_O) -lpthread -ldl 

shell: luasqleet.so
	$(CC) -c $(CFLAGS) src/shell.c
	$(CC) -o sqleet shell.o sqleet.o -lpthread -ldl 

test: luasqleet.so
	lua test.lua
	
clean:
	rm -f *.o *.a *.so sqleet

.PHONY: clean shell

