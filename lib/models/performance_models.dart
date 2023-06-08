class MicroSubjectPerformanceModel {
  final int correct;
  final int made;

  MicroSubjectPerformanceModel({required this.correct, required this.made});

  double get accuracyPercentage => correct / made;
}

class PerformanceModel {
  final Map<String, MicroSubjectPerformanceModel> performanceData;

  PerformanceModel({required this.performanceData});

  List<Map<String, dynamic>> getGoods() {
    return performanceData.entries.where((entry) {
      final accuracy = entry.value.accuracyPercentage;
      return accuracy >= 0.8 && accuracy <= 1.0;
    }).map((entry) {
      return {
        'microSubject': entry.key,
        'accuracyPercentage': entry.value.accuracyPercentage,
      };
    }).toList();
  }

  List<Map<String, dynamic>> getMediums() {
    return performanceData.entries.where((entry) {
      final accuracy = entry.value.accuracyPercentage;
      return accuracy >= 0.5 && accuracy < 0.8;
    }).map((entry) {
      return {
        'microSubject': entry.key,
        'accuracyPercentage': entry.value.accuracyPercentage,
      };
    }).toList();
  }

  List<Map<String, dynamic>> getBads() {
    return performanceData.entries.where((entry) {
      final accuracy = entry.value.accuracyPercentage;
      return accuracy < 0.5;
    }).map((entry) {
      return {
        'microSubject': entry.key,
        'accuracyPercentage': entry.value.accuracyPercentage,
      };
    }).toList();
  }
}
