# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>

find_package(Git QUIET)
if(Git_FOUND)
  macro(git_exec out_var)
    execute_process(COMMAND "${GIT_EXECUTABLE}" ${ARGN} OUTPUT_VARIABLE "${out_var}")
    string(REPLACE "\n" "" "${out_var}" "${${out_var}}")
    string(REPLACE "\r" "" "${out_var}" "${${out_var}}")
  endmacro()
else()
  macro(git_exec out_var)
    set("${out_var}" "n/a")
  endmacro()
endif()

macro(git_log out_var format)
  git_exec("${out_var}" log -1 "--pretty=format:${format}")
endmacro()
