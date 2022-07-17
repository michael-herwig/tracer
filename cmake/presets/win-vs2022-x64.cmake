# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/shared")

include(tix_init)

tix_init(
  STYLE         "MSVC"
  GENERATOR     "Visual Studio 17 2022"
)

include(tix_arch_x64)
