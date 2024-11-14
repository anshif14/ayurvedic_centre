class GeneratePdfModel{
  final String name;
  final String executive;
  final String payment;
  final String phone;
  final String address;
  final double totalAmount;
  final double discountAmount;
  final double advanceAmount;
  final double balanceAmount;
  final String dateNdTime;
  final String maleTreatments;
  final String femaleTreatments;
  final String branch;
  final List<int> treatments;

//<editor-fold desc="Data Methods">
  const GeneratePdfModel({
    required this.name,
    required this.executive,
    required this.payment,
    required this.phone,
    required this.address,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.dateNdTime,
    required this.maleTreatments,
    required this.femaleTreatments,
    required this.branch,
    required this.treatments,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GeneratePdfModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          executive == other.executive &&
          payment == other.payment &&
          phone == other.phone &&
          address == other.address &&
          totalAmount == other.totalAmount &&
          discountAmount == other.discountAmount &&
          advanceAmount == other.advanceAmount &&
          balanceAmount == other.balanceAmount &&
          dateNdTime == other.dateNdTime &&
          maleTreatments == other.maleTreatments &&
          femaleTreatments == other.femaleTreatments &&
          branch == other.branch &&
          treatments == other.treatments);

  @override
  int get hashCode =>
      name.hashCode ^
      executive.hashCode ^
      payment.hashCode ^
      phone.hashCode ^
      address.hashCode ^
      totalAmount.hashCode ^
      discountAmount.hashCode ^
      advanceAmount.hashCode ^
      balanceAmount.hashCode ^
      dateNdTime.hashCode ^
      maleTreatments.hashCode ^
      femaleTreatments.hashCode ^
      branch.hashCode ^
      treatments.hashCode;

  @override
  String toString() {
    return 'GeneratePdfModel{' +
        ' name: $name,' +
        ' executive: $executive,' +
        ' payment: $payment,' +
        ' phone: $phone,' +
        ' address: $address,' +
        ' totalAmount: $totalAmount,' +
        ' discountAmount: $discountAmount,' +
        ' advanceAmount: $advanceAmount,' +
        ' balanceAmount: $balanceAmount,' +
        ' dateNdTime: $dateNdTime,' +
        ' maleTreatments: $maleTreatments,' +
        ' femaleTreatments: $femaleTreatments,' +
        ' branch: $branch,' +
        ' treatments: $treatments,' +
        '}';
  }

  GeneratePdfModel copyWith({
    String? name,
    String? executive,
    String? payment,
    String? phone,
    String? address,
    double? totalAmount,
    double? discountAmount,
    double? advanceAmount,
    double? balanceAmount,
    String? dateNdTime,
    String? maleTreatments,
    String? femaleTreatments,
    String? branch,
    List<int>? treatments,
  }) {
    return GeneratePdfModel(
      name: name ?? this.name,
      executive: executive ?? this.executive,
      payment: payment ?? this.payment,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      totalAmount: totalAmount ?? this.totalAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      advanceAmount: advanceAmount ?? this.advanceAmount,
      balanceAmount: balanceAmount ?? this.balanceAmount,
      dateNdTime: dateNdTime ?? this.dateNdTime,
      maleTreatments: maleTreatments ?? this.maleTreatments,
      femaleTreatments: femaleTreatments ?? this.femaleTreatments,
      branch: branch ?? this.branch,
      treatments: treatments ?? this.treatments,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'executive': this.executive,
      'payment': this.payment,
      'phone': this.phone,
      'address': this.address,
      'totalAmount': this.totalAmount,
      'discountAmount': this.discountAmount,
      'advanceAmount': this.advanceAmount,
      'balanceAmount': this.balanceAmount,
      'dateNdTime': this.dateNdTime,
      'maleTreatments': this.maleTreatments,
      'femaleTreatments': this.femaleTreatments,
      'branch': this.branch,
      'treatments': this.treatments,
    };
  }

  factory GeneratePdfModel.fromMap(Map<String, dynamic> map) {
    return GeneratePdfModel(
      name: map['name'] as String,
      executive: map['executive'] as String,
      payment: map['payment'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      totalAmount: map['totalAmount'] as double,
      discountAmount: map['discountAmount'] as double,
      advanceAmount: map['advanceAmount'] as double,
      balanceAmount: map['balanceAmount'] as double,
      dateNdTime: map['dateNdTime'] as String,
      maleTreatments: map['maleTreatments'] as String,
      femaleTreatments: map['femaleTreatments'] as String,
      branch: map['branch'] as String,
      treatments: map['treatments'] as List<int>,
    );
  }

//</editor-fold>
}