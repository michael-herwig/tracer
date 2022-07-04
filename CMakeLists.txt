# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>
cmake_minimum_required(VERSION 3.22)

# ---------------------------------------------------------------------------- #
# Project Definition                                                           #
# ---------------------------------------------------------------------------- #
include("${CMAKE_CURRENT_LIST_DIR}/cmake/utility.cmake")
parse_version(loop_VERSION FILEPATH "${CMAKE_CURRENT_LIST_DIR}/VERSION")
project(loop HOMEPAGE_URL "https://github.com/michael-herwig/loop"
  VERSION "${loop_VERSION}")

# ---------------------------------------------------------------------------- #
# Options                                                                      #
# ---------------------------------------------------------------------------- #
option(LOOP_SKIP_VERSION_UPDATE "skips update of embedded version info" OFF)

# ---------------------------------------------------------------------------- #
# Library                                                                      #
# ---------------------------------------------------------------------------- #
set(inc_dir "${loop_SOURCE_DIR}/inc")
set(src_dir "${loop_SOURCE_DIR}/src")

file(GLOB_RECURSE inc_files "${inc_dir}/**.hpp")
file(GLOB_RECURSE int_files RELATIVE "${loop_SOURCE_DIR}" "${inc_dir}/**.hpp")
file(GLOB_RECURSE src_files "${src_dir}/**.hpp" "${src_dir}/**.cpp")

source_group(TREE "${inc_dir}" PREFIX "inc" FILES ${inc_files})
source_group(TREE "${src_dir}" PREFIX "src" FILES ${src_files})

add_library(loop)
add_library(loop::loop ALIAS loop)

target_sources(loop PUBLIC $<INSTALL_INTERFACE:${int_files}> $<BUILD_INTERFACE:${inc_files}>
  PRIVATE $<BUILD_INTERFACE:${src_files};${version_info_template}>)

target_include_directories(loop PUBLIC $<INSTALL_INTERFACE:inc> $<BUILD_INTERFACE:${inc_dir}>
  PRIVATE $<BUILD_INTERFACE:${src_dir}>)

set_target_properties(loop PROPERTIES C_EXTENSIONS ON CXX_EXTENSIONS OFF)

# ---------------------------------------------------------------------------- #
# Generate                                                                     #
# ---------------------------------------------------------------------------- #
set(gen_dir "${loop_BINARY_DIR}/gen")
set(gen_inc "${gen_dir}/inc")
set(gen_src "${gen_dir}/src")
set(gen_hdr "${gen_inc}/loop")

target_include_directories(loop PUBLIC $<BUILD_INTERFACE:${gen_inc}>)

# >>> version.cpp
set(version_script "${loop_SOURCE_DIR}/cmake/version.cmake")
set(version_cpp "${loop_SOURCE_DIR}/cmake/version.cpp")
set(version_out "${gen_src}/version$<$<CONFIG:DEBUG>:d>.cpp")
add_custom_target(gen-version BYPRODUCTS "${version_out}" SOURCES "${version_script}" "${version_cpp}"
  COMMAND "${CMAKE_COMMAND}" -DPROJECT_VERSION="${loop_VERSION}" -DSKIP="${LOOP_SKIP_VERSION_UPDATE}"
    -DINPUT_FILE="${version_cpp}" -DOUTPUT_FILE="${version_out}" -P "${version_script}"
  WORKING_DIRECTORY "${loop_SOURCE_DIR}")

source_group("" FILES "${version_script}" "${version_cpp}")

target_sources(loop PRIVATE $<BUILD_INTERFACE:${version_out}>)

# >>> loop/config.hpp
set(config_hpp "${loop_SOURCE_DIR}/config.hpp")
set(config_out "${gen_hdr}/config.hpp")

include(TestBigEndian)
test_big_endian(LOOP_BIG_ENDIAN)

configure_file("${config_hpp}" "${config_out}" @ONLY)

source_group("" FILES "${config_hpp}")
target_sources(loop PUBLIC $<BUILD_INTERFACE:${config_hpp}>)
