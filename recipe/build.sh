# copied from clangdev-feedstock
# disable -fno-plt due to some GCC bug causing linker errors, see
# https://github.com/llvm/llvm-project/issues/51205
if [[ "$target_platform" == "linux-ppc64le" ]]; then
  CFLAGS="$(echo $CFLAGS | sed 's/-fno-plt //g')"
  CXXFLAGS="$(echo $CXXFLAGS | sed 's/-fno-plt //g')"
  LDFLAGS="$(echo $LDFLAGS | sed 's/-fno-plt //g')"
fi

if [[ "${target_platform}" == "osx-arm64" || "${target_platform}" == "linux-aarch64" || "${target_platform}" == "linux-ppc64le" ]]; then
    ./build_libtensor.py -v -d build --install ${PREFIX} --type Release --features netlib libxm
else
    ./build_libtensor.py -v -d build --install ${PREFIX} --type Release --features mkl libxm
fi

nm $PREFIX/lib/libtensorlight$SHLIB_EXT | grep product_table_container | grep get_instance

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
    cd build
    if [ "$(uname)" == "Linux" ]; then
        ctest -E ewmult2
    else
        ctest
    fi
fi
