# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>

include(FindPackageHandleStandardArgs)

set(cppcheck_ROOT "NOTFOUND" CACHE PATH "cppcheck installation path hint")

find_program(cppcheck_EXECUTABLE NAMES cppcheck HINTS "${cppcheck_ROOT}" ENV cppcheck_ROOT
  DOC "path to cppcheck executable")
find_package_handle_standard_args(cppcheck DEFAULT_MSG cppcheck_EXECUTABLE)
mark_as_advanced(cppcheck_ROOT cppcheck_DIR cppcheck_FOUND cppcheck_EXECUTABLE)
