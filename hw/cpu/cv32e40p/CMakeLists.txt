set(TARTGET_NAME cv32e40p)

add_library(${TARTGET_NAME} OBJECT)

target_sources(${TARTGET_NAME} 
	PRIVATE
		crt0.S
		vectors.S
		handlers.S
		syscalls.c
)

target_link_options(${TARTGET_NAME}
	INTERFACE
		-T ${CMAKE_CURRENT_SOURCE_DIR}/link.ld
)
