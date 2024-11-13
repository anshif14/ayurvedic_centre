class Patient {
  int id;
  List<dynamic> patientDetailsSet;
  Branch branch;
  String user;
  String payment;
  String name;
  String phone;
  String address;
  int? price;
  int totalAmount;
  int discountAmount;
  int advanceAmount;
  int balanceAmount;
  DateTime? dateAndTime;
  bool isActive;
  String createdAt;
  String updatedAt;

  Patient({
    required this.id,
    required this.patientDetailsSet,
    required this.branch,
    required this.user,
    required this.payment,
    required this.name,
    required this.phone,
    required this.address,
    this.price,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    this.dateAndTime,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create an instance from JSON with null-aware conditions
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] ?? 0,
      patientDetailsSet: json['patientdetails_set'] ?? [],
      branch: Branch.fromJson(json['branch'] ?? {}),
      user: json['user'] ?? "",
      payment: json['payment'] ?? "",
      name: json['name'] ?? "",
      phone: json['phone'] ?? "",
      address: json['address'] ?? "",
      price: json['price'] ?? 0,
      totalAmount: json['total_amount'] ?? 0,
      discountAmount: json['discount_amount'] ?? 0,
      advanceAmount: json['advance_amount'] ?? 0,
      balanceAmount: json['balance_amount'] ?? 0,
      dateAndTime: json['date_nd_time'] != null
          ? DateTime.parse(json['date_nd_time'])
          : null,
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }

  // Method to convert this instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientdetails_set': patientDetailsSet,
      'branch': branch.toJson(),
      'user': user,
      'payment': payment,
      'name': name,
      'phone': phone,
      'address': address,
      'price': price,
      'total_amount': totalAmount,
      'discount_amount': discountAmount,
      'advance_amount': advanceAmount,
      'balance_amount': balanceAmount,
      'date_nd_time': dateAndTime?.toIso8601String(),
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Branch {
  int id;
  String name;
  int patientsCount;
  String location;
  String phone;
  String mail;
  String address;
  String? gst;
  bool isActive;

  Branch({
    required this.id,
    required this.name,
    required this.patientsCount,
    required this.location,
    required this.phone,
    required this.mail,
    required this.address,
    this.gst,
    required this.isActive,
  });

  // Factory method to create an instance from JSON with null-aware conditions
  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      patientsCount: json['patients_count'] ?? 0,
      location: json['location'] ?? "",
      phone: json['phone'] ?? "",
      mail: json['mail'] ?? "",
      address: json['address'] ?? "",
      gst: json['gst'],
      isActive: json['is_active'] ?? false,
    );
  }

  // Method to convert this instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'patients_count': patientsCount,
      'location': location,
      'phone': phone,
      'mail': mail,
      'address': address,
      'gst': gst,
      'is_active': isActive,
    };
  }
}
