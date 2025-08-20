function runQuillCmake()
	
	--Run the CMake command to generate quill solution files
	
	local quill_dir = "vendor/quill"
	local build_dir = "vendor/quill"
	local ide = "Visual Studio 17 2022"

--QUILL_NO_EXCEPTIONS "Enable this option to build without exception handling support."
--QUILL_NO_THREAD_NAME_SUPPORT "Enable this option to disable features that require thread name retrieval, ensuring compatibility with older Windows versions (e.g., Windows Server 2012/2016) and Android."
--QUILL_X86ARCH "Enable x86-specific optimizations for cache coherence using _mm_prefetch, _mm_clflush, and _mm_clflushopt instructions. Ensure the target architecture must also be specified with -march=\"...\" when enabling this option."
--QUILL_DISABLE_NON_PREFIXED_MACROS "Enable this option to disable non-prefixed `LOG_*` macros, keeping only the `QUILL_LOG_*` macros to avoid conflicts with other logging libraries."
--QUILL_DISABLE_FUNCTION_NAME "Disable the use of __FUNCTION__ in `LOG_*` macros when the function name is not needed."
--QUILL_DETAILED_FUNCTION_NAME "Use detailed function name (__PRETTY_FUNCTION__ or __FUNCSIG__) instead of __FUNCTION__ in LOG_* macros"
--QUILL_DISABLE_FILE_INFO "Disable the use of __FILE__ and __LINE__ in `LOG_*` macros when the file name and the line number are not needed."
--QUILL_BUILD_EXAMPLES "Enable this option to build and install the examples. Set this to ON to include example projects in the build process and have them installed after configuring with CMake."
--QUILL_BUILD_TESTS "Enable this option to build the test suite."
--QUILL_ENABLE_EXTENSIVE_TESTS "Enable extensive tests that may require more resources and are not suitable for hosted CI runners."
--QUILL_BUILD_BENCHMARKS "Enable this option to build the benchmarks."
--QUILL_SANITIZE_ADDRESS "Enable AddressSanitizer (ASan) for memory error detection in tests."
--QUILL_SANITIZE_THREAD "Enable ThreadSanitizer (TSan) for detecting thread-related issues in tests. Note: Using this option with non-Clang compilers may produce false positives."
--QUILL_CODE_COVERAGE "Enable code coverage analysis during the build."
--QUILL_USE_VALGRIND "Use Valgrind as the default memory checking tool in CTest. Valgrind must be installed."
--QUILL_ENABLE_INSTALL "Enable the CMake install target when Quill is not the master project."
--QUILL_DOCS_GEN "Generate documentation during the build process."

	local options = {
			"QUILL_NO_EXCEPTIONS=ON",
			"QUILL_NO_THREAD_NAME_SUPPORT=OFF",
			"QUILL_X86ARCH=ON",
			"QUILL_DISABLE_NON_PREFIXED_MACROS=OFF",
			"QUILL_DETAILED_FUNCTION_NAME=ON",
			"QUILL_DISABLE_FILE_INFO=OFF",
			"QUILL_BUILD_EXAMPLES=ON",
			"QUILL_BUILD_TESTS=ON",
			"QUILL_ENABLE_EXTENSIVE_TESTS=OFF",
			"QUILL_BUILD_BENCHMARKS=OFF",
			"QUILL_SANITIZE_ADDRESS=OFF",
			"QUILL_SANITIZE_THREAD=OFF",
			"QUILL_CODE_COVERAGE=OFF",
			"QUILL_USE_VALGRIND=OFF",
			"QUILL_ENABLE_INSTALL=OFF",
			"QUILL_DOCS_GEN=OFF"
		}

	
	

		-- Build the cmake command string
		local cmake_cmd = string.format(
    	'cmake -S %s -B %s -G "%s"',
   	 	quill_dir,
   		build_dir,
    	ide)
		

		-- Append options
		for _, opt in ipairs(options) do
   		 	cmake_cmd = cmake_cmd .. " -D" .. opt
		end

		print("Running: " .. cmake_cmd)
		local result = os.execute(cmake_cmd)


		

		local onDefines = {}

	for _, def in ipairs(options) do
   		-- Check if the string ends with "=ON"
    	if def:sub(-3) == "=ON" then
        	-- Extract the part before the "="
        	local var_name = def:match("^(.-)=")
        	if var_name then
            	table.insert(onDefines, var_name)
        	end
    	end
	end

	return onDefines

end
