// SPDX-License-Identifier: MIT
// SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>
#pragma once
#ifndef LOOP_MEMORY_HPP_INCLUDED
#define LOOP_MEMORY_HPP_INCLUDED

#include <cstddef>

namespace loop
{

#if defined(__cpp_lib_byte) && __cpp_lib_byte >= 201603L
using byte = std::byte;
#else
using byte = unsigned char;
#endif

void memzero(byte *data, std::size_t datalen);

} // namespace loop

#endif // LOOP_MEMORY_HPP_INCLUDED
