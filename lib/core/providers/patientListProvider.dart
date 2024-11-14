import 'package:flutter/material.dart';

class PatientListProvider with ChangeNotifier {
  List<Map<String, dynamic>> _patientList =  [{"treatment_id": "86", "treatment_name": "Herbal Face Pack", "maleCount": "1", "femaleCount": "2"}, ];

  List<Map<String, dynamic>> get patientList => _patientList;

  void addPatient(
      {required String treatmentId,
        required String treatmentName,
        required   int maleCount,
        required   int femaleCount}) {
    _patientList.add({
      'treatment_id': treatmentId,
      'treatment_name': treatmentName,
      'maleCount': maleCount,
      'femaleCount': femaleCount,
    });
;    print(_patientList);
    notifyListeners();
  }

  void editPatient(int index, String treatmentId, String treatmentName, int maleCount, int femaleCount) {
    if (index >= 0 && index < _patientList.length) {
      _patientList[index] = {
        'treatment_id': treatmentId,
        'treatment_name': treatmentName,
        'maleCount': maleCount,
        'femaleCount': femaleCount,
      };
      notifyListeners();
    }
  }

  void removePatient(int index) {
    if (index >= 0 && index < _patientList.length) {
      _patientList.removeAt(index);
      notifyListeners();
    }
  }
}
