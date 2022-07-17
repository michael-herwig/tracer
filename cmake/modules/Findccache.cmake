# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>

include(FindPackageHandleStandardArgs)

set(ccache_ROOT "NOTFOUND" CACHE PATH "ccache installation path hint")

find_program(ccache_EXECUTABLE NAMES ccache HINTS "${ccache_ROOT}" ENV ccache_ROOT
  DOC "path to ccache executable")
find_package_handle_standard_args(ccache DEFAULT_MSG ccache_EXECUTABLE)
mark_as_advanced(ccache_ROOT ccache_DIR ccache_FOUND ccache_EXECUTABLE)
