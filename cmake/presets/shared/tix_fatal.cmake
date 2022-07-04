# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>

if(DEFINED TOOLCHAIN_SHARED_TIX_FATAL_CMAKE_INCLUDED)
  return()
endif()
set(TOOLCHAIN_SHARED_TIX_FATAL_CMAKE_INCLUDED ON)

# tix_fatal(
#   <msg>               << error message to print
# )
# Prints a fatal error message, prefixed with a project identifer.
macro(tix_fatal msg)
  message(FATAL_ERROR "[tix] ${msg}")
endmacro()
