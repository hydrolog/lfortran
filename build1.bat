del CMakeCache.txt

cmake -S %cd% -B %cd% -G Ninja ^
 -DCMAKE_BUILD_TYPE=Release ^
 -DWITH_LLVM=yes ^
 -DLFORTRAN_BUILD_ALL=no ^
 -DWITH_STACKTRACE=no ^
 -DWITH_RUNTIME_STACKTRACE=no ^
 -DCMAKE_PREFIX_PATH="%CONDA_PREFIX%" ^
 -DCMAKE_INSTALL_PREFIX="%CONDA_PREFIX%\Library" ^
 -DCMAKE_EXPORT_COMPILE_COMMANDS=yes
cmake --build %cd% --target install



