use "pony_test"

actor \nodoc\ Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(StandardLowerBoundNumericSmall)

class \nodoc\ iso StandardLowerBoundNumericSmall is UnitTest
  fun name(): String =>
    "standard/lower_bound/numeric"
  fun apply(h: TestHelper) =>
    let array: Array[U32] = [1; 2; 3; 4; 5; 6; 7; 8; 9]
    assert_lower_bound(h, 3, array where expected = 2)
    assert_lower_bound(h, 0, array where expected = 0)
    assert_lower_bound(h, 10, array where expected = 9)

  fun assert_lower_bound(h: TestHelper, needle: U32, haystack: ReadSeq[U32], expected: USize, loc: SourceLoc val = __loc) =>
    (let idx, let found) = Standard[U32](needle, haystack)
    h.assert_eq[USize](expected, idx where loc = loc)


