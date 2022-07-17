# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>
cmake_minimum_required(VERSION 3.22)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/modules")

# -------------------------------------------------------------------------------------------------------------------- #
# Hunter                                                                                                               #
# -------------------------------------------------------------------------------------------------------------------- #
# https://raw.githubusercontent.com/cpp-pm/gate/master/cmake/HunterGate.cmake
include("${CMAKE_CURRENT_LIST_DIR}/cmake/hunter_gate.cmake")
# https://github.com/cpp-pm/hunter/releases
HunterGate(
  URL "https://github.com/cpp-pm/hunter/archive/v0.24.3.tar.gz"
  SHA1 "10738b59e539818a01090e64c2d09896247530c7"
  FILEPATH "${CMAKE_CURRENT_LIST_DIR}/cmake/hunter_config.cmake"
)

set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS
  "${CMAKE_CURRENT_LIST_DIR}/cmake/hunter_config.cmake")

# -------------------------------------------------------------------------------------------------------------------- #
# Project Definition                                                                                                   #
# -------------------------------------------------------------------------------------------------------------------- #
include("${CMAKE_CURRENT_LIST_DIR}/cmake/utility.cmake")
parse_version(tracer_VERSION FILEPATH "${CMAKE_CURRENT_LIST_DIR}/VERSION")
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
project(tracer HOMEPAGE_URL "https://github.com/michael-herwig/tracer"
  VERSION "${tracer_VERSION}")

# -------------------------------------------------------------------------------------------------------------------- #
# Options                                                                                                              #
# -------------------------------------------------------------------------------------------------------------------- #
option(TRACER_ENABLE_PEDANTIC "enables pedantic warning settings" OFF)
option(TRACER_ENABLE_WERROR "treats warnings as errors" OFF)
option(TRACER_BUILD_COVERAGE "enables test coverage support" OFF)

option(TRACER_SKIP_VERSION_UPDATE "skips update of embedded version info" OFF)

# >>> TRACER_BUILD_SHARED, TRACER_LINKAGE
set(shared_default OFF)
if(BUILD_SHARED_LIBS)
  set(shared_default ON)
endif()
option(TRACER_BUILD_SHARED "" ${shared_default})
unset(shared_default)

set(TRACER_LINKAGE STATIC)
if(TRACER_BUILD_SHARED)
  set(TRACER_LINKAGE SHARED)
endif()

# >>> TRACER_BUILD_TESTING
set(testing_default OFF)
if(BUILD_TESTING)
  set(testing_default ON)
endif()
option(TRACER_BUILD_TESTING "" ${testing_default})
unset(testing_default)

# >>> TRACER_ENABLE_CPPCHECK
set(_cppcheck_default OFF)
find_package(cppcheck QUIET)
if(cppcheck_FOUND AND CMAKE_EXPORT_COMPILE_COMMANDS)
  set(_cppcheck_default ON)
endif()
option(TRACER_ENABLE_CPPCHECK "enables the cppcheck target" ${_cppcheck_default})
unset(_cppcheck_default)

# >>> TRACER_ENABLE_CLANGTIDY
set(_clangtidy_default OFF)
find_package(clang-tools COMPONENTS tidy QUIET)
find_package(Python COMPONENTS Interpreter QUIET)
if(clang-tidy_FOUND AND Python_Interpreter_FOUND)
  set(_clangtidy_default ON)
endif()
option(TRACER_ENABLE_CLANGTIDY "enables the clang-tidy target" ${_clangtidy_default})
unset(_clangtidy_default)


# -------------------------------------------------------------------------------------------------------------------- #
# Dependencies                                                                                                         #
# -------------------------------------------------------------------------------------------------------------------- #
if(TRACER_BUILD_TESTING)
  hunter_add_package(GTest)
  find_package(GTest CONFIG REQUIRED)
endif()

# -------------------------------------------------------------------------------------------------------------------- #
# Coverage Interface                                                                                                   #
# -------------------------------------------------------------------------------------------------------------------- #

add_library(tracer-coverage INTERFACE)
add_library(tracer::coverage ALIAS tracer-coverage)

target_compile_options(tracer-coverage INTERFACE
  $<$<CXX_COMPILER_ID:GNU,Clang>:-g -O0 --coverage -ftest-coverage -fprofile-arcs>)
target_link_options(tracer-coverage INTERFACE
  $<$<CXX_COMPILER_ID:GNU,Clang>:-lgcov --coverage>)

