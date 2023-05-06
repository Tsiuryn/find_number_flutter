extension ListExtension<E> on List<E> {
  List<List<E>> chunked([int step = 1]) {
    final chunkedList = this;
    if (step < 1) throw ArgumentError("Step can not be less then 1");

    if (step == 1) return [this];

    List<List<E>> returnedList = [];

    List<E> inlineList = [];

    for (var i = 0; i < chunkedList.length; ++i) {
      inlineList.add(chunkedList[i]);
      if (i != 0 && (i + 1) % step == 0) {
        final newList = [...inlineList];
        returnedList.add(newList);
        inlineList.clear();
      }
      if (i == chunkedList.length - 1 && inlineList.isNotEmpty) {
        returnedList.add(inlineList);
      }
    }

    return returnedList;
  }

  E? get firstOrNull {
    var iterator = this.iterator;
    if (iterator.moveNext()) return iterator.current;
    return null;
  }
}