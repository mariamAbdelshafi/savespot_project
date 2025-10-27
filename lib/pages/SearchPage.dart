import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:savespot_project/pages/Place.dart';
import 'PlacesPage.dart';

class SearchPage extends StatefulWidget {
  final Function(int)? onChangePage;
  const SearchPage({Key? key, this.onChangePage}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<Place> allPlaces = [];
  List<Place> filteredPlaces = [];
  double minRatingFilter = 0.0;
  int minCommentsFilter = 0;
  bool _isLoading = true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Set<String> favoritePlaceIds = {};
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  List<Map<String, dynamic>> lastSeenPlaces = [];

  Future<void> loadLastSeenPlaces() async {
    try {
      if (userId == null || !mounted) return;

      final doc = await _firestore.collection('users').doc(userId!).get();
      final data = doc.data() ?? {};

      final rawList = data['lastSeen'] as List? ?? [];

      setState(() {
        lastSeenPlaces = rawList
            .map((item) => Map<String, dynamic>.from(item))
            .where((place) => place['name'] != null && place['name'] != 'Unknown')
            .toList();
      });

    } catch (e) {
      print('Error loading lastSeen: $e');
    }
  }

  Future<void> updateLastSeenPlace({
    required String placeId,
    required String name,
    required List<String> images,
    required String address,
    required String description,
    required String phoneNumber,
    required String emailAddress,
    required double avgRating,
  }) async {
    if (userId == null || !mounted) return;

    try {
      final userRef = _firestore.collection('users').doc(userId!);
      final placeData = {
        'id': placeId,
        'name': name,
        'images': images,
        'address': address,
        'description': description,
        'phoneNumber': phoneNumber,
        'emailAddress': emailAddress,
        'avgRating': avgRating,
        'clickedAt': DateTime.now().toIso8601String(),
      };

      await _firestore.runTransaction((transaction) async {
        final doc = await transaction.get(userRef);
        List<dynamic> current = List.from(doc.data()?['lastSeen'] ?? []);

        current.removeWhere((item) => item['id'] == placeId);
        current.insert(0, placeData);
        if (current.length > 5) current = current.sublist(0, 5);

        transaction.update(userRef, {'lastSeen': current});
      });

      if (mounted) {
        await loadLastSeenPlaces();
        setState(() {});
      }
    } catch (e) {
      print('error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error updating last seen")),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPlaces();
    _controller.addListener(_applyFilters);
    loadLastSeenPlaces();
  }

  Future<void> _loadPlaces() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('Places').get();
      List<Place> loadedPlaces = [];

      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final placeId = doc.id;

        final commentsSnapshot = await FirebaseFirestore.instance
            .collection('comments')
            .where('placeId', isEqualTo: placeId)
            .get();

        double avgRating = 0.0;
        if (commentsSnapshot.docs.isNotEmpty) {
          final total = commentsSnapshot.docs.fold(0.0, (sum, doc) => sum + (doc.data()['rating'] as num).toDouble());
          avgRating = total / commentsSnapshot.docs.length;
        }

        loadedPlaces.add(Place.fromMap({
          ...data,
          'id': placeId,
          'point': avgRating,
          'numberComments': commentsSnapshot.docs.length,
          'emailAddress': data['emailAddress'] ?? '',
        }, placeId));
      }

      if (mounted) {
        setState(() {
          allPlaces = loadedPlaces;
          filteredPlaces = loadedPlaces;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      debugPrint('Error loading places: $e');
    }
  }

  void _applyFilters() {
    final searchQuery = _controller.text.toLowerCase();

    setState(() {
      filteredPlaces = allPlaces.where((place) {
        final matchesSearch = searchQuery.isEmpty ||
            place.name.toLowerCase().contains(searchQuery) ||
            place.address.toLowerCase().contains(searchQuery) ||
            place.description.toLowerCase().contains(searchQuery) ||
            place.category.toLowerCase().contains(searchQuery);

        final matchesRating = minRatingFilter == 0.0 ||
            (place.avgRating ?? 0.0) >= minRatingFilter;

        final matchesComments = minCommentsFilter == 0 ||
            (place.numberComments ?? 0) >= minCommentsFilter;

        return matchesSearch && matchesRating && matchesComments;
      }).toList();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: Column(
        children: [
          SizedBox(height: 80),
          Row(
            children: [
              SizedBox(width: 35),
              SizedBox(
                width: 250,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.brown[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.brown[800],
                      ),
                      labelText: 'Search',
                      labelStyle: TextStyle(
                        color: Colors.brown,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () => _controller.clear(),
                        icon: Icon(
                          Icons.close,
                          color: Colors.brown,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Container(
                width: 55,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (BuildContext context) {
                        double minRating = minRatingFilter;
                        int minComments = minCommentsFilter;

                        return StatefulBuilder(
                          builder: (BuildContext context, StateSetter setState) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.brown[50],
                              ),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Choose filters",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.brown[800],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  ListTile(
                                    leading: Icon(Icons.star, color: Colors.amber),
                                    title: Text("Minimum Rating: ${minRating.toStringAsFixed(1)}"),
                                    subtitle: Slider(
                                      min: 0,
                                      max: 5,
                                      divisions: 10,
                                      value: minRating,
                                      label: minRating.toStringAsFixed(1),
                                      onChanged: (value) {
                                        setState(() {
                                          minRating = value;
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.comment, color: Colors.brown),
                                    title: Text("Minimum Comments: "),
                                    trailing: DropdownButton<int>(
                                      value: minComments,
                                      onChanged: (int? newValue) {
                                        if (newValue != null) {
                                          setState(() {
                                            minComments = newValue;
                                          });
                                        }
                                      },
                                      items: [0, 5, 10, 20, 50, 100].map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value.toString()),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          minRatingFilter = 0.0;
                                          minCommentsFilter = 0;
                                          _controller.clear();
                                          _applyFilters();
                                        });
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.brown[300],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        "Reset filters",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          minRatingFilter = minRating;
                                          minCommentsFilter = minComments;
                                          _applyFilters();
                                        });
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.brown,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        "Apply filters",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              ]
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.brown[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.tune,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.brown))
                : filteredPlaces.isEmpty
                ? Center(child: Text('No places found', style: TextStyle(color: Colors.brown[800])))
                : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  for (var place in filteredPlaces) ...[
                    Row(
                      children: [
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            updateLastSeenPlace(
                              placeId: place.id,
                              name: place.name,
                              images: place.images,
                              address: place.address,
                              description: place.description,
                              phoneNumber: place.phoneNumber,
                              emailAddress: place.emailAddress,
                              avgRating: place.avgRating,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlacesPage(
                                  placeId: place.id,
                                  name: place.name,
                                  address: place.address,
                                  description: place.description,
                                  phoneNumber: place.phoneNumber,
                                  emailAddress: place.emailAddress,
                                  avgRating: place.avgRating,
                                  images: place.images,
                                  favorite: place.favorite,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 350,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.brown[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 15, left: 15),
                                            child: Text(
                                              place.name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                color: Colors.brown[800],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: Text(
                                              '${place.numberComments ?? 0} comments',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.brown[800],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 30),
                                          child: SizedBox(
                                            height: 20,
                                            width: 50,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.amber[50],
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 20,
                                                  ),
                                                  SizedBox(width: 5),
                                                  place.avgRating == 0
                                                      ? Text('─', style: TextStyle(color: Colors.brown))
                                                      : Text(
                                                    (place.avgRating as double).toStringAsFixed(1),
                                                    style: TextStyle(color: Colors.brown),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 10,
                                bottom: 10,
                                right: 10,
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.brown[300],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Image.network(
                                      place.images != null && place.images!.isNotEmpty
                                          ? place.images![0]
                                          : 'https://example.com/placeholder.jpg',
                                      fit: BoxFit.cover,
                                      width: 80,
                                      height: 80,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(
                                          Icons.broken_image,
                                          color: Colors.brown[800],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}