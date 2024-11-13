// services/api_service.dart
import 'dart:convert';
import 'package:ayurvedic_centre/main.dart';
import 'package:http/http.dart' as http;

import '../models/patientModel.dart';


class ApiService {
  final String baseUrl = 'https://flutter-amr.noviindus.in/api/';

  Future<List<Patient>> fetchPatients() async {


    final response = await http.get(Uri.parse('${baseUrl}PatientList'),

      headers: {
        'Authorization': 'Bearer $currentUserToken',
        'Content-Type': 'application/json',
      },
    );
    // print(response.body);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['patient'];
      // print(data[0].keys.toList());
     Map test ={};
     for(var docs in data[0].keys){
       test.addAll({
         docs.toString():data[0][docs].runtimeType
       });
     }
     print(test);
     // print(data);
      return data.map((json) => Patient.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load patients');
    }
  }
}
