import 'package:ayurvedic_centre/models/trearment.dart';
import 'package:flutter/material.dart';

import '../../services/api_service.dart';


class TreatmentProvider with ChangeNotifier {
  List<TreatmentModel> _treatments = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<TreatmentModel> get treatments => _treatments;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch treatments from the API
  Future<void> fetchTreatments() async {
    _isLoading = true;
    _errorMessage = null; // Reset any error message
    notifyListeners();

    try {
      // Fetch the data from API
      TreatmentModel treatmentResponse = await ApiService().fetchTreatments();


      // _treatments = treatmentResponse.branches;
    } catch (error) {
      // Handle the error by setting an error message
      _errorMessage = 'Failed to load treatments: $error';
      _treatments = []; // Clear the treatments list if there's an error
    }

    _isLoading = false;
    notifyListeners(); // Notify listeners after the data is fetched or an error occurs
  }
}
