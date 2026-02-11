cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(iso_c_const C CXX Fortran)

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug
        CACHE STRING "Build type (Debug, Release)" FORCE)
endif ()

enable_testing()

add_library(iso_c_binding_constants_01 iso_c_binding_constants_01.f90)
add_library(iso_c_binding_constants_02 iso_c_binding_constants_02.f90)

add_executable(test_iso_c_binding_constants_01 test_iso_c_binding_constants_01.f90)

add_executable(test_iso_c_binding_constants_02 test_iso_c_binding_constants_02.f90)

target_link_libraries(test_iso_c_binding_constants_01 iso_c_binding_constants_01)

target_link_libraries(test_iso_c_binding_constants_02 iso_c_binding_constants_02)

add_test(test_iso_c_binding_constants_01 ${CURRENT_BINARY_DIR}/test_iso_c_binding_constants_01)
add_test(test_iso_c_binding_constants_02 ${CURRENT_BINARY_DIR}/test_iso_c_binding_constants_02)

message("\n")
message("Configuration results")
message("---------------------")
message("Fortran compiler: ${CMAKE_Fortran_COMPILER}")
message("C++ compiler    : ${CMAKE_CXX_COMPILER}")
message("C compiler      : ${CMAKE_C_COMPILER}")
message("Build type: ${CMAKE_BUILD_TYPE}")
string(TOUPPER "${CMAKE_BUILD_TYPE}" BTYPE)
message("Fortran compiler flags: ${CMAKE_Fortran_FLAGS_${BTYPE}}")
message("C++ compiler flags    : ${CMAKE_CXX_FLAGS_${BTYPE}}")
message("C compiler flags      : ${CMAKE_C_FLAGS_${BTYPE}}")
message("Installation prefix: ${CMAKE_INSTALL_PREFIX}")


