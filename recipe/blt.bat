
mkdir build
cd build

cmake ../^
    -G"%CMAKE_GENERATOR%"^
    -DCMAKE_BUILD_TYPE=Release^
    -DCMAKE_INSTALL_PREFIX="%PREFIX%"^
    -DWITH_SELFCONTAINED=OFF^
    -DWITH_SELFCONTAINED=OFF^
    -DWITH_PYTHON=ON^
    -DWITH_PYTHON3=ON^
    -DWITH_LAPACK=ON^
    -DWITH_IPOPT=ON^
    -DWITH_JSON=ON^
    -DPYTHON_PREFIX=%PREFIX% 


cmake --build ./^
    --config Release^
    --target install
