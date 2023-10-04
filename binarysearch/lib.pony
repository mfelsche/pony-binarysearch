"""
Binary search implementations for searching over `ReadSeq[T]` or inserting into `Array[T] ref`.

Either by comparing the elements directly, if they implement `Comparable[T]` or given a retrieval function
to turn the element into something that can be compared.
"""
primitive Asc
  """
  Ascending ordering
  """
  fun comp[T: Comparable[T] #read](x: box->T, y: box->T): Bool =>
    x.lt(y)

primitive Desc
  """
  Descending ordering
  """
  fun comp[T: Comparable[T] #read](x: box->T, y: box->T): Bool =>
    x.gt(y)

type Ordering is (Asc | Desc)
  """
  Ordering for BinarySearch operations.
  """

trait BinarySearchImpl

  fun lower_bound[T: Comparable[T] #read](
    needle: T,
    haystack: ReadSeq[T],
    ordering: Ordering = Asc
  ): USize
    """
    Return the index of the first element in `haystack` 
    such that `element >= needle` if ordering is `Asc` 
    or `element <= needle` if `ordering` os `Desc`.

    This is a simplified and more performant version of `apply`, not giving information
    if we found an equal element or not.
    """

  fun apply[T: Comparable[T] #read](
      needle: T,
      haystack: ReadSeq[T],
      ordering: Ordering = Asc)
    : (USize, Bool)
      """
      Perform a binary search for `needle` on `haystack` in the given ordering (default: Ascending).

      Returns the result as a 2-tuple of either:
      * the index of the found element and `true` if the search was successful, or
      * the index where to insert the `needle` to maintain a sorted `haystack` and `false`
      """

  fun by[T: Comparable[T] #read, X: Any #read](
      needle: T,
      haystack: ReadSeq[X],
      retrieve: {(box->X): T} val,
      ordering: Ordering = Asc)
    : (USize, Bool)

  fun insert[T: Comparable[T] #read](
      needle: T,
      haystack: Array[T] ref,
      ordering: Ordering = Asc)
    : USize

  fun insert_by[T: Comparable[T] #read, X: Any #read](
      needle: X,
      haystack: Array[X] ref,
      retrieve: {(box->X): T} val,
      ordering: Ordering = Asc)
    : USize

type BinarySearch is Standard

