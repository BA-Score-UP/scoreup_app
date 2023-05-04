List<String> removeNull(List<String?> nullList) {
  List<String> nonNullList = List<String>.from(nullList.where((e) => e != null).toList());
  return nonNullList.where((e) => e != "null").toList();
}
