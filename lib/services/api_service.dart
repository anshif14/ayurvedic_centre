// services/api_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:ayurvedic_centre/main.dart';
import 'package:ayurvedic_centre/models/patientModel.dart';
import 'package:ayurvedic_centre/models/trearment.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';

import '../core/common/genetatePdf.dart';
import '../models/branchModel.dart';
import '../models/branchModel.dart' as branch;
// import '../models/patientModel.dart' as patient;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';



class ApiService {
  final String baseUrl = 'https://flutter-amr.noviindus.in/api/';

Future<Map<String, dynamic>>? fetchPatients() async {


    final response = await http.get(Uri.parse('${baseUrl}PatientList'),

      headers: {
        'Authorization': 'Bearer $currentUserToken',
        'Content-Type': 'application/json',
      },
    );
    // print(response.body);

    if (response.statusCode == 200) {

// print(data.runtimeType);

     var data = json.decode(response.body);



      // print(data[0].keys.toList());
     // Map test ={};
     // for(var docs in data[0].keys){
     //   test.addAll({
     //     docs.toString():data[0][docs].runtimeType
     //   });
     // }
     // print(test);

      return data;
    } else {
      throw Exception('Failed to load patients');
    }
  }
  // Fetch Branch List
 Future<BranchModel> fetchBranches() async {

      final response = await http.get(
        Uri.parse('${baseUrl}BranchList'),
        headers: {
          'Authorization': 'Bearer $currentUserToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {


        Map<String, dynamic> data = jsonDecode(response.body);




        return  BranchModel.fromJson(data);
      } else {
        throw Exception('Failed to load branches');
      }
    }

  fetchTreatments() async {

    try{
      final response = await http.get(
        Uri.parse('${baseUrl}TreatmentList'),
        headers: {
          'Authorization': 'Bearer $currentUserToken',
          'Content-Type': 'application/json',
        },
      );


      if (response.statusCode == 200) {
        // print(response.body);
        Map<String,dynamic> data = jsonDecode(response.body);

        // downloadAndSaveJson(data);
        // print(data);
        // print(data.keys);
        //
        // for(var docs in data.values.toList()){
        //   print(docs.runtimeType);
        // }
        // print(data.values.toList().runtimeType);

        return  TreatmentModel.fromJson(data)
        ; // Extract treatment names
      } else {
        throw Exception('Failed to load treatments');
      }
    }catch(e){
      // print(e);
    }
  }



  Future<void> registerPatient({
    required String name,
    required String executive,
    required String payment,
    required String phone,
    required String address,
    required double totalAmount,
    required double discountAmount,
    required double advanceAmount,
    required double balanceAmount,
    required String dateNdTime,
    required String maleTreatments,
    required String femaleTreatments,
    required String branch,
    required List<int> treatments,
  }) async {
    final url = Uri.parse('https://your-api-url/PatientUpdate');
    final response = await http.post(
      url,
      body: json.encode({
        'name': name,
        'excecutive': executive,
        'payment': payment,
        'phone': phone,
        'address': address,
        'total_amount': totalAmount,
        'discount_amount': discountAmount,
        'advance_amount': advanceAmount,
        'balance_amount': balanceAmount,
        'date_nd_time': dateNdTime,
        'id': '', // Empty string as instructed
        'male': maleTreatments,
        'female': femaleTreatments,
        'branch': branch,
        'treatments': treatments.join(','),
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('Patient registered successfully');
      // Optionally, you can generate the PDF here
      generatePdf(
        name: name,
        executive: executive,
        payment: payment,
        phone: phone,
        address: address,
        totalAmount: totalAmount,
        discountAmount: discountAmount,
        advanceAmount: advanceAmount,
        balanceAmount: balanceAmount,
        dateNdTime: dateNdTime,
        maleTreatments: maleTreatments,
        femaleTreatments: femaleTreatments,
        branch: branch,
        treatments: treatments,
      );
    } else {
      print('Failed to register patient');
      throw Exception('Failed to register patient');
    }
  }
  }











Future<void> requestPermission() async {
  PermissionStatus status = await Permission.storage.request();
  if (status.isGranted) {
    print("Storage permission granted");
  } else {
    print("Storage permission denied");
  }
}
Future<void> downloadAndSaveJson(Map url) async {
  // Request permission to access storage
  await requestPermission();

  try {
    // Make the API request to fetch the JSON data
    // final response = await http.get(Uri.parse(url));

    // if (response.statusCode == 200) {
      // Get the device's external storage directory
      final directory = await getExternalStorageDirectory();
     final downloadsPath = '/storage/emulated/0/Download'; // Android Downloads folder
      final filePath = '$downloadsPath/treatment.json';

      // Write the JSON response to a file
      final file = File(filePath);
      await file.writeAsString(jsonEncode(url));

      print("File downloaded to: $filePath");
    // } else {
    //   print("Failed to fetch data. Status code: ${response.statusCode}");
    // }
  } catch (e) {
    print("Error downloading file: $e");
  }

}