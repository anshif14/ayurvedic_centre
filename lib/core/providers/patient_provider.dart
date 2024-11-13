

import 'package:ayurvedic_centre/models/patientModel.dart';
import 'package:ayurvedic_centre/services/api_service.dart';
import 'package:flutter/cupertino.dart';





class PatientProvider with ChangeNotifier {
  List<Patient> _patients = [];
  bool _isLoading = false;


  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  Future<void> fetchPatients() async {
    _isLoading = true;
    notifyListeners();
    try {
      _patients = await _apiService.fetchPatients();
    } catch (e) {
      print(e);
      _patients = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}