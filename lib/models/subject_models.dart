class SubjectListModel {
  final List<MacroSubjectModel> macroSubjects = [];

  void add(MacroSubjectModel macroSubject) {
    macroSubjects.add(macroSubject);
  }

  MacroSubjectModel? getMacroSubjectByName(String name) {
    return macroSubjects.firstWhere((e) => e.macroSubjectName == name);
  }

  List<String> getCastedMacroSubjects() {
    return macroSubjects.map((e) => e.macroSubjectName).toList();
  }
}

class MicroSubjectListModel {
  final List<MicroSubjectModel> microSubjects = [];

  MicroSubjectListModel();

  void add(MicroSubjectModel microSubject) {
    microSubjects.add(microSubject);
  }

  List<String> getCastedMicroSubjects() {
    return microSubjects.map((e) => e.microSubjectName).toList();
  }
}

class MacroSubjectModel {
  final String macroSubjectName;
  final MicroSubjectListModel microSubjects;

  factory MacroSubjectModel(String macroSubjectName, MicroSubjectListModel microSubjects) {
    return MacroSubjectModel._(macroSubjectName, microSubjects);
  }

  MacroSubjectModel._(this.macroSubjectName, this.microSubjects);
}

class MicroSubjectModel {
  final String microSubjectName;

  MicroSubjectModel(this.microSubjectName);
}
