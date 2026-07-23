# ============================================================
# Versioning.cmake  (Reusable Version + Resource Generator)
# ============================================================

# Freeze the directory where this module lives
# This is critical — it prevents paths from breaking when the
# function is invoked from other CMakeLists.txt files.
set(_VERSIONING_MODULE_DIR "${CMAKE_CURRENT_LIST_DIR}" CACHE INTERNAL "Versioning module directory")

# ------------------------------------------------------------
# Reusable function: Attach Windows version resources to target
# ------------------------------------------------------------
function(add_windows_version_resources target)
    if(NOT WIN32)
        return()
    endif()

    if(NOT TARGET "${target}")
        message(FATAL_ERROR "add_windows_version_resources: target '${target}' not found.")
    endif()

    # Absolute path to the template (never changes)
    get_filename_component(_rc_in
        "${_VERSIONING_MODULE_DIR}/FileVersionInfo.rc.in"
        ABSOLUTE
    )

    if(NOT EXISTS "${_rc_in}")
        message(FATAL_ERROR
            "FileVersionInfo.rc.in missing at: ${_rc_in}"
        )
    endif()

    # Output in the caller's binary dir
    set(_rc_out "${CMAKE_CURRENT_BINARY_DIR}/${target}_version.rc")
    get_filename_component(_rc_out "${_rc_out}" ABSOLUTE)

    # Ensure directory exists
    file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")

    # Configure the template
    configure_file("${_rc_in}" "${_rc_out}" @ONLY)

    # Add to the target
    target_sources(${target} PRIVATE "${_rc_out}")
endfunction()
