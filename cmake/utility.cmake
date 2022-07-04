# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>
include(CMakeParseArguments)

function(parse_version prefix)
  cmake_parse_arguments(args "" "FILEPATH;VERSION" "" ${ARGN})

  if(args_FILEPATH AND args_VERSION)
    message(FATAL_ERROR "${CMAKE_CURRENT_FUNCTION}: ambigious call use either FILEPATH or VERSION parameter")
  endif()

  set(version "${args_VERSION}")
  if(args_FILEPATH)
    if(NOT EXISTS "${args_FILEPATH}")
      message(FATAL_ERROR "version file '${args_FILEPATH}' not found.")
    endif()

    set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS "${args_FILEPATH}")
    file(STRINGS "${args_FILEPATH}" version LIMIT_COUNT 1)
  endif()

  if(NOT "${version}" MATCHES "^([1-9]+[0-9]*|0).([1-9]+[0-9]*|0).([1-9]+[0-9]*|0)(-([^\\+]+))?(\\+(.+))?$")
    message(FATAL_ERROR "version '${version}' does not match MAJOR.MINOR.PATH(-PRE_PRELEASE)?(+BUILD)?")
  endif()

  set("${prefix}_FULL" "${version}" PARENT_SCOPE)
  set("${prefix}_MAJOR" "${CMAKE_MATCH_1}" PARENT_SCOPE)
  set("${prefix}_MINOR" "${CMAKE_MATCH_2}" PARENT_SCOPE)
  set("${prefix}_PATCH" "${CMAKE_MATCH_3}" PARENT_SCOPE)
  set("${prefix}_PRE_RELEASE" "${CMAKE_MATCH_5}" PARENT_SCOPE)
  set("${prefix}_BUILD" "${CMAKE_MATCH_7}" PARENT_SCOPE)
  set("${prefix}" "${CMAKE_MATCH_1}.${CMAKE_MATCH_2}.${CMAKE_MATCH_3}" PARENT_SCOPE)
endfunction()
