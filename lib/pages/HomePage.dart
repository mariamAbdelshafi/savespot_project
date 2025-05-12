import 'package:flutter/material.dart';
import 'package:savespot_project/pages/BottomBar.dart';
import 'package:savespot_project/pages/ProfilePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:savespot_project/pages/PlacesPage.dart';
import 'package:savespot_project/pages/SearchPage.dart';
import 'package:savespot_project/pages/SearchResultPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<List<DocumentSnapshot>> placesFuture;

  Future<List<DocumentSnapshot>> fetchData({String? category}) async {
    QuerySnapshot snapshot = await _firestore.collection('Places').get();
    if(category != null){
      snapshot = await _firestore.collection('Places').where('category', isEqualTo: category).get();
    }

    return snapshot.docs;
  }

  @override
  void initState() {
    super.initState();
    placesFuture = fetchData();
  }

  void toggleFavorite(String placeId, bool currentFavorite) async {
    await _firestore.collection('Places').doc(placeId).update({
      'favorite': !currentFavorite,
    });
    setState(() {
      placesFuture = fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 100),
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              'Discover\nnew places!',
              style: TextStyle(
                color: Colors.brown[800],
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Row(
          children: [
            SizedBox(width: 35),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPage()),
                  );
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                child:
                Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.brown[800],
                    ),
                    SizedBox(width: 20,),
                    Text('Search',
                      style: TextStyle(
                          color: Colors.brown
                      ),)
                  ],
                ),

                )
            ),
            SizedBox(width: 15),
            Container(
              width: 55,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // open filters
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
        SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // go to restaurant category
                  Navigator.push(
                      context,
                    MaterialPageRoute(
                        builder: (context) => SearchResultpage(
                          category: 'Restaurants',
                        ),
                  )
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Restaurants',
                  style: TextStyle(color: Colors.brown[800]),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // go to accommodation category
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => SearchResultpage(
                        category: 'Accommodation',
                      ),
                  )
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Accommodation',
                  style: TextStyle(color: Colors.brown[800]),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // go to transportation category
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => SearchResultpage(
                        category: 'Transportation',
                      ),
                  )
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Transportation',
                  style: TextStyle(color: Colors.brown[800]),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // go to events category
                  //updateCategory('Events');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchResultpage(
                          category: 'Events',
                        ),
                      )
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Events',
                  style: TextStyle(color: Colors.brown[800]),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // go to shopping category
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchResultpage(
                          category: 'Shopping',
                        ),
                      )
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Shopping',
                  style: TextStyle(color: Colors.brown[800]),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // go to fitness category
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchResultpage(
                          category: 'Fitness',
                        ),
                      )
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Fitness',
                  style: TextStyle(color: Colors.brown[800]),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // go to studies category
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchResultpage(
                          category: 'Studies',
                        ),
                      )
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Studies',
                  style: TextStyle(color: Colors.brown[800]),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
        SizedBox(height: 30),
        SizedBox(
          height: 200,
          child: FutureBuilder<List<DocumentSnapshot>>(
            future: placesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data found'));
              }

              final places = snapshot.data!;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: places.asMap().entries.map((entry) {
                    int index = entry.key;
                    var place = entry.value;
                    String name = place['name'] ?? 'Unknown';
                    String address = place['address'] ?? 'Unknown';
                    String description = place['description'] ?? 'Unknown';
                    String phoneNumber = place['phoneNumber'] ?? 'Unknown';
                    String emailAddress = place['email'] ?? 'Unknown';
                    double avgRating = (place['point'] as num?)?.toDouble() ?? 0.0;
                    bool favorite = place['favorite'] ?? false;
                    List<String> images = [];
                    if (place.data() != null &&
                        (place.data() as Map<String, dynamic>).containsKey('images') &&
                        (place.data() as Map<String, dynamic>)['images'] is List) {
                      images = (place['images'] as List)
                          .map((item) => item.toString())
                          .where((item) => item.isNotEmpty)
                          .toList();
                    }
                    if (images.isEmpty) {
                      images = ['assets/placeholder_image.jpg'];
                    }

                    return Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlacesPage(
                                placeId: place.id,
                                name: name,
                                address: address,
                                description: description,
                                phoneNumber: phoneNumber,
                                emailAddress: emailAddress,
                                avgRating: avgRating,
                                images: images,
                                favorite: favorite,
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: images.isNotEmpty
                                  ? NetworkImage(images[0])
                                  : AssetImage('assets/placeholder_image.jpg') as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: FilledButton(
                                    onPressed: () async {
                                      toggleFavorite(
                                        place.id,
                                        place['favorite'] ?? false,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(30, 30),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    child: Icon(
                                      (place['favorite'] ?? false)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 30),
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              'Last seen',
              style: TextStyle(
                color: Colors.brown,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 20),
              Container(
                width: 200,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 200,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 200,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 200,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 200,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}