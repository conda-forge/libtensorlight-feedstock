if [[ "${target_platform}" == "osx-arm64" ]]; then
    ./build_libtensor.py -v -d build --install ${PREFIX} --type Release --features netlib libxm
else
    ./build_libtensor.py -v -d build --install ${PREFIX} --type Release --features mkl libxm
fi

nm $PREFIX/lib/libtensorlight$SHLIB_EXT | grep product_table_container | grep get_instance

cd build
ctest
