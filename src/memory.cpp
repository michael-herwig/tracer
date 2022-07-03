// SPDX-License-Identifier: MIT
// SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>
#define LOOP_OBJ
#include "loop/memory.hpp"

#include <cassert>

#if defined(LOOP_OS_WINDOWS)
#include <Windows.h>
#endif

namespace loop
{

void memzero(byte *data, std::size_t datalen)
{
  assert(nullptr != data || 0 == datalen);

#if defined(LOOP_OS_WINDOWS)
  SecureZeroMemory(memadr, memlen);
#else
  size_t i;
  volatile byte *vmemadr = reinterpret_cast<volatile byte *>(data);
  for (i = 0; i < datalen; ++i)
  {
    vmemadr[i] = static_cast<byte>(0);
  }
#endif
}

} // namespace loop
