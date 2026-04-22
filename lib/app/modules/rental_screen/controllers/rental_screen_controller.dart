import 'package:get/get.dart';

import '../../../data/models/rental_property.dart';

class RentalScreenController extends GetxController {
  final RxString selectedCategory = 'All'.obs;
  final RxString query = ''.obs;
  final RxSet<String> favoriteIds = <String>{}.obs;

  final List<RentalProperty> properties = <RentalProperty>[
    RentalProperty(
      id: 'rental_1',
      title: 'Modern Family House',
      location: 'New York, USA',
      imagePath: 'assets/images/house3.jpeg',
      monthlyRent: 1200,
      beds: 3,
      baths: 2,
      areaSqft: 1200,
      type: 'House',
      description:
          'Modern family house with natural light, a private garden and excellent connectivity.',
      amenities: const ['WiFi', 'Parking', 'Garden', 'AC'],
      maintenanceFee: 120,
      securityDepositMonths: 1,
      maxTenants: 4,
      rating: 4.6,
      availableFrom: DateTime.now().add(const Duration(days: 7)),
      available: true,
    ),
    RentalProperty(
      id: 'rental_2',
      title: 'Skyline Apartment',
      location: 'Chicago, USA',
      imagePath: 'assets/images/house2.webp',
      monthlyRent: 1800,
      beds: 2,
      baths: 2,
      areaSqft: 980,
      type: 'Apartment',
      description:
          'City-view apartment with premium finishes, gym access and smart security.',
      amenities: const ['Gym', 'Security', 'Elevator', 'WiFi'],
      maintenanceFee: 160,
      securityDepositMonths: 2,
      maxTenants: 3,
      rating: 4.8,
      availableFrom: DateTime.now().add(const Duration(days: 14)),
      available: true,
    ),
    RentalProperty(
      id: 'rental_3',
      title: 'Palm Crest Villa',
      location: 'Miami, USA',
      imagePath: 'assets/images/house.webp',
      monthlyRent: 2600,
      beds: 4,
      baths: 3,
      areaSqft: 2200,
      type: 'Villa',
      description:
          'Large villa with pool access, landscaped courtyard and quiet neighborhood.',
      amenities: const ['Pool', 'Parking', 'Garden', 'AC', 'WiFi'],
      maintenanceFee: 250,
      securityDepositMonths: 2,
      maxTenants: 6,
      rating: 4.9,
      availableFrom: DateTime.now().add(const Duration(days: 21)),
      available: true,
    ),
  ];

  List<String> get categories {
    final Set<String> dynamicTypes = properties
        .map((property) => property.type)
        .toSet();
    return <String>['All', ...dynamicTypes];
  }

  List<RentalProperty> get filteredProperties {
    final String q = query.value.trim().toLowerCase();
    return properties
        .where((property) {
          final bool matchesCategory =
              selectedCategory.value == 'All' ||
              property.type == selectedCategory.value;
          final bool matchesQuery =
              q.isEmpty ||
              property.title.toLowerCase().contains(q) ||
              property.location.toLowerCase().contains(q) ||
              property.type.toLowerCase().contains(q);
          return matchesCategory && matchesQuery;
        })
        .toList(growable: false);
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  void updateQuery(String value) {
    query.value = value;
  }

  void toggleFavorite(String propertyId) {
    if (favoriteIds.contains(propertyId)) {
      favoriteIds.remove(propertyId);
      return;
    }
    favoriteIds.add(propertyId);
  }

  bool isFavorite(String propertyId) {
    return favoriteIds.contains(propertyId);
  }
}
