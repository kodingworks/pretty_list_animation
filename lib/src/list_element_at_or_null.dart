/// An extension method for the `List` class that returns the element at a given
/// index, or null if the index is out of range. This is useful when you don't
/// want to handle an exception for an index that might be out of bounds.
///
/// Example:
///
/// ```dart
/// final myList = [1, 2, 3];
///
/// // Returns 2
/// final element = myList.elementAtOrNull(1);
///
/// // Returns null
/// final nonexistentElement = myList.elementAtOrNull(3);
/// ```
///
/// Note that this method does not throw an exception for negative indexes.
extension ListElementAtOrNull<T> on List<T> {
  T? elementAtOrNull(int index) {
    try {
      return elementAt(index);
    } catch (e) {
      return null;
    }
  }
}
