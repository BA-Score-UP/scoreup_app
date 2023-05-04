List<String> removeNull(List<String?> nullList) {
  final nonNullList = nullList.whereType<String>().toList();
  return nonNullList;
}
