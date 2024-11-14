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
  Future<TreatmentModel> fetchTreatments() async {
    _isLoading = true;
    _errorMessage = null; // Reset any error message
    notifyListeners();


      // Fetch the data from API
      TreatmentModel treatmentResponse = await ApiService().fetchTreatments();

print(treatmentResponse.treatments);
      // _treatments = treatmentResponse.branches;
      return treatmentResponse;
    }

    // _isLoading = false;
    notifyListeners(); // Notify listeners after the data is fetched or an error occurs
  }
// }
