use "pony_bench"
use "itertools"
use "collections"
use binarysearch = "../binarysearch"
use "random"

actor Main is BenchmarkList
  new create(env: Env) =>
    PonyBench(env, this)

  fun tag benchmarks(bench: PonyBench) =>
    bench(_StandardNumericArray.create(128))
    bench(_StandardNumericArray.create(1024))
    bench(_StandardNumericArray.create(65536))
    //bench(_BitwiseNumericArray.create(128))
    //bench(_BitwiseNumericArray.create(1024))
    //bench(_BitwiseNumericArray.create(65536))
    //bench(_MonoboundNumericArray.create(128))
    //bench(_MonoboundNumericArray.create(1024))
    //bench(_MonoboundNumericArray.create(65536))


class \nodoc\ iso _StandardNumericArray is MicroBenchmark

  let _name: String
  let _length: USize
  let _haystack: Array[U64] ref
  let _rng: Random
  var _needle: U64

  new iso create(length: USize) =>
    _haystack = Iter[U64](Range[U64](0, length.u64())).collect(Array[U64](length))
    _name = "standard/lower_bound/numeric/" + length.string()
    _length = length
    _rng = Rand.from_u64(length.u64())
    _needle = 0

  fun name(): String => this._name

  fun ref before_iteration() =>
    this._needle = _rng.int[U64](this._length.u64())

  fun apply() =>
    DoNotOptimise[USize](this.run())
    DoNotOptimise.observe()
 
  fun run(): USize =>
    binarysearch.Standard.lower_bound[U64](this._needle, this._haystack)

