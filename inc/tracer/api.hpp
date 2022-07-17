// SPDX-License-Identifier: MIT
// SPDX-FileCopyrightText: (c) 2022, Michael Herwig <contact@michael-herwig.de>
// SPDX-FileAttributionText: https://gcc.gnu.org/wiki/Visibility
#pragma once
#ifndef TRACER_API_HPP_INCLUDED
#define TRACER_API_HPP_INCLUDED

#include "tracer/config.hpp"

#if defined(_WIN32) || defined(__CYGWIN__)
#define TRACER_API_IMPORT __declspec(dllimport)
#define TRACER_API_EXPORT __declspec(dllexport)
#define TRACER_API_HIDDEN
#else
#define TRACER_API_IMPORT __attribute__((visibility("default")))
#define TRACER_API_EXPORT __attribute__((visibility("default")))
#define TRACER_API_HIDDEN __attribute__((visibility("hidden")))
#endif

#if defined(TRACER_BUILD_SHARED)
#if defined(TRACER_OBJ)
#define TRACER_API TRACER_API_EXPORT
#else
#define TRACER_API TRACER_API_IMPORT
#endif
#define TRACER_HIDDEN TRACER_API_HIDDEN
#else
#define TRACER_API
#define TRACER_HIDDEN
#endif

#endif // TRACER_API_HPP_INCLUDED