# -------------------------------------------------------------------------------------------------------------------- #
# Library                                                                                                              #
# -------------------------------------------------------------------------------------------------------------------- #
set(inc_dir "${tracer_SOURCE_DIR}/inc")
set(src_dir "${tracer_SOURCE_DIR}/src")

file(GLOB_RECURSE inc_files RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "${inc_dir}/**.hpp")
file(GLOB_RECURSE int_files RELATIVE "${tracer_SOURCE_DIR}" "${inc_dir}/**.hpp")
file(GLOB_RECURSE src_files "${src_dir}/**.hpp" "${src_dir}/**.cpp")

source_group(TREE "${inc_dir}" PREFIX "inc" FILES ${inc_files})
source_group(TREE "${src_dir}" PREFIX "src" FILES ${src_files})

add_library(tracer ${TRACER_LINKAGE})
add_library(tracer::tracer ALIAS tracer)

target_sources(tracer PUBLIC $<INSTALL_INTERFACE:${int_files}> PRIVATE $<BUILD_INTERFACE:${int_files}>
  $<BUILD_INTERFACE:${src_files}>)

target_include_directories(tracer PUBLIC $<INSTALL_INTERFACE:inc> $<BUILD_INTERFACE:${inc_dir}>
  PRIVATE $<BUILD_INTERFACE:${src_dir}>)

target_compile_definitions(tracer PUBLIC $<$<NOT:$<CONFIG:DEBUG>>:NDEBUG>)

target_compile_options(tracer PRIVATE
  # GNU
  "$<$<AND:$<BOOL:${TRACER_ENABLE_PEDANTIC}>,$<CXX_COMPILER_ID:GNU>>:-Wall;-Wextra;-Wpedantic>"
  "$<$<AND:$<BOOL:${TRACER_ENABLE_WERROR}>,$<CXX_COMPILER_ID:GNU>>:-Werror>"

  # CLANG
  "$<$<AND:$<BOOL:${TRACER_ENABLE_PEDANTIC}>,$<CXX_COMPILER_ID:Clang>>:-Wall;-Wextra;-pedantic>"
  "$<$<AND:$<BOOL:${TRACER_ENABLE_WERROR}>,$<CXX_COMPILER_ID:Clang>>:-Werror;-pedantic-errors>"

  # MSVC
  "$<$<AND:$<BOOL:${TRACER_ENABLE_PEDANTIC}>,$<CXX_COMPILER_ID:MSVC>>:/W3;/Wv:18>"
  "$<$<AND:$<BOOL:${TRACER_ENABLE_WERROR}>,$<CXX_COMPILER_ID:MSVC>>:/WX>"
)

set_target_properties(tracer PROPERTIES C_EXTENSIONS ON CXX_EXTENSIONS OFF)
target_link_libraries(tracer PRIVATE $<$<BOOL:${TRACER_BUILD_COVERAGE}>:tracer::coverage>)

# -------------------------------------------------------------------------------------------------------------------- #
# Generate                                                                                                             #
# -------------------------------------------------------------------------------------------------------------------- #
set(gen_dir "${tracer_BINARY_DIR}/gen")
set(gen_inc "${gen_dir}/inc")
set(gen_src "${gen_dir}/src")
set(gen_hdr "${gen_inc}/tracer")

target_include_directories(tracer PUBLIC $<BUILD_INTERFACE:${gen_inc}>)

# >>> version.cpp
set(version_script "${tracer_SOURCE_DIR}/cmake/version.cmake")
set(version_cpp "${tracer_SOURCE_DIR}/cmake/version.cpp")
set(version_out "${gen_src}/version$<$<CONFIG:DEBUG>:d>.cpp")
set(version_target "tracer-version")
add_custom_target("${version_target}" BYPRODUCTS "${version_out}" SOURCES "${version_script}" "${version_cpp}"
  COMMAND "${CMAKE_COMMAND}" -DPROJECT_VERSION="${tracer_VERSION}" -DSKIP="${TRACER_SKIP_VERSION_UPDATE}"
    -DINPUT_FILE="${version_cpp}" -DOUTPUT_FILE="${version_out}" -P "${version_script}"
  WORKING_DIRECTORY "${tracer_SOURCE_DIR}")

source_group("" FILES "${version_script}" "${version_cpp}")

target_sources(tracer PRIVATE $<BUILD_INTERFACE:${version_out}>)

# >>> tracer/config.hpp
set(config_hpp "${tracer_SOURCE_DIR}/config.hpp")
set(config_out "${gen_hdr}/config.hpp")

include(TestBigEndian)
test_big_endian(TRACER_BIG_ENDIAN)

