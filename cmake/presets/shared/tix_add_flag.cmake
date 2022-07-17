# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>

if(DEFINED TOOLCHAIN_SHARED_TIX_ADD_FLAG_CMAKE_INCLUDED)
  return()
endif()
set(TOOLCHAIN_SHARED_TIX_ADD_FLAG_CMAKE_INCLUDED ON)

function(tix_add_flag var)
  foreach(flag ${ARGN})
    string(COMPARE EQUAL "${flag}" "" flag_is_empty)
    if(flag_is_empty)
      continue() # skip empty flags
    endif()
    string(FIND " ${${var}} " "${flag}" index)
    if(NOT index EQUAL -1)
      return() # skip already present flags
    endif()

    string(COMPARE EQUAL "${var}" "" var_is_empty)
    if(var_is_empty)
      set(${var} "${flag}" CACHE INTERNAL "" FORCE) # avoid extra space
    else()
      set(${var} "${${var}} ${flag}" CACHE INTERNAL "" FORCE)
    endif()
  endforeach()
endfunction()
