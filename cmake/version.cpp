// SPDX-License-Identifier: MIT
// SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>
#define TRACER_OBJ

#include "tracer/version.hpp"

// clang-format off
#define TRACER_VERSION_MAJOR @PROJECT_VERSION_MAJOR@
#define TRACER_VERSION_MINOR @PROJECT_VERSION_MINOR@
#define TRACER_VERSION_PATCH @PROJECT_VERSION_PATCH@
#define TRACER_VERSION_FULL "@PROJECT_VERSION_FULL@"
#define TRACER_VERSION_CORE "@PROJECT_VERSION@"
#define TRACER_VERSION_PRE_RELEASE "@PROJECT_VERSION_PRE_RELEASE@"
#define TRACER_VERSION_BUILD "@PROJECT_VERSION_BUILD@"
#define TRACER_VERSION_GIT_BRANCH "@GIT_BRANCH@"
#define TRACER_VERSION_GIT_HASH "@GIT_COMMIT_HASH@"
#define TRACER_VERSION_GIT_HASH_SHORT "@GIT_COMMIT_HASH_SHORT@"
// clang-format on

namespace tracer
{

int version_info::major()
{
  return TRACER_VERSION_MAJOR;
}

int version_info::minor()
{
  return TRACER_VERSION_MINOR;
}

int version_info::patch()
{
  return TRACER_VERSION_PATCH;
}

const char *version_info::full()
{
  return TRACER_VERSION_FULL;
}

const char *version_info::core()
{
  return TRACER_VERSION_CORE;
}

const char *version_info::pre_release()
{
  return TRACER_VERSION_PRE_RELEASE;
}

const char *version_info::build()
{
  return TRACER_VERSION_BUILD;
}

const char *version_info::git_branch()
{
  return TRACER_VERSION_GIT_BRANCH;
}

const char *version_info::git_hash()
{
  return TRACER_VERSION_GIT_HASH;
}

const char *version_info::git_hash_short()
{
  return TRACER_VERSION_GIT_HASH_SHORT;
}

} // namespace tracer
