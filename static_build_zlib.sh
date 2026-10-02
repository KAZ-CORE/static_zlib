#!/bin/bash
source conf.sh

case "$arch_build_target" in
    aarch64|aarch64_be|alpha|amdgcn|arc|arceb|arm|armeb|avr|\
    bpfeb|bpfel|csky|ez80|hexagon|hppa|hppa64|kalimba|kvx|lanai|\
    loongarch32|loongarch64|m68k|m88k|microblaze|microblazeel|\
    mips|mipsel|mips64|mips64el|msp430|nvptx|nvptx64|or1k|\
    powerpc|powerpcle|powerpc64|powerpc64le|propeller|riscv32|\
    riscv32be|riscv64|riscv64be|s390x|sh|sheb|sparc|sparc64|\
    spork8|spirv32|spirv64|thumb|thumbeb|ve|wasm32|wasm64|\
    x86_16|x86|x86_64|xcore|xtensa|xtensaeb|native)
        ;;
    *)
        echo "Invalid architecture: $arch_build_target"
        exit 1
        ;;
esac


rm -rf ${traget_output}
mkdir -p ${traget_output}

git clone ${addr_repository}


cmake \
    -S "${path_zlib}" \
    -B "build/${os_build_target}/${arch_build_target}" \
    -DCMAKE_C_COMPILER="${zigfile};cc;-target;${build_target}" \
    -DCMAKE_ASM_COMPILER="${zigfile};cc;-target;${build_target}" \
    -DBUILD_SHARED_LIBS=OFF \
    -DCMAKE_TRY_COMPILE_TARGET_TYPE=STATIC_LIBRARY


cmake --build ${traget_output} --target zlibstatic -j$(nproc)
