// To parse this JSON data, do
//
//     final treatmentModel = treatmentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TreatmentModel treatmentModelFromJson(String str) => TreatmentModel.fromJson(json.decode(str));

String treatmentModelToJson(TreatmentModel data) => json.encode(data.toJson());

class TreatmentModel {
  final bool status;
  final String message;
  final List<Branch> branches;

  TreatmentModel({
    required this.status,
    required this.message,
    required this.branches,
  });

  TreatmentModel copyWith({
    bool? status,
    String? message,
    List<Branch>? branches,
  }) =>
      TreatmentModel(
        status: status ?? this.status,
        message: message ?? this.message,
        branches: branches ?? this.branches,
      );

  factory TreatmentModel.fromJson(Map<String, dynamic> json) => TreatmentModel(
    status: json["status"],
    message: json["message"],
    branches: List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "branches": List<dynamic>.from(branches.map((x) => x.toJson())),
  };
}

class Branch {
  final int id;
  final String name;
  final int patientsCount;
  final String location;
  final String phone;
  final String mail;
  final String address;
  final String gst;
  final bool isActive;

  Branch({
    required this.id,
    required this.name,
    required this.patientsCount,
    required this.location,
    required this.phone,
    required this.mail,
    required this.address,
    required this.gst,
    required this.isActive,
  });

  Branch copyWith({
    int? id,
    String? name,
    int? patientsCount,
    String? location,
    String? phone,
    String? mail,
    String? address,
    String? gst,
    bool? isActive,
  }) =>
      Branch(
        id: id ?? this.id,
        name: name ?? this.name,
        patientsCount: patientsCount ?? this.patientsCount,
        location: location ?? this.location,
        phone: phone ?? this.phone,
        mail: mail ?? this.mail,
        address: address ?? this.address,
        gst: gst ?? this.gst,
        isActive: isActive ?? this.isActive,
      );

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: json["id"],
    name: json["name"],
    patientsCount: json["patients_count"],
    location: json["location"],
    phone: json["phone"],
    mail: json["mail"],
    address: json["address"],
    gst: json["gst"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "patients_count": patientsCount,
    "location": location,
    "phone": phone,
    "mail": mail,
    "address": address,
    "gst": gst,
    "is_active": isActive,
  };
}
