// SPDX-License-Identifier: MIT
// SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>
#include "tracer/memory.hpp"

#include <gmock/gmock.h>

using namespace ::testing;
using namespace ::tracer;

TEST(memzero, nomem)
{
  memzero(nullptr, 0);
}

TEST(memzero, nolen)
{
  byte buffer[2] = {0xFF_byte, 0xFF_byte};
  memzero(buffer, 0);

  EXPECT_THAT(buffer, Each(Eq(0xFF_byte)));
}

TEST(memzero, full)
{
  byte buffer[2] = {0xFF_byte, 0xFF_byte};
  memzero(buffer, sizeof(buffer));

  EXPECT_THAT(buffer, Each(Eq(0x00_byte)));
}
