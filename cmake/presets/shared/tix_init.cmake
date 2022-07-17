# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>

if(DEFINED TOOLCHAIN_SHARED_TIX_INIT_CMAKE_INCLUDED)
  return()
endif()
set(TOOLCHAIN_SHARED_TIX_INIT_CMAKE_INCLUDED ON)

include(CMakeParseArguments)

include(tix_fatal)

set(TIX_STYLES GNU MSVC)

# tix_init(
#   [STYLE <style>]             << sets the style of compiler command line flags
#   [GENERATOR <generator>]     << asserts to match a specific expected generator
# )
# For Visual Studio generators the script will also initizalize the following variables:
#   - TIX_GENERATOR_VS          << true iff the current CMAKE_GENERATOR matches Visual Studio
#   - TIX_GENERATOR_VS_MAJOR    << major version of the Visual Studio generator in use
#   - TIX_GENERATOR_VS_YEAR     << release year of the Visual Studio generator in use
#   - TIX_GENERATOR_VS_ARCH     << optional architecture part of the Visual Studio generator in use, only for older versions
macro(tix_init)
  cmake_parse_arguments(
    args
      ""
      "STYLE;GENERATOR"
      ""
    ${ARGN}
  )
  get_filename_component(TIX_NAME "${CMAKE_CURRENT_LIST_FILE}" NAME_WE)

  list(FIND TIX_STYLES "${args_STYLE}" style_check)
  if(style_check EQUAL "-1")
    string(style_list " " ${TIX_STYLES})
    tix_fatal("unsupported style '${args_STYLE}'. choose one of ${style_list}")
  endif()

  if(args_STYLE)
    set(TIX_STYLE "${args_STYLE}")
    foreach(style ${TIX_STYLES})
      set(TIX_STYLE_${style} OFF)
    endforeach()
    set(TIX_STYLE_${args_STYLE} ON)
  endif()

  if(args_GENERATOR)
    string(COMPARE EQUAL "${CMAKE_GENERATOR}" "${args_GENERATOR}" generator_check)
    if(NOT generator_check)
      tix_fatal([=[
unsupported generator for toolchain '${TIX_NAME}'
 -- expected   '${args_GENERATOR}'
 -- actual     '${CMAKE_GENERATOR}'
]=])
    endif()
  endif()

  set(TIX_GENERATOR_VS OFF)
  unset(TIX_GENERATOR_VS_MAJOR)
  unset(TIX_GENERATOR_VS_YEAR)
  unset(TIX_GENERATOR_VS_ARCH)
  if(CMAKE_GENERATOR MATCHES "^Visual Studio ([0-9]+) ([0-9]+)( ([A-Za-z0-9]+))?$")
    set(TIX_GENERATOR_VS ON)
    set(TIX_GENERATOR_VS_MAJOR "${CMAKE_MATCH_1}")
    set(TIX_GENERATOR_VS_YEAR "${CMAKE_MATCH_2}")
    if(CMAKE_MATCH_4)
      set(TIX_GENERATOR_VS_ARCH "${CMAKE_MATCH_4}")
    endif()
  endif()
endmacro()
