// SPDX-License-Identifier: MIT
// SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>
// SPDX-FileAttributionText: https://gcc.gnu.org/wiki/Visibility
#pragma once
#ifndef LOOP_API_HPP_INCLUDED
#define LOOP_API_HPP_INCLUDED

#include "loop/config.hpp"

#if defined(_WIN32) || defined(__CYGWIN__)
#define LOOP_API_IMPORT __declspec(dllimport)
#define LOOP_API_EXPORT __declspec(dllexport)
#define LOOP_API_HIDDEN
#else
#define LOOP_API_IMPORT __attribute__((visibility("default")))
#define LOOP_API_EXPORT __attribute__((visibility("default")))
#define LOOP_API_HIDDEN __attribute__((visibility("hidden")))
#endif

#if defined(LOOP_BUILD_SHARED)
#if defined(LOOP_OBJ)
#define LOOP_API LOOP_API_EXPORT
#else
#define LOOP_API LOOP_API_IMPORT
#endif
#define LOOP_HIDDEN LOOP_API_HIDDEN
#else
#define LOOP_API
#define LOOP_HIDDEN
#endif

#endif // LOOP_API_HPP_INCLUDED
