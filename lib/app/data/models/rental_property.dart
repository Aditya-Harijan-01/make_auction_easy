class RentalProperty {
  const RentalProperty({
    required this.id,
    required this.title,
    required this.location,
    required this.imagePath,
    required this.monthlyRent,
    required this.beds,
    required this.baths,
    required this.areaSqft,
    required this.type,
    required this.description,
    required this.amenities,
    required this.maintenanceFee,
    required this.securityDepositMonths,
    required this.maxTenants,
    required this.rating,
    required this.availableFrom,
    required this.available,
  });

  final String id;
  final String title;
  final String location;
  final String imagePath;
  final int monthlyRent;
  final int beds;
  final int baths;
  final int areaSqft;
  final String type;
  final String description;
  final List<String> amenities;
  final int maintenanceFee;
  final int securityDepositMonths;
  final int maxTenants;
  final double rating;
  final DateTime availableFrom;
  final bool available;

  factory RentalProperty.fromMap(Map<String, dynamic> map) {
    return RentalProperty(
      id: (map['id'] as String?) ?? 'default',
      title: (map['title'] as String?) ?? 'Modern Family House',
      location: (map['location'] as String?) ?? 'New York, USA',
      imagePath: (map['imagePath'] as String?) ?? 'assets/images/house.webp',
      monthlyRent: _toInt(map['monthlyRent'], fallback: 1200),
      beds: _toInt(map['beds'], fallback: 3),
      baths: _toInt(map['baths'], fallback: 2),
      areaSqft: _toInt(map['areaSqft'], fallback: 1200),
      type: (map['type'] as String?) ?? 'House',
      description:
          (map['description'] as String?) ??
          'Beautiful modern house with spacious rooms and a bright living area.',
      amenities:
          (map['amenities'] as List?)
              ?.map((item) => item.toString())
              .toList(growable: false) ??
          const ['WiFi', 'Parking', 'AC'],
      maintenanceFee: _toInt(map['maintenanceFee'], fallback: 120),
      securityDepositMonths: _toInt(map['securityDepositMonths'], fallback: 1),
      maxTenants: _toInt(map['maxTenants'], fallback: 4),
      rating: _toDouble(map['rating'], fallback: 4.5),
      availableFrom: _toDate(map['availableFrom']),
      available: (map['available'] as bool?) ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'location': location,
      'imagePath': imagePath,
      'monthlyRent': monthlyRent,
      'beds': beds,
      'baths': baths,
      'areaSqft': areaSqft,
      'type': type,
      'description': description,
      'amenities': amenities,
      'maintenanceFee': maintenanceFee,
      'securityDepositMonths': securityDepositMonths,
      'maxTenants': maxTenants,
      'rating': rating,
      'availableFrom': availableFrom.toIso8601String(),
      'available': available,
    };
  }

  static RentalProperty fallback() {
    return RentalProperty(
      id: 'fallback',
      title: 'Modern Family House',
      location: 'New York, USA',
      imagePath: 'assets/images/house.webp',
      monthlyRent: 1200,
      beds: 3,
      baths: 2,
      areaSqft: 1200,
      type: 'House',
      description:
          'Beautiful modern house with spacious rooms, private garden and great location.',
      amenities: const ['WiFi', 'Parking', 'Pool', 'AC'],
      maintenanceFee: 120,
      securityDepositMonths: 1,
      maxTenants: 4,
      rating: 4.6,
      availableFrom: DateTime.now().add(const Duration(days: 7)),
      available: true,
    );
  }
}

int _toInt(Object? value, {required int fallback}) {
  if (value is int) {
    return value;
  }

  if (value is double) {
    return value.round();
  }

  if (value is String) {
    return int.tryParse(value) ?? fallback;
  }

  return fallback;
}

double _toDouble(Object? value, {required double fallback}) {
  if (value is double) {
    return value;
  }

  if (value is int) {
    return value.toDouble();
  }

  if (value is String) {
    return double.tryParse(value) ?? fallback;
  }

  return fallback;
}

DateTime _toDate(Object? value) {
  if (value is DateTime) {
    return value;
  }

  if (value is String) {
    final parsed = DateTime.tryParse(value);
    if (parsed != null) {
      return parsed;
    }
  }

  return DateTime.now().add(const Duration(days: 7));
}
