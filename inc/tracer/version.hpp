// SPDX-License-Identifier: MIT
// SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>
#pragma once
#ifndef TRACER_VERSION_INFO_HPP_INCLUDED
#define TRACER_VERSION_INFO_HPP_INCLUDED

namespace tracer
{

struct version_info
{
  static int major();
  static int minor();
  static int patch();

  static const char *full();
  static const char *core();
  static const char *pre_release();
  static const char *build();

  static const char *git_branch();
  static const char *git_hash();
  static const char *git_hash_short();

private:
  version_info() = delete;
};

} // namespace tracer

#endif // TRACER_VERSION_INFO_HPP_INCLUDED
