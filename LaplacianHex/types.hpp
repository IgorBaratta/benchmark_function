#include <cstddef>              // for std::size_t
#include <type_traits>          // for std::conditional_t
#include <experimental/simd>    // for std::experimental

namespace stdex = std::experimental;


template <std::size_t Precision, std::size_t BatchSize>
struct VectorExtensions
{
typedef double doubleB __attribute__((vector_size(BatchSize * sizeof(double))));
    using S = std::conditional_t<Precision == 8, double, float>;
    using T = std::conditional_t<BatchSize == 1, S, doubleB>;
};