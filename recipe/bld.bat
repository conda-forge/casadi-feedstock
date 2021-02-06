set PKG_CONFIG_PATH=%LIBRARY_PREFIX%\lib\pkgconfig; 

mkdir build
cd build

cmake ../^
    -GNinja^
    -DCMAKE_BUILD_TYPE=Release^
    -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%"^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"^
    -DINCLUDE_PREFIX=include^
    -DCMAKE_PREFIX=lib/cmake/casadi^
    -DLIB_PREFIX=lib^
    -DBIN_PREFIX=bin^
    -DWITH_SELFCONTAINED=OFF^
    -DWITH_PYTHON=ON^
    -DWITH_PYTHON3=ON^
    -DWITH_LAPACK=ON^
    -DWITH_IPOPT=ON^
    -DWITH_THREAD=OFF^
    -DWITH_JSON=ON^
    -DPYTHON_PREFIX=%SP_DIR% 

ninja install
