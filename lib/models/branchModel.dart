class BranchModel {
  final bool status;
  final String message;
  final List<Branch> branches;

  BranchModel({
    required this.status,
    required this.message,
    required this.branches,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      branches: json['branches'] != null
          ? (json['branches'] as List)
          .map((branch) => Branch.fromJson(branch))
          .toList()
          : [], // Initialize as an empty list if branches is null
    );
  }
}
class Branch {
  final int id;
  final String name;
  final int patientsCount;
  final String location;
  final List<String> phone;
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

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      patientsCount: json['patients_count'] ?? 0,
      location: json['location'] ?? '',
      phone: List<String>.from(json['phone'].toString().split(',')),
      mail: json['mail'] ?? '',
      address: json['address'] ?? '',
      gst: json['gst'] ?? '',
      isActive: json['is_active'] ?? false,
    );
  }
}
