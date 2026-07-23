cmake_minimum_required(VERSION 3.16)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
if (POLICY CMP0091)
  cmake_policy(SET CMP0091 NEW)
endif (POLICY CMP0091)

# Add cmake modules path (required for Versioning.cmake and git revision description)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules ${CMAKE_MODULE_PATH})

# parse ads_globals.h for the current version information
file(
   READ
   "${CMAKE_CURRENT_SOURCE_DIR}/src/ads_globals.h"
   ads_globals_h_contents)

set(re_hex "[0-9A-Fa-f][0-9A-Fa-f]")

string(
   REGEX MATCH
   "ADS_VERSION[ \t]*0x${re_hex}(${re_hex})(${re_hex})(${re_hex})"
   ads_version_full_match
   ${ads_globals_h_contents})

if(NOT CMAKE_MATCH_COUNT EQUAL 3)
   message(FATAL_ERROR "Unable to parse ADS_VERSION from ads_globals.h")
else()
   math(EXPR VERSION_MAJOR "0x${CMAKE_MATCH_1}" OUTPUT_FORMAT DECIMAL)
   math(EXPR VERSION_MINOR "0x${CMAKE_MATCH_2}" OUTPUT_FORMAT DECIMAL)
   math(EXPR VERSION_PATCH "0x${CMAKE_MATCH_3}" OUTPUT_FORMAT DECIMAL)

   set(VERSION_SHORT ${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH})
   set(VERSION_SONAME ${VERSION_MAJOR})

   message(STATUS "ADS: Building version ${VERSION_SHORT}")
endif()

project(QtADS LANGUAGES CXX VERSION ${VERSION_SHORT})

option(BUILD_STATIC "Build the static library" OFF)
option(BUILD_EXAMPLES "Build the examples" ON)

# Platform directory: auto-detected based on pointer size, or manually set
if(NOT ADS_PLATFORM_DIR)
    if("${CMAKE_SIZEOF_VOID_P}" STREQUAL "4")
        set(ads_PlatformDir "x86")
    else()
        set(ads_PlatformDir "x64")
    endif()
else()
    set(ads_PlatformDir "${ADS_PLATFORM_DIR}")
endif()

add_subdirectory(src)

if(BUILD_EXAMPLES)
    add_subdirectory(examples)
    add_subdirectory(demo)
endif()

