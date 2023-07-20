if [[ "${target_platform}" == "osx-arm64" ]]; then
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
