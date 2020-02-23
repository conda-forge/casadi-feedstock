mkdir build
pushd build

cmake $CMAKE_FLAG \
  -DWITH_PYTHON=ON \
  -DWITH_PYTHON3=ON \
  -DWITH_LAPACK=ON \
  -DWITH_IPOPT=ON \
  -DWITH_JSON=ON \
  -DCMAKE_INSTALL_PREFIX=${PREFIX}\
  -DPYTHON_PREFIX=${SP_DIR} \
  $SRC_DIR

make VERBOSE=1 -j${CPU_COUNT}
make install

# Change a line of code that won't work with new version of python
sed -i 's/_object/object/' $SP_DIR/casadi/casadi.py

