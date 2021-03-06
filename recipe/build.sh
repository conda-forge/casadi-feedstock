mkdir build
pushd build

cmake $SRC_DIR \
  -GNinja \
  -DWITH_PYTHON=ON \
  -DWITH_PYTHON3=ON \
  -DWITH_LAPACK=ON \
  -DWITH_IPOPT=ON \
  -DWITH_JSON=ON \
  -DWITH_THREAD=ON \
  -DCMAKE_INSTALL_PREFIX=${PREFIX}\
  -DPYTHON_PREFIX=${SP_DIR} \
  
ninja -v install

# Change a line of code that won't work with new version of python
sed -i'.original' 's/_object/object/' $SP_DIR/casadi/casadi.py

