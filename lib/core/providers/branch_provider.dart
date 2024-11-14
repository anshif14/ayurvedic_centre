import 'package:flutter/material.dart';
import 'package:ayurvedic_centre/services/api_service.dart';
import '../../models/branchModel.dart';

class BranchProvider with ChangeNotifier {

  List<Branch> _branches = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Branch> get branches => _branches;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchBranches() async {


    _isLoading = true;
    _errorMessage = null; // Clear any previous errors
    notifyListeners();

    try {

      BranchModel branchResponse = await ApiService().fetchBranches();


      _branches = branchResponse.branches;

    } catch (error) {
      // Handle any errors, setting an error message
      _errorMessage = "Failed to load branches: $error";
      _branches = []; // Set branches to an empty list on error
    }

    _isLoading = false;
    notifyListeners(); // Notify listeners to update the UI
  }
}
