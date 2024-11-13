import '../../../core/providers/patient_provider.dart';

class PatientController {
  final PatientProvider patientProvider;

  PatientController(this.patientProvider);

  Future<void> refreshPatientList() async {
    await patientProvider.fetchPatients();
  }
}