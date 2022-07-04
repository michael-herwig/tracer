# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>

if(DEFINED TOOLCHAIN_SHARED_TIX_ARCH_X32_CMAKE_INCLUDED32_CMAKE_INCLUDED32_CMAKE)
  return()
endif()
set(TOOLCHAIN_SHARED_TIX_ARCH_X32_CMAKE_INCLUDED32_CMAKE_INCLUDED32_CMAKE ON)

include(tix_fatal)
include(tix_add_flag)

if(TIX_STYLE_GNU)
  tix_add_flag(CMAKE_C_FLAGS   -m32)
  tix_add_flag(CMAKE_CXX_FLAGS -m32)
elseif(NOT TIX_GENERATOR_VS)
  tix_fatal("unsupported configuration, cannot enable x32 architecture")
endif()

if(TIX_GENERATOR_VS)
  if(TIX_GENERATOR_YEAR GREATER_EQUAL 2019)
    set(CMAKE_GENERATOR_PLATFORM Win32 CACHE STRING "Native build system toolset specification provided by user." FORCE)
  elseif(TIX_GENERATOR_ARCH)
    tix_fatal("invalid vs generator for 32bit, use 'Visual Studio ${TIX_GENERATOR_VS_MAJOR} ${TIX_GENERATOR_VS_YEAR}'")
  endif()
endif()
