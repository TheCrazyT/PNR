all: create_tbl.exe

create_tbl.exe: create_tbl.c
	gcc -DSTART=3 -Wall  -std=c99 -o create_tbl.exe create_tbl.c
