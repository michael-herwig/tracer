# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>
cmake_minimum_required(VERSION 3.22)

# ---------------------------------------------------------------------------- #
# Project Definition                                                           #
# ---------------------------------------------------------------------------- #
project(loop HOMEPAGE_URL "https://github.com/michael-herwig/loop"
  VERSION "0.0.0")

# ---------------------------------------------------------------------------- #
# Library                                                                      #
# ---------------------------------------------------------------------------- #
set(inc_dir "${CMAKE_CURRENT_SOURCE_DIR}/inc")
set(src_dir "${CMAKE_CURRENT_SOURCE_DIR}/src")

file(GLOB_RECURSE inc_files "${inc_dir}/**.hpp")
file(GLOB_RECURSE int_files RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "${inc_dir}/**.hpp")
file(GLOB_RECURSE src_files "${src_dir}/**.hpp" "${src_dir}/**.cpp")

source_group(TREE "${inc_dir}" PREFIX "inc" FILES ${inc_files})
source_group(TREE "${src_dir}" PREFIX "src" FILES ${src_files})

add_library(loop)
add_library(loop::loop ALIAS loop)

target_sources(loop PUBLIC $<INSTALL_INTERFACE:${int_files}> $<BUILD_INTERFACE:${inc_files}>
  PRIVATE $<BUILD_INTERFACE:${src_files}>)

target_include_directories(loop PUBLIC $<INSTALL_INTERFACE:inc> $<BUILD_INTERFACE:${inc_dir}>
  PRIVATE $<BUILD_INTERFACE:${src_dir}>)

set_target_properties(loop PROPERTIES C_EXTENSIONS ON CXX_EXTENSIONS OFF)
