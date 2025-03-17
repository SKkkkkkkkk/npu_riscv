# CC=riscv32-unknown-elf-gcc cmake -S ../.. -B build -DPROJECT_NAME=hello -DPROJECT_PATH=. -DCMAKE_BUILD_TYPE=Release
CC=riscv32-unknown-elf-gcc \
cmake -S ../.. -B build \
-G Ninja \
-DPROJECT_NAME=hello \
-DPROJECT_PATH="." \
-DCMAKE_BUILD_TYPE=Release
cmake --build build