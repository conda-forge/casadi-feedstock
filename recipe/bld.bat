mkdir build
cd build

where pkg-config 
pkg-config --list-all
pkg-config --variable pc_path pkg-config
pkg-config --exists --print-errors --debug ipopt
if errorlevel 1 exit 1

pkg-config --validate --print-errors --debug ipopt
if errorlevel 1 exit 1

cmake ../^
    -GNinja^
    -DCMAKE_BUILD_TYPE=Release^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"^
    -DINCLUDE_PREFIX="%LIBRARY_INC%"^
    -DCMAKE_PREFIX="%LIBRARY_PREFIX%"^
    -DLIB_PREFIX="%LIBRARY_LIB%"^
    -DBIN_PREFIX="%LIBRARY_BIN%"^
    -DWITH_SELFCONTAINED=OFF^
    -DWITH_SELFCONTAINED=OFF^
    -DWITH_PYTHON=ON^
    -DWITH_PYTHON3=ON^
    -DWITH_LAPACK=ON^
    -DWITH_IPOPT=ON^
    -DWITH_THREAD=OFF^
    -DWITH_JSON=ON^
    -DPYTHON_PREFIX=%PREFIX% 

ninja install
