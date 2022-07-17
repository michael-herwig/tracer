# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>

if(DEFINED TOOLCHAIN_SHARED_TIX_FIND_COMPILER_CMAKE_INCLUDED)
  return()
endif()
set(TOOLCHAIN_SHARED_TIX_FIND_COMPILER_CMAKE_INCLUDED ON)

include(tix_fatal)

# tix_find_compiler(
#   <var>           << Variable name to be used to store/cache the program path
#   <cname>         << The compiler name to look for.
# )
# Looks for the named compiler and stores it for further usage,
# a fatal error is reported if the program is not found.
macro(tix_find_compiler var cname)
  # Clear cached variables that may be defined previously,
  # otherwise find_program may skip even if the name of the
  # program changed. This is the case if the IDE may decide
  # to pass a default compiler on the command line.
  if(DEFINED ${var})
    unset(${var} CACHE)
  endif()

  set(help_string "n/a")
  set(help_name "${var}")
  if("${var}" MATCHES "CMAKE_(.+)_COMPILER")
    string(TOLOWER ${CMAKE_MATCH_1} name)
    set(help_string "The full path to the compiler for ${name}.")
    set(help_name "${name} compiler")
  endif()

  find_program(${var} ${cname})
  if(NOT ${var})
      tix_fatal("${help_name} not found.")
  endif()

  set(${var} "${${var}}" CACHE INTERNAL ${help_string} FORCE)
endmacro()
