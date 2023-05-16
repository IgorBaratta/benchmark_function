#bin/bash

############################
# CLANG
############################
export CXX=/rds/user/ia397/hpc-work/spack/opt/spack/linux-rocky8-icelake/gcc-11.2.0/llvm-16.0.0-7o7njhjb7ggirmrmnddky3ymb2vopwn3/bin/clang++
export CC=/rds/user/ia397/hpc-work/spack/opt/spack/linux-rocky8-icelake/gcc-11.2.0/llvm-16.0.0-7o7njhjb7ggirmrmnddky3ymb2vopwn3/bin/clang
export NUM_PROCS=76

export PRECISION=8
export BATCH_SIZE=1

run512 () {
    export CXX_FLAGS="-Ofast -march=native -mprefer-vector-width=512"
    for DEGREE in {1..15}
        do
            rm -rf build
            cmake -B build/ -DCMAKE_CXX_FLAGS="${CXX_FLAGS}" -DPRECISION=$1 -DBATCH_SIZE=$2 -DDEGREE=${DEGREE} -DOPTIMIZE_SUM_FACTORIZATION=$3 .
            cmake --build build -j 10
        for i in {1..3}
        do
            mpirun -n ${NUM_PROCS} ./build/benchmark >> $4
            echo ", '${CXX_FLAGS}', ${NUM_PROCS}" >> $4
        done
    done
}

run256 () {
    export CXX_FLAGS="-Ofast -march=native -mprefer-vector-width=256"
    for DEGREE in {1..15}
        do
            rm -rf build
            cmake -B build/ -DCMAKE_CXX_FLAGS="${CXX_FLAGS}" -DPRECISION=$1 -DBATCH_SIZE=$2 -DDEGREE=${DEGREE} -DOPTIMIZE_SUM_FACTORIZATION=$3 .
            cmake --build build -j 10
        for i in {1..3}
        do
            mpirun -n ${NUM_PROCS} ./build/benchmark >> $4
            echo ", '${CXX_FLAGS}', ${NUM_PROCS}" >> $4
        done
    done
}

# Order : Precision, Batch Size, Optimize Sum Factorization
run512 8 1 0 "mass-hex-icelake-llvm.txt"
run512 8 8 0 "mass-hex-icelake-llvm.txt"
run512 8 1 1 "mass-hex-icelake-llvm.txt"
run256 8 1 1 "mass-hex-icelake-llvm.txt"

# Single Precision
run512 4 1 0 "mass-hex-icelake-llvm.txt"
run512 4 16 0 "mass-hex-icelake-llvm.txt"
run512 4 1 1 "mass-hex-icelake-llvm.txt"
run256 4 1 1 "mass-hex-icelake-llvm.txt"
