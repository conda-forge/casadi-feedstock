mkdir build
pushd build

if [[ "${target_platform}" == osx-* ]]; then
    # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

# With PyPy we must regenerate the swig Python binding due to a weird issue.
if [[ -f "${PREFIX}/bin/pypy" ]]
then
  SWIG_IMPORT_EXPORT="-DSWIG_IMPORT=OFF -DSWIG_EXPORT=ON"
  PYTHON_INCLUDE_DIR="${PREFIX}/include/pypy${CONDA_PY:0:1}.${CONDA_PY:1}"
  PYTHON_LIBRARY="${PREFIX}/lib/libpypy${CONDA_PY:0:1}.${CONDA_PY:1}-c${SHLIB_EXT}"
else
  SWIG_IMPORT_EXPORT="-DSWIG_IMPORT=ON -DSWIG_EXPORT=OFF"
  PYTHON_INCLUDE_DIR="${PREFIX}/include/python${CONDA_PY:0:1}.${CONDA_PY:1}"
  PYTHON_LIBRARY="${PREFIX}/lib/libpython${CONDA_PY:0:1}.${CONDA_PY:1}${SHLIB_EXT}"
fi

echo "SWIG_IMPORT_EXPORT=$SWIG_IMPORT_EXPORT"
echo "PYTHON_INCLUDE_DIR=$PYTHON_INCLUDE_DIR"
echo "PYTHON_LIBRARY=$PYTHON_LIBRARY"

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
  -DWITH_FATROP=ON \
  -DWITH_BUILD_FATROP=OFF \
  -DPYTHON_PREFIX=${SP_DIR} \
  -DPython_EXECUTABLE=${PYTHON} \
  -DPython_INCLUDE_DIR:PATH=${PYTHON_INCLUDE_DIR} \
  -DPython_LIBRARY:PATH=${PYTHON_LIBRARY} \
  -DCASADI_PYTHON_PIP_METADATA_INSTALL=ON \
  -DCASADI_PYTHON_PIP_METADATA_INSTALLER:STRING="conda" \
  ${SWIG_IMPORT_EXPORT}

ninja install

# Run tests in build step as the test files can't be moved easily
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" ]]; then
  # Run qp-related tests 
  python $SRC_DIR/test/python/conic.py
fi
