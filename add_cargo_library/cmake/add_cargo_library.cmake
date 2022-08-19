function(add_cargo_library TARGET)
    if (CMAKE_BUILD_TYPE STREQUAL "Debug")
        set(CARGO_OPTS)
        set(TARGET_DIR debug)
    else ()
        set(CARGO_OPTS --release)
        set(TARGET_DIR release)
    endif ()

    add_custom_command(
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/cxxbridge/${TARGET}/src/lib.rs.cc
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/cxxbridge/${TARGET}/src/lib.rs.h
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_DIR}/lib${TARGET}.a
        COMMAND cargo build ${CARGO_OPTS} --target-dir=${CMAKE_CURRENT_BINARY_DIR}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${TARGET}
    )

    find_package(Threads REQUIRED)

    add_library(${TARGET} STATIC
        ${CMAKE_CURRENT_BINARY_DIR}/cxxbridge/${TARGET}/src/lib.rs.cc
    )
    target_link_libraries(${TARGET} PRIVATE
        Threads::Threads
        ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_DIR}/lib${TARGET}.a
    )
    target_include_directories(${TARGET} PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/cxxbridge/>
        $<INSTALL_INTERFACE:include/>
    )
    install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/cxxbridge/
            DESTINATION include/
    )

    add_test(NAME ${TARGET}_test
        COMMAND cargo test
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${TARGET}
    )
endfunction()
