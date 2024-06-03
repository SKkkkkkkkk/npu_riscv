# CC=riscv32-unknown-elf-gcc cmake -S ../.. -B build -DPROJECT_NAME=hello -DPROJECT_PATH=. -DCMAKE_BUILD_TYPE=Release
CC=riscv32-unknown-elf-gcc cmake -S ../.. -B build -DPROJECT_NAME=hello -DEXTRA_SRCS="src/main.c;src/a.c"
cmake --build build