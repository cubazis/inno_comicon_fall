cmake_minimum_required(VERSION 3.10)
project(lab8)

set(CMAKE_CXX_STANDARD 11)

include_directories(src)

add_executable(lab8
        src/chunk.c
        src/chunk.h
        src/common.h
        src/compiler.c
        src/compiler.h
        src/debug.c
        src/debug.h
        src/main.c
        src/memory.c
        src/memory.h
        src/object.c
        src/object.h
        src/scanner.c
        src/scanner.h
        src/table.c
        src/table.h
        src/value.c
        src/value.h
        src/vm.c
        src/vm.h
        util/c.make
        util/test.py
        Makefile
        README.md
        test)
