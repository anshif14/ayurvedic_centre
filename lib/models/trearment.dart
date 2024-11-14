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
  final List<Treatment> treatments;

  TreatmentModel({
    required this.status,
    required this.message,
    required this.treatments,
  });

  TreatmentModel copyWith({
    bool? status,
    String? message,
    List<Treatment>? treatments,
  }) =>
      TreatmentModel(
        status: status ?? this.status,
        message: message ?? this.message,
        treatments: treatments ?? this.treatments,
      );

  factory TreatmentModel.fromJson(Map<String, dynamic> json) => TreatmentModel(
    status: json["status"],
    message: json["message"],
    treatments: List<Treatment>.from(json["treatments"].map((x) => Treatment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "treatments": List<dynamic>.from(treatments.map((x) => x.toJson())),
  };
}

class Treatment {
  final int id;
  final List<Branch> branches;
  final String name;
  final String duration;
  final String price;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Treatment({
    required this.id,
    required this.branches,
    required this.name,
    required this.duration,
    required this.price,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  Treatment copyWith({
    int? id,
    List<Branch>? branches,
    String? name,
    String? duration,
    String? price,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Treatment(
        id: id ?? this.id,
        branches: branches ?? this.branches,
        name: name ?? this.name,
        duration: duration ?? this.duration,
        price: price ?? this.price,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
    id: json["id"],
    branches: List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
    name: json["name"],
    duration: json["duration"],
    price: json["price"],
    isActive: json["is_active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "branches": List<dynamic>.from(branches.map((x) => x.toJson())),
    "name": name,
    "duration": duration,
    "price": price,
    "is_active": isActive,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Branch {
  final int id;
  final String name;
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
    String? name,
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
    id: json["id"],
    name: json["name"],
    patientsCount: json["patients_count"],
    location: locationValues.map[json["location"]]!,
    phone: phoneValues.map[json["phone"]]!,
    mail: mailValues.map[json["mail"]]!,
    address: addressValues.map[json["address"]]!,
    gst: json["gst"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "patients_count": patientsCount,
    "location": locationValues.reverse[location],
    "phone": phoneValues.reverse[phone],
    "mail": mailValues.reverse[mail],
    "address": addressValues.reverse[address],
    "gst": gst,
    "is_active": isActive,
  };
}

enum Address {
  KOCHI_KERALA_685565,
  KOTTAYAM_KERALA_686563,
  KOZHIKODE
}

final addressValues = EnumValues({
  "Kochi, Kerala-685565": Address.KOCHI_KERALA_685565,
  "Kottayam, Kerala-686563": Address.KOTTAYAM_KERALA_686563,
  "Kozhikode": Address.KOZHIKODE
});

enum Location {
  KOCHI,
  KOZHIKODE,
  KUMARAKOM_KOTTAYAM
}

final locationValues = EnumValues({
  "Kochi": Location.KOCHI,
  "Kozhikode": Location.KOZHIKODE,
  "Kumarakom, Kottayam": Location.KUMARAKOM_KOTTAYAM
});

enum Mail {
  USER123_GMAIL_COM
}

final mailValues = EnumValues({
  "user123@gmail.com": Mail.USER123_GMAIL_COM
});

enum Phone {
  PHONE_99463314529747331452,
  THE_9846123456,
  THE_99463314529747331452
}

final phoneValues = EnumValues({
  "9946331452, 9747331452": Phone.PHONE_99463314529747331452,
  "9846123456": Phone.THE_9846123456,
  "9946331452,9747331452": Phone.THE_99463314529747331452
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
