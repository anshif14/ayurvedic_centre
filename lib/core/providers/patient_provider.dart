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



import 'package:ayurvedic_centre/models/patientModel.dart';
import 'package:ayurvedic_centre/services/api_service.dart';
import 'package:flutter/cupertino.dart';





class PatientProvider with ChangeNotifier {
  Patient? patients  ;
  bool _isLoading = false;


  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  Future<void> fetchPatients() async {
    _isLoading = true;
    notifyListeners();
    try {
      Map <String, dynamic> data = await  _apiService.fetchPatients()!;

      patients = await Patient.fromJson(data );
    } catch (e) {
      print(e);
      print("eeeeeeeeeee");
      patients = Patient(status: false, message: "No data found", patientElement: []);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}