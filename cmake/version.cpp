// SPDX-License-Identifier: MIT
// SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>
#define LOOP_OBJ

#include "loop/version.hpp"

// clang-format off
#define LOOP_VERSION_MAJOR @PROJECT_VERSION_MAJOR@
#define LOOP_VERSION_MINOR @PROJECT_VERSION_MINOR@
#define LOOP_VERSION_PATCH @PROJECT_VERSION_PATCH@
#define LOOP_VERSION_FULL "@PROJECT_VERSION_FULL@"
#define LOOP_VERSION_CORE "@PROJECT_VERSION@"
#define LOOP_VERSION_PRE_RELEASE "@PROJECT_VERSION_PRE_RELEASE@"
#define LOOP_VERSION_BUILD "@PROJECT_VERSION_BUILD@"
#define LOOP_VERSION_GIT_BRANCH "@GIT_BRANCH@"
#define LOOP_VERSION_GIT_HASH "@GIT_COMMIT_HASH@"
#define LOOP_VERSION_GIT_HASH_SHORT "@GIT_COMMIT_HASH_SHORT@"
// clang-format on

namespace loop
{

int version_info::major()
{
  return LOOP_VERSION_MAJOR;
}

int version_info::minor()
{
  return LOOP_VERSION_MINOR;
}

int version_info::patch()
{
  return LOOP_VERSION_PATCH;
}

const char *version_info::full()
{
  return LOOP_VERSION_FULL;
}

const char *version_info::core()
{
  return LOOP_VERSION_CORE;
}

const char *version_info::pre_release()
{
  return LOOP_VERSION_PRE_RELEASE;
}

const char *version_info::build()
{
  return LOOP_VERSION_BUILD;
}

const char *version_info::git_branch()
{
  return LOOP_VERSION_GIT_BRANCH;
}

const char *version_info::git_hash()
{
  return LOOP_VERSION_GIT_HASH;
}

const char *version_info::git_hash_short()
{
  return LOOP_VERSION_GIT_HASH_SHORT;
}

} // namespace loop
