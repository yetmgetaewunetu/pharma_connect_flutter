class Pharmacy {
  final String id;
  final String name;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String contactNumber;
  final String email;
  final String ownerName;
  final String ownerId;
  final double latitude;
  final double longitude;
  final String licenseNumber;
  final String licenseImage;
  final String pharmacyImage;
  final DateTime createdAt;
  final DateTime updatedAt;

  Pharmacy({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.contactNumber,
    required this.email,
    required this.ownerName,
    required this.ownerId,
    required this.latitude,
    required this.longitude,
    required this.licenseNumber,
    required this.licenseImage,
    required this.pharmacyImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zipCode: json['zipCode'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
      email: json['email'] ?? '',
      ownerName: json['ownerName'] ?? '',
      ownerId: json['ownerId'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      licenseNumber: json['licenseNumber'] ?? '',
      licenseImage: json['licenseImage'] ?? '',
      pharmacyImage: json['pharmacyImage'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'contactNumber': contactNumber,
      'email': email,
      'ownerName': ownerName,
      'ownerId': ownerId,
      'latitude': latitude,
      'longitude': longitude,
      'licenseNumber': licenseNumber,
      'licenseImage': licenseImage,
      'pharmacyImage': pharmacyImage,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
} 