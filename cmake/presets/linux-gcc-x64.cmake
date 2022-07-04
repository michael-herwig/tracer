# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/shared")

include(tix_init)
include(tix_find_compiler)

tix_init(STYLE "GNU")
tix_find_compiler(CMAKE_C_COMPILER gcc)
tix_find_compiler(CMAKE_CXX_COMPILER g++)

include(tix_arch_x64)
