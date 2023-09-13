mkdir build
pushd build

if [[ "${target_platform}" == osx-* ]]; then
    # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

cmake ${CMAKE_ARGS} $SRC_DIR \
  -GNinja \
  -DWITH_PYTHON=ON \
  -DWITH_PYTHON3=ON \
  -DWITH_LAPACK=ON \
  -DWITH_IPOPT=ON \
  -DWITH_BUILD_IPOPT=OFF \
  -DWITH_JSON=OFF \
  -DWITH_THREAD=ON \
  -DWITH_OSQP=ON \
  -DWITH_BUILD_OSQP=OFF \
  -DWITH_QPOASES=ON \
  -DWITH_PROXQP=ON \
  -DWITH_BUILD_PROXQP=OFF \
  -DWITH_TINYXML=ON \
  -DWITH_BUILD_TINYXML=OFF \
  -DSWIG_IMPORT=ON \
  -DWITH_KNITRO=OFF \
  -DWITH_MOCKUP_KNITRO=OFF \
  -DWITH_CPLEX=OFF \
  -DWITH_MOCKUP_CPLEX=OFF \
  -DWITH_GUROBI=OFF \
  -DWITH_MOCKUP_GUROBI=OFF \
  -DWITH_HSL=OFF \
  -DWITH_MOCKUP_HSL=OFF \
  -DWITH_WORHP=OFF \
  -DWITH_MOCKUP_WORHP=OFF \
  -DPYTHON_PREFIX=${SP_DIR} \
  -DWITH_DEEPBIND=OFF \
  -DCASADI_PYTHON_PIP_METADATA_INSTALL=ON \
  -DCASADI_PYTHON_PIP_METADATA_INSTALLER:STRING="conda" \
  
ninja install
