# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>

include(FindPackageHandleStandardArgs)

set(_clang_tools_required)
foreach(component tidy format)
  set(comp_name "clang-${component}")
  set(comp_exec "clang-${component}_EXECUTABLE")
  set(comp_found "clang-${component}_FOUND")

  find_program("${comp_exec}" NAMES "${comp_name}" HINTS "${llvm_ROOT}" ENV llvm_ROOT
    DOC "path to ${comp_name} executable")

  set("${comp_found}" "NOTFOUND")
  if(${comp_exec})
    set("${comp_found}" YES)
  endif()

  if(clang-tools_FIND_REQUIRED_${component})
    list(APPEND _clang_tools_required "${comp_exec}")
  endif()

  mark_as_advanced(${comp_exec} ${comp_found})
endforeach()

find_package_handle_standard_args(clang-tools
  REQUIRED_VARS ${_clang_tools_required})

unset(_clang_tools_required)
