# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>
if(EXISTS "${OUTPUT_FILE}" AND ${SKIP})
  message(STATUS "skipping version update (TRACER_SKIP_VERSION_UPDATE=ON)")
  return()
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utility.cmake")
parse_version(PROJECT_VERSION FILEPATH "./VERSION")

include("${CMAKE_CURRENT_LIST_DIR}/git.cmake")
git_exec(GIT_BRANCH name-rev --name-only HEAD)
git_log(GIT_COMMIT_HASH "%H")
git_log(GIT_COMMIT_HASH_SHORT "%h")
git_log(GIT_COMMITER_NAME "%cN")
git_log(GIT_COMMITER_EMAIL "%cE")
git_log(GIT_COMMITER_DATE "%cD")
git_log(GIT_COMMITER_TIMESTAMP "%ct")
git_log(GIT_TREE_HASH "%T")
git_log(GIT_TREE_HASH_SHORT "%t")
git_log(GIT_AUTHOR_NAME "%aN")
git_log(GIT_AUTHOR_EMAIL "%aE")
git_log(GIT_AUTHOR_DATE "%aD")
git_log(GIT_AUTHOR_TIMESTAMP "%at")

if(NOT EXISTS "${OUTPUT_FILE}")
  get_filename_component(dir "${INPUT_FILE}" DIRECTORY)
  file(MAKE_DIRECTORY "${dir}")
  configure_file("${INPUT_FILE}" "${OUTPUT_FILE}" @ONLY)
else()
  set(temp "${OUTPUT_FILE}.tmp")
  configure_file("${INPUT_FILE}" "${temp}" @ONLY)
  file(SHA1 "${OUTPUT_FILE}" chash)
  file(SHA1 "${temp}" uhash)

  if(chash STREQUAL uhash)
    file(REMOVE "${temp}")
  else()
    file(RENAME "${temp}" "${OUTPUT_FILE}")
  endif()
endif()
