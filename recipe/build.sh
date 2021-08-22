mkdir build
pushd build

cmake ${CMAKE_ARGS} $SRC_DIR \
  -GNinja \
  -DWITH_PYTHON=ON \
  -DWITH_PYTHON3=ON \
  -DWITH_LAPACK=ON \
  -DWITH_IPOPT=ON \
  -DWITH_JSON=ON \
  -DWITH_THREAD=ON \
  -DWITH_OSQP=ON \
  -DUSE_SYSTEM_WISE_OSQP=ON \
  -DPYTHON_PREFIX=${SP_DIR} \
  
ninja install

# Change a line of code that won't work with new version of python
sed -i'.original' 's/_object/object/' $SP_DIR/casadi/casadi.py

