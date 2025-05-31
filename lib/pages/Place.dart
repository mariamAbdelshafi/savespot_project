class Place {
  final String id;
  final String name;
  final String address;
  final String description;
  final String phoneNumber;
  final String emailAddress;
  final double avgRating;
  final List<String> images;
  final bool favorite;
  final int? numberComments;
  final String category;

  Place({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.phoneNumber,
    required this.emailAddress,
    required this.avgRating,
    required this.images,
    required this.favorite,
    this.numberComments,
    required this.category,
  });

  factory Place.fromMap(Map<String, dynamic> data, String documentId) {
      return Place(
        id: documentId,
        name: data['name'] ?? '',
        address: data['address'] ?? '',
        description: data['description'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        emailAddress: data['emailAddress'] ?? '',
        avgRating: (data['point'] ?? 0).toDouble(),
        images: List<String>.from(data['images'] ?? []),
        favorite: data['favorite'] ?? false,
      numberComments: data['numberComments'] ?? 0,
      category: data['category'] ?? '',
    );
  }

}

