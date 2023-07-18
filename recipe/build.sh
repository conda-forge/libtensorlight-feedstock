if [[ "${target_platform}" == "osx-arm64" ]]; then
    ./build_libtensor.py -v -d build --install ${PREFIX} --type Release --features libxm
else
    ./build_libtensor.py -v -d build --install ${PREFIX} --type Release --features mkl libxm
fi
