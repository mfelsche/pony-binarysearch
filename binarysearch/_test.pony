use "pony_test"
use "itertools"

actor \nodoc\ Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(StandardLowerBound)
    test(StandardLowerBoundEmpty)
    test(StandardSearch)

class \nodoc\ iso StandardLowerBoundEmpty is UnitTest
  fun name(): String =>
    "standard/lower_bound/empty"
  fun apply(h: TestHelper) =>
    let array: Array[U32] = []
    assert_lower_bound(h, 3, array where expected = 0)
    assert_lower_bound(h, 0, array where expected = 0)
    assert_lower_bound(h, 10, array where expected = 0)

  fun assert_lower_bound(h: TestHelper, needle: U32, haystack: ReadSeq[U32], expected: USize, loc: SourceLoc val = __loc) =>
    let idx = Standard.lower_bound[U32](needle, haystack)
    h.assert_eq[USize](expected, idx where loc = loc)



class \nodoc\ iso StandardLowerBound is UnitTest
  fun name(): String =>
    "standard/lower_bound"
  fun apply(h: TestHelper) =>
    let array: Array[U32] = [1; 2; 3; 4; 5; 7; 8; 9]
    for (i, elem) in Iter[U32](array.values()).enum() do
      assert_lower_bound(h, elem, array where expected = i)
    end
    assert_lower_bound(h, 0, array where expected = 0)
    assert_lower_bound(h, 6, array where expected = 5)
    assert_lower_bound(h, 10, array where expected = 8)

  fun assert_lower_bound(h: TestHelper, needle: U32, haystack: ReadSeq[U32], expected: USize, loc: SourceLoc val = __loc) =>
    let idx = Standard.lower_bound[U32](needle, haystack)
    h.assert_eq[USize](expected, idx where loc = loc)

class \nodoc\ iso StandardSearch is UnitTest
  fun name(): String =>
    "standard/apply"
  fun apply(h: TestHelper) =>
    let array: Array[U32] = [1; 2; 3; 4; 5; 7; 8; 9]
    for (i, elem) in Iter[U32](array.values()).enum() do
      assert_search(h, elem, array where expected = (i, true))
    end
    assert_search(h, 0, array where expected = (0, false))
    assert_search(h, 6, array where expected = (5, false))
    assert_search(h, 10, array where expected = (8, false))

  fun assert_search(h: TestHelper, needle: U32, haystack: ReadSeq[U32], expected: (USize, Bool), loc: SourceLoc val = __loc) =>
    (let idx, let found) = Standard[U32](needle, haystack)
    h.assert_eq[USize](expected._1, idx where loc = loc)
    h.assert_eq[Bool](expected._2, found where loc = loc)

