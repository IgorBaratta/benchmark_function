# Benchmark FFCx

Depends on:
- ffcx


## How to run:
### Lagrange - Stiffness Matrix
cd lagrange
python3 run_lagrange.py

### Nedelec - Stiffness Matrix (curl, curl)
cd lagrange
python3 run_lagrange.py


## Add more compilers or flags:
Append compiler names and flags to lines 10 and 11 of [run_lagrange](https://github.com/IgorBaratta/benchmark_function/blob/main/run_lagrange.py)


## Plotting data:
python3 graph.py


## Data description
```
table = [method, compiler name, compiler flags, polyonomial degree, number of cells, local assemble time]
```