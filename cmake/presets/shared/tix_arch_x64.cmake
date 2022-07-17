# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>

if(DEFINED TOOLCHAIN_SHARED_TIX_ARCH_X64_CMAKE_INCLUDED64_CMAKE_INCLUDED64_CMAKE)
  return()
endif()
set(TOOLCHAIN_SHARED_TIX_ARCH_X64_CMAKE_INCLUDED64_CMAKE_INCLUDED64_CMAKE ON)

include(tix_fatal)
include(tix_add_flag)

if(TIX_STYLE_GNU)
  tix_add_flag(CMAKE_C_FLAGS   -m64)
  tix_add_flag(CMAKE_CXX_FLAGS -m64)
elseif(NOT TIX_GENERATOR_VS)
  tix_fatal("unsupported configuration, cannot enable x64 architecture")
endif()

if(TIX_GENERATOR_VS)
  if(TIX_GENERATOR_VS_YEAR GREATER_EQUAL 2019)
    set(CMAKE_GENERATOR_PLATFORM x64 CACHE STRING "Native build system toolset specification provided by user." FORCE)
  elseif(NOT TIX_GENERATOR_VS_ARCH STREQUAL "Win64")
    tix_fatal("invalid vs generator for 64bit, use 'Visual Studio ${TIX_GENERATOR_VS_MAJOR} ${TIX_GENERATOR_VS_YEAR} Win64'")
  endif()
endif()