configure_file("${config_hpp}" "${config_out}" @ONLY)

source_group("" FILES "${config_hpp}")
target_sources(tracer PRIVATE $<BUILD_INTERFACE:${config_hpp}>)

# -------------------------------------------------------------------------------------------------------------------- #
# Testing                                                                                                              #
# -------------------------------------------------------------------------------------------------------------------- #
if(TRACER_BUILD_TESTING)
  set(test_dir "${tracer_SOURCE_DIR}/test")
  file(GLOB_RECURSE test_files "${test_dir}/**.hpp" "${test_dir}/**.cpp")
  source_group(TREE "${test_dir}" PREFIX "" FILES ${test_files})

  add_executable(tracer-test)
  add_executable(tracer::test ALIAS tracer-test)

  target_sources(tracer-test PRIVATE ${test_files})
  target_include_directories(tracer-test PRIVATE "${test_dir}")
  target_link_libraries(tracer-test PRIVATE tracer GTest::gmock_main)

  enable_testing()
  add_test(NAME tracer-test WORKING_DIRECTORY "${tracer_BINARY_DIR}" COMMAND tracer::test
    "--gtest_output=xml:${CMAKE_CURRENT_BINARY_DIR}/test-report-$<LOWER_CASE:$<CONFIG>>.xml")
endif()

# -------------------------------------------------------------------------------------------------------------------- #
# Cppcheck                                                                                                             #
# -------------------------------------------------------------------------------------------------------------------- #
if(TRACER_ENABLE_CPPCHECK)
  find_package(cppcheck REQUIRED)
  require_compile_commands()

  set(cppcheck_config "${tracer_SOURCE_DIR}/.cppcheck")
  set(cppcheck_bindir "${tracer_BINARY_DIR}/cppcheck")

  add_custom_target(
    tracer-cppcheck

    COMMAND "${CMAKE_COMMAND}" -E make_directory "${cppcheck_bindir}/plist" "${cppcheck_bindir}/build"
    COMMAND "${cppcheck_EXECUTABLE}"
      --project=compile_commands.json
      --suppress=missingInclude
      --inconclusive
      --enable=all
      --inline-suppr
      --template=gcc
      --max-ctu-depth=8
      --quiet
      --language=c++

      # TODO(michael-herwig) --std=
      # TODO(michael-herwig) --platform=

      --relative-paths="${tracer_SOURCE_DIR};${gen_dir}"
      --file-filter="${tracer_SOURCE_DIR}/inc/*"
      --file-filter="${tracer_SOURCE_DIR}/src/*"
      --file-filter="${tracer_SOURCE_DIR}/test/*"
      --suppressions-list="${cppcheck_config}"
      --plist-output="${cppcheck_bindir}/plist"
      --cppcheck-build-dir="${cppcheck_bindir}/build"
      -DCPPCHECK

      $<$<BOOL:${TRACER_ENABLE_WERROR}>:--error-exitcode=255>
      $<$<BOOL:$<TARGET_PROPERTY:tracer,CXX_STANDARD>>:--std=c++$<TARGET_PROPERTY:tracer,CXX_STANDARD>>
      $<$<NOT:$<CONFIG:DEBUG>>:-DNDEBUG>

    SOURCES
      "${cppcheck_config}"

    DEPENDS
      "${version_target}"

    WORKING_DIRECTORY
      "${tracer_BINARY_DIR}"
  )
endif()

# -------------------------------------------------------------------------------------------------------------------- #
# clang-tidy                                                                                                           #
# -------------------------------------------------------------------------------------------------------------------- #
if(TRACER_ENABLE_CLANGTIDY)
  find_package(clang-tools REQUIRED COMPONENTS tidy)
  find_package(Python COMPONENTS Interpreter REQUIRED)
  require_compile_commands()

  set(clang_tidy_cfg "${tracer_SOURCE_DIR}/.clang-tidy")
  set(clang_tidy_script "${tracer_SOURCE_DIR}/cmake/clang-tidy.py")

  add_custom_target(
    tracer-clangtidy

    COMMAND ${Python_EXECUTABLE} "${clang_tidy_script}"
      -clang-tidy-binary="${clang-tidy_EXECUTABLE}"
      -p="${tracer_BINARY_DIR}" -quiet
      $<$<BOOL:${TRACER_ENABLE_WERROR}>:--warnings-as-errors=*>

    SOURCES
      "${clang_tidy_cfg}"

    WORKING_DIRECTORY
      ${tracer_SOURCE_DIR}
  )
endif()
