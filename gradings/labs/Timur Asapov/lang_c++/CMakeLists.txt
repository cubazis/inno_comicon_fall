cmake_minimum_required(VERSION 3.10)
project(lab1 C)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99 -Wall -Wextra -Wshadow")

set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -O0 -g")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/CMakeModules/")

set(BUILD_1 main)
set(SOURCE_FILES_1 demo.c src/parcer.c)
add_executable(${BUILD_1} ${SOURCE_FILES_1})

enable_testing()

add_subdirectory(tests)