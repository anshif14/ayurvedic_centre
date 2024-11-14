//
//
// import 'package:ayurvedic_centre/models/patientModel.dart';
// import 'package:ayurvedic_centre/models/trearment.dart';
// import 'package:ayurvedic_centre/services/api_service.dart';
// import 'package:flutter/cupertino.dart';
//
// import '../../models/branchModel.dart' as branch;
//
//
//
//
//
// class PatientProvider with ChangeNotifier {
//   Patient? patients  ;
//   bool _isLoading = false;
//
//
//   bool get isLoading => _isLoading;
//
//   final ApiService _apiService = ApiService();
//
//   Future<void> getBranches() async {
//     _isLoading = true;
//     notifyListeners();
//     try {
//
//       var data = await _apiService.fetchPatients();
//
//       patients =  Patient.fromJson(data!);
//     } catch (e) {
//       print(e);
//       patients = Patient(status: false, message: "No data found", patientElement: []);
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//   List<Branch> _branches = [];
//   List<String> _treatments = [];
//   String? selectedBranch;
//   List<String> maleTreatments = [];
//   List<String> femaleTreatments = [];
//
//   List<Branch> get branches => _branches;
//   List<String> get treatments => _treatments;
//
//   Future<void> fetchBranches() async {
//     _branches = (await _apiService.getBranches()).cast<Branch>();
//     notifyListeners();
//   }
//
//   Future<void> fetchTreatments() async {
//     _treatments = await _apiService.getTreatmentList();
//     notifyListeners();
//   }
//
//   void selectBranch(String branch) {
//     selectedBranch = branch;
//     notifyListeners();
//   }
//
//   void addMaleTreatment(String treatmentId) {
//     maleTreatments.add(treatmentId);
//     notifyListeners();
//   }
//
//   void addFemaleTreatment(String treatmentId) {
//     femaleTreatments.add(treatmentId);
//     notifyListeners();
//   }
//
//   Future<void> submitPatientRegistration(Patient patient) async {
//     await _apiService.registerPatient(name: patient.patientElement[0].name, executive: "", payment: patient.patientElement[0].payment, phone: patient.patientElement[0].phone, address: patient.patientElement[0].address, totalAmount: 0, discountAmount: 0, advanceAmount: patient.patientElement[0].advanceAmount, balanceAmount: balanceAmount, dateNdTime: dateNdTime, maleTreatments: maleTreatments, femaleTreatments: femaleTreatments, branch: branch, treatments: treatments);
//     // Handle PDF generation here
//   }
// }

import 'dart:convert';

import 'package:ayurvedic_centre/models/patientModel.dart';
import 'package:ayurvedic_centre/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PatientProvider with ChangeNotifier {
  Patient? patients;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  Future<void> fetchPatients() async {
    _isLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> data = await _apiService.fetchPatients()!;

      patients = await Patient.fromJson(data);
    } catch (e) {
      print(e);
      print("eeeeeeeeeee");
      patients =
          Patient(status: false, message: "No data found", patientElement: []);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String baseUrl = 'https://flutter-amr.noviindus.in/api/';
  // bool isLoading = false;

  // Add other form field variables if needed
  String? selectedLocation;
  String? selectedBranch;
  String paymentOption = "Cash";

  // Method to register the patient

  final ApiService _apiServices = ApiService();


  String? name;
  String? executive;
  String? payment;
  String? phone;
  String? address;
  String? totalAmount;
  String? discountAmount;
  String? advanceAmount;
  String? balanceAmount;
  String? dateAndTime;
  String id = '';
  String male = '';
  String female = '';
  String? branch;
  String? treatments;


  Future<void> registerPatient(
  {
  required  String name,
  required String executive,
  required  String payment,
  required   String phone,
  required   String address,
  required  String totalAmount,
  required  String discountAmount,
  required  String advanceAmount,
  required  String balanceAmount,
  required  String dateAndTime,
  required   String id  ,
  required  String male ,
  required  String female,
  required  String branch,
  required   String treatments
}


      ) async {
    male = '1,2,3';
    female = '1,2,3';
    treatments = '1,2,3';
    _isLoading = true;
    final patientData = {

      'name': name ?? '',
      'executive': executive ?? '',
      'payment': payment ?? '',
      'phone': phone ?? '',
      'address': address ?? '',
      'total_amount': (double.tryParse(totalAmount ?? '0.0') ?? 0.0).toString(),
      'discount_amount': (double.tryParse(discountAmount ?? '0.0') ?? 0.0).toString(),
      'advance_amount': (double.tryParse(advanceAmount ?? '0.0') ?? 0.0).toString(),
      'balance_amount': (double.tryParse(balanceAmount ?? '0.0') ?? 0.0).toString(),
      'date_nd_time': dateAndTime ?? '',
      'id': id,
      'male': male.isNotEmpty ? male : '',
      'female': female.isNotEmpty ? female : '',
      'branch': branch ?? '',
      'treatments': treatments?.isNotEmpty == true ? treatments : '',
    };
    print(patientData);
    final minimalData = {
      'name': name ?? '',
      'executive': executive ?? '',
      'phone': phone ?? '',
      'branch': branch ?? '',
      'treatments': treatments ?? '',
    };
    try {
      final response = await _apiServices.registerPatient(patientData);
      print(response);

      _isLoading = false;
      // print(response.)
      // Handle response (e.g., update UI, show success message)
      notifyListeners();
    } catch (error) {
      _isLoading = false;

      // Handle error (e.g., show error message)
      print(error);
    }
  }

  void setName(String value) {
    name = value;
    notifyListeners();
  }

  // Other setters for form fields...

  // Validation logic for form fields
  String? validateName() {
    return name == null || name!.isEmpty ? 'Name is required' : null;
  }
   // = false;


  notifyListeners();
}
