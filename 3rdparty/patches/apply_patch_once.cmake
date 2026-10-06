# Applies PATCH_FILE with git unless it is already applied, so FetchContent can
# re-run its patch step on a reconfigure without failing.
execute_process(
	COMMAND "${GIT_EXECUTABLE}" apply --ignore-whitespace --check --reverse "${PATCH_FILE}"
	RESULT_VARIABLE already_applied
	OUTPUT_QUIET ERROR_QUIET
)
if(already_applied EQUAL 0)
	message(STATUS "Patch already applied: ${PATCH_FILE}")
	return()
endif()
execute_process(
	COMMAND "${GIT_EXECUTABLE}" apply --ignore-whitespace "${PATCH_FILE}"
	RESULT_VARIABLE result
)
if(NOT result EQUAL 0)
	message(FATAL_ERROR "Failed to apply patch: ${PATCH_FILE}")
endif()
