// SPDX-License-Identifier: MIT
// SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>
#pragma once
#ifndef LOOP_MEMORY_HPP_INCLUDED
#define LOOP_MEMORY_HPP_INCLUDED

#include <cstddef>

#include "loop/api.hpp"

namespace loop
{

#if defined(__cpp_lib_byte) && __cpp_lib_byte >= 201603L
using byte = std::byte;
#else
using byte = unsigned char;
#endif

inline constexpr byte operator""_byte(unsigned long long num)
{
  return static_cast<byte>(num);
}

LOOP_API void memzero(byte *data, std::size_t datalen);

} // namespace loop

#endif // LOOP_MEMORY_HPP_INCLUDED
