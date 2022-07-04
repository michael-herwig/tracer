# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>

if(DEFINED TOOLCHAIN_SHARED_TIX_STD_20_CMAKE_INCLUDED20_CMAKE_INCLUDED20_CMAKE)
  return()
endif()
set(TOOLCHAIN_SHARED_TIX_STD_20_CMAKE_INCLUDED20_CMAKE_INCLUDED20_CMAKE ON)

set(CMAKE_C_STANDARD 11 CACHE INTERNAL "Default value for C_STANDARD property of targets.")
set(CMAKE_C_STANDARD_REQUIRED ON CACHE INTERNAL "Default value for C_STANDARD_REQUIRED property of targets.")
set(CMAKE_C_EXTENSIONS OFF CACHE INTERNAL "Default value for C_EXTENSIONS property of targets.")

set(CMAKE_CXX_STANDARD 20 CACHE INTERNAL "Default value for CXX_STANDARD property of targets.")
set(CMAKE_CXX_STANDARD_REQUIRED ON CACHE INTERNAL "Default value for CXX_STANDARD_REQUIRED property of targets.")
set(CMAKE_CXX_EXTENSIONS OFF CACHE INTERNAL "Default value for CXX_EXTENSIONS property of targets.")

include(tix_fatal)
include(tix_add_flag)

if(TIX_STYLE_GNU)
  tix_add_flag(CMAKE_C_FLAGS   -std=c11)
  tix_add_flag(CMAKE_CXX_FLAGS -std=c++20)
elseif(TIX_STYLE_MSVC)
  tix_add_flag(CMAKE_C_FLAGS   /std:c11)
  tix_add_flag(CMAKE_CXX_FLAGS /std:c++20)
elseif()
  tix_fatal("unsupported configuration, cannot setup std20 standard")
endif()
