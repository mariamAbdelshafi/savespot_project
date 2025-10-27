import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:savespot_project/pages/PlacesPage.dart';

class SearchResultpage extends StatefulWidget {
  final String category;

  const SearchResultpage({
    super.key,
    required this.category
  });

  get placeId => null;

  @override
  State<SearchResultpage> createState() => _SearchResultpageState();
}

class _SearchResultpageState extends State<SearchResultpage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Set<String> favoritePlaceIds = {};
  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  Stream<List<Map<String, dynamic>>> getLastSeenStream() {
    if (userId == null) return Stream.value([]);

    return _firestore.collection('users').doc(userId!).snapshots().map((snapshot) {
      final data = snapshot.data() ?? {};
      final rawList = data['lastSeen'] as List? ?? [];

      return rawList
          .map((item) => Map<String, dynamic>.from(item))
          .where((place) => place['name'] != null && place['name'] != 'Unknown')
          .toList();
    });
  }

  Future<bool> updateLastSeenPlace({
    required String placeId,
    required String name,
    required List<String> images,
    required String address,
    required String description,
    required String phoneNumber,
    required String emailAddress,
    required double avgRating,
  }) async {
    if (userId == null || !mounted) return false;

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
      return true;
    } catch (e) {
      print('Error in transaction for place $placeId: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error updating last seen")),
        );
      }
      return false;
    }
  }

  Stream<List<Map<String, dynamic>>> getPlacesStream() {
    Query query = _firestore.collection('Places');
    if (widget.category.isNotEmpty) {
      query = query.where('category', isEqualTo: widget.category);
    }

    return query.snapshots().asyncMap((snapshot) async {
      final places = <Map<String, dynamic>>[];

      for (final doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final placeId = doc.id;

        final commentsSnapshot = await _firestore
            .collection('comments')
            .where('placeId', isEqualTo: placeId)
            .get();

        double avgRating = 0.0;
        if (commentsSnapshot.docs.isNotEmpty) {
          final total = commentsSnapshot.docs.fold(0.0, (sum, doc) => sum + (doc.data()['rating'] as num).toDouble());
          avgRating = total / commentsSnapshot.docs.length;
        }

        places.add({
          ...data,
          'id': placeId,
          'point': avgRating,
          'numberComments': commentsSnapshot.docs.length,
        });
      }

      return places;
    });
  }

  @override
  void initState() {
    super.initState();
    getLastSeenStream().listen((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: Column(
        children: [
          Center(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: getPlacesStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(height: 40),
                      Row(
                        children: [
                          Spacer(),
                          IconButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close,
                                  color: Colors.brown[800],
                                  size: 30)),
                          SizedBox(width: 20)
                        ],
                      ),
                      SizedBox(height: 150),
                      Text('No places found'),
                    ],
                  );
                }

                final places = snapshot.data!;

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Spacer(),
                          IconButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close,
                                  color: Colors.brown[800],
                                  size: 30)),
                          SizedBox(width: 20)
                        ],
                      ),
                      SizedBox(height: 10),

                      for (var place in places) ...[
                        Row(
                          children: [
                            SizedBox(width: 20),
                            InkWell(
                              onTap: () async {
                                final success = await updateLastSeenPlace(
                                  placeId: place['id'],
                                  name: place['name'] ?? 'Unknown',
                                  images: (place['images'] as List?)?.cast<String>() ?? ['assets/placeholder_image.jpg'],
                                  address: place['address'] ?? 'Unknown',
                                  description: place['description'] ?? 'Unknown',
                                  phoneNumber: place['phoneNumber'] ?? 'Unknown',
                                  emailAddress: place['email'] ?? 'Unknown',
                                  avgRating: (place['point'] as num?)?.toDouble() ?? 0.0,
                                );

                                if (success && mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlacesPage(
                                        placeId: place['id'],
                                        name: place['name'] ?? 'Unknown',
                                        address: place['address'] ?? 'Unknown',
                                        description: place['description'] ?? 'Unknown',
                                        phoneNumber: place['phoneNumber'] ?? 'Unknown',
                                        emailAddress: place['email'] ?? 'Unknown',
                                        avgRating: (place['point'] as num?)?.toDouble() ?? 0.0,
                                        images: (place['images'] as List?)?.cast<String>() ?? ['assets/placeholder_image.jpg'],
                                        favorite: place['favorite'] ?? false,
                                      ),
                                    ),
                                  );
                                }
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
                                                padding: EdgeInsets.only(
                                                  top: 15,
                                                  left: 15,
                                                ),
                                                child: Text(
                                                  place['name'] ?? 'Unknown',
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
                                                  '${place['numberComments'] ?? 0} comments',
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
                                                      place['point'] == 0
                                                          ? Text('─', style: TextStyle(color: Colors.brown))
                                                          : Text(
                                                        (place['point'] as double).toStringAsFixed(1),
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
                                          place['images'] != null && place['images'].isNotEmpty
                                              ? place['images'][0]
                                              : '',
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
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}