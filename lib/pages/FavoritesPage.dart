import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:savespot_project/pages/PlacesPage.dart';

class FavoritesPage extends StatefulWidget {
  //const FavoritesPage({super.key});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchPlaces() async {
    QuerySnapshot snapshot = await _firestore.collection('Places').where('favorite', isEqualTo: true).get();
    return snapshot.docs.map((doc) => {
      ...doc.data() as Map<String, dynamic>,
      'id': doc.id,
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: Column(
        children: [
          SizedBox(height: 80,),
          Align(
            alignment: Alignment.topLeft,
            child:
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('My Favorites',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.brown[800],
                ),),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchPlaces(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No favorites yet');
                }

                final places = snapshot.data!;

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      for (var place in places) ...[
                        Row(
                          children: [
                            SizedBox(width: 20),
                            InkWell(
                                onTap: (){
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
                                },
                              child:
                              Stack(
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
                                                      Text('${(place['point'])?.toDouble() ?? 0.0}'),
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