// To parse this JSON data, do
//
//     final patient = patientFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Patient patientFromJson(String str) => Patient.fromJson(json.decode(str));

String patientToJson(Patient data) => json.encode(data.toJson());

class Patient {
  final bool status;
  final String message;
  final List<PatientElement> patientElement;

  Patient({
    required this.status,
    required this.message,
    required this.patientElement,
  });

  Patient copyWith({
    bool? status,
    String? message,
    List<PatientElement>? patient,
  }) =>
      Patient(
        status: status ?? this.status,
        message: message ?? this.message,
        patientElement: patient ?? this.patientElement,
      );

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    status: json["status"] ?? false,
    message: json["message"] ?? "",
    patientElement: json["patient"] != null
        ? List<PatientElement>.from(json["patient"].map((x) => PatientElement.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "patient": List<dynamic>.from(patientElement.map((x) => x.toJson())),
  };
}

class PatientElement {
  final int id;
  final List<PatientdetailsSet> patientdetailsSet;
  final Branch branch;
  final String user;
  final String payment;
  final String name;
  final String phone;
  final String address;
  final dynamic price;
  final int totalAmount;
  final int discountAmount;
  final int advanceAmount;
  final int balanceAmount;
  final DateTime dateNdTime;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  PatientElement({
    required this.id,
    required this.patientdetailsSet,
    required this.branch,
    required this.user,
    required this.payment,
    required this.name,
    required this.phone,
    required this.address,
    required this.price,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.dateNdTime,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  PatientElement copyWith({
    int? id,
    List<PatientdetailsSet>? patientdetailsSet,
    Branch? branch,
    String? user,
    String? payment,
    String? name,
    String? phone,
    String? address,
    dynamic price,
    int? totalAmount,
    int? discountAmount,
    int? advanceAmount,
    int? balanceAmount,
    DateTime? dateNdTime,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      PatientElement(
        id: id ?? this.id,
        patientdetailsSet: patientdetailsSet ?? this.patientdetailsSet,
        branch: branch ?? this.branch,
        user: user ?? this.user,
        payment: payment ?? this.payment,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        price: price ?? this.price,
        totalAmount: totalAmount ?? this.totalAmount,
        discountAmount: discountAmount ?? this.discountAmount,
        advanceAmount: advanceAmount ?? this.advanceAmount,
        balanceAmount: balanceAmount ?? this.balanceAmount,
        dateNdTime: dateNdTime ?? this.dateNdTime,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PatientElement.fromJson(Map<String, dynamic> json) => PatientElement(
    id: json["id"] ?? 0,
    patientdetailsSet: json["patientdetails_set"] != null
        ? List<PatientdetailsSet>.from(json["patientdetails_set"].map((x) => PatientdetailsSet.fromJson(x)))
        : [],
    branch: json["branch"] != null ? Branch.fromJson(json["branch"]) : Branch.empty(),
    user: json["user"] ?? "",
    payment: json["payment"] ?? "",
    name: json["name"] ?? "",
    phone: json["phone"] ?? "",
    address: json["address"] ?? "",
    price: json["price"],
    totalAmount: json["total_amount"] ?? 0,
    discountAmount: json["discount_amount"] ?? 0,
    advanceAmount: json["advance_amount"] ?? 0,
    balanceAmount: json["balance_amount"] ?? 0,
    dateNdTime: json["date_nd_time"] != null ? DateTime.parse(json["date_nd_time"]) : DateTime(1970),
    isActive: json["is_active"] ?? false,
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime(1970),
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : DateTime(1970),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "patientdetails_set": List<dynamic>.from(patientdetailsSet.map((x) => x.toJson())),
    "branch": branch.toJson(),
    "user": user,
    "payment": payment,
    "name": name,
    "phone": phone,
    "address": address,
    "price": price,
    "total_amount": totalAmount,
    "discount_amount": discountAmount,
    "advance_amount": advanceAmount,
    "balance_amount": balanceAmount,
    "date_nd_time": dateNdTime.toIso8601String(),
    "is_active": isActive,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Branch {
  final int id;
  final Name name;
  final int patientsCount;
  final Location location;
  final Phone phone;
  final Mail mail;
  final Address address;
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
    Name? name,
    int? patientsCount,
    Location? location,
    Phone? phone,
    Mail? mail,
    Address? address,
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
    id: json["id"] ?? 0,
    name: nameValues.map[json["name"]] ?? Name.EDAPPALI,
    patientsCount: json["patients_count"] ?? 0,
    location: locationValues.map[json["location"]] ?? Location.KOCHI,
    phone: phoneValues.map[json["phone"]] ?? Phone.THE_9846123456,
    mail: mailValues.map[json["mail"]] ?? Mail.USER123_GMAIL_COM,
    address: addressValues.map[json["address"]] ?? Address.KOCHI_KERALA_685565,
    gst: json["gst"] ?? "",
    isActive: json["is_active"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "patients_count": patientsCount,
    "location": locationValues.reverse[location],
    "phone": phoneValues.reverse[phone],
    "mail": mailValues.reverse[mail],
    "address": addressValues.reverse[address],
    "gst": gst,
    "is_active": isActive,
  };

  // Empty factory constructor to handle null branches
  factory Branch.empty() => Branch(
    id: 0,
    name: Name.EDAPPALI,
    patientsCount: 0,
    location: Location.KOCHI,
    phone: Phone.THE_9846123456,
    mail: Mail.USER123_GMAIL_COM,
    address: Address.KOCHI_KERALA_685565,
    gst: "",
    isActive: false,
  );
}

enum Address { KOCHI_KERALA_685565, KOTTAYAM_KERALA_686563, KOZHIKODE }

final addressValues = EnumValues({
  "Kochi, Kerala-685565": Address.KOCHI_KERALA_685565,
  "Kottayam, Kerala-686563": Address.KOTTAYAM_KERALA_686563,
  "Kozhikode": Address.KOZHIKODE
});

enum Location { KOCHI, KOZHIKODE, KUMARAKOM_KOTTAYAM }

final locationValues = EnumValues({
  "Kochi": Location.KOCHI,
  "Kozhikode": Location.KOZHIKODE,
  "Kumarakom, Kottayam": Location.KUMARAKOM_KOTTAYAM
});

enum Mail { USER123_GMAIL_COM }

final mailValues = EnumValues({
  "user123@gmail.com": Mail.USER123_GMAIL_COM
});

enum Name { EDAPPALI, KUMARAKOM, NADAKKAVU, THONDAYADU }

final nameValues = EnumValues({
  "Edappali": Name.EDAPPALI,
  "KUMARAKOM": Name.KUMARAKOM,
  "Nadakkavu": Name.NADAKKAVU,
  "Thondayadu": Name.THONDAYADU
});

enum Phone { PHONE_99463314529747331452, THE_9846123456, THE_99463314529747331452 }

final phoneValues = EnumValues({
  "9946331452, 9747331452": Phone.PHONE_99463314529747331452,
  "9846123456": Phone.THE_9846123456,
  "9946331452,9747331452": Phone.THE_99463314529747331452
});

class PatientdetailsSet {
  final int id;
  final String male;
  final String female;
  final int patient;
  final int treatment;
  final String treatmentName;

  PatientdetailsSet({
    required this.id,
    required this.male,
    required this.female,
    required this.patient,
    required this.treatment,
    required this.treatmentName,
  });

  PatientdetailsSet copyWith({
    int? id,
    String? male,
    String? female,
    int? patient,
    int? treatment,
    String? treatmentName,
  }) =>
      PatientdetailsSet(
        id: id ?? this.id,
        male: male ?? this.male,
        female: female ?? this.female,
        patient: patient ?? this.patient,
        treatment: treatment ?? this.treatment,
        treatmentName: treatmentName ?? this.treatmentName,
      );

  factory PatientdetailsSet.fromJson(Map<String, dynamic> json) => PatientdetailsSet(
    id: json["id"] ?? 0,
    male: json["male"] ?? "",
    female: json["female"] ?? "",
    patient: json["patient"] ?? 0,
    treatment: json["treatment"] ?? 0,
    treatmentName: json["treatment_name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "male": male,
    "female": female,
    "patient": patient,
    "treatment": treatment,
    "treatment_name": treatmentName,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
