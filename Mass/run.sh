#bin/bash

export CXX=g++
export CXX_FLAGS="-march=native -Ofast"
export BATCH_SIZE=4
export PRECISION=8
export NUM_PROCS=1


for DEGREE in 1 2 3 4 5 6 7 8
do
    rm -rf build
    cmake -B build/ -DCMAKE_CXX_FLAGS="${CXX_FLAGS}" -DPRECISION=${PRECISION} -DBATCH_SIZE=${BATCH_SIZE} -DDEGREE=${DEGREE} .
    cmake --build build -j 10
    mpirun -n ${NUM_PROCS} ./build/benchmark
    # echo ", '${CXX_FLAGS}'" >> out.txt

done