set PKG_CONFIG_PATH=%LIBRARY_PREFIX%\lib\pkgconfig; 

mkdir build
cd build

cmake ../^
    -GNinja^
    -DCMAKE_BUILD_TYPE=Release^
    -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%"^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"^
    -DINCLUDE_PREFIX:PATH=include^
    -DCMAKE_PREFIX:PATH=lib/cmake/casadi^
    -DLIB_PREFIX:PATH=lib^
    -DBIN_PREFIX:PATH=bin^
    -DWITH_SELFCONTAINED=OFF^
    -DWITH_PYTHON=ON^
    -DWITH_PYTHON3=ON^
    -DWITH_LAPACK=ON^
    -DWITH_IPOPT=ON^
    -DWITH_THREAD=ON^
    -DWITH_JSON=ON^
    -DWITH_OSQP=ON^
    -DPYTHON_PREFIX=%SP_DIR%^
    -DWITH_COPYSIGN_UNDEF=ON

ninja install
