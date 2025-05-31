import 'package:flutter/material.dart';
import 'package:savespot_project/pages/BottomBar.dart';
import 'package:savespot_project/pages/ProfilePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:savespot_project/pages/PlacesPage.dart';
import 'package:savespot_project/pages/SearchPage.dart';
import 'package:savespot_project/pages/SearchResultPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  final Function(int)? onChangePage;
  const HomePage({Key? key, this.onChangePage}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<List<DocumentSnapshot>> placesFuture;
  late Set<String> favoritePlaceIds = {};
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  bool isFavorite = false;
  List<Map<String, dynamic>> lastSeenPlaces = [];


  Future<List<DocumentSnapshot>> fetchData({String? category}) async {
    QuerySnapshot snapshot = await _firestore.collection('Places').get();
    if(category != null){
      snapshot = await _firestore.collection('Places').where('category', isEqualTo: category).get();
    }

    return snapshot.docs;
  }

  Future<void> loadUserFavorites() async {
    if (userId == null) return;
    final favSnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();

    setState(() {
      favoritePlaceIds = favSnapshot.docs.map((doc) => doc.id).toSet();
    });
  }

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

  Future<void> _cleanInvalidEntries() async {
    if (userId == null) return;

    final userRef = _firestore.collection('users').doc(userId!);
    final doc = await userRef.get();

    if (doc.exists) {
      final data = doc.data() ?? {};
      final lastSeen = List.from(data['lastSeen'] ?? []);

      final cleanedList = lastSeen.where((item) {
        final map = Map<String, dynamic>.from(item);
        return map['name'] != null && map['name'] != 'Unknown';
      }).toList();

      if (cleanedList.length != lastSeen.length) {
        await userRef.update({'lastSeen': cleanedList});
      }
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
          SnackBar(content: Text("refresh error")),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    placesFuture = fetchData();
    loadUserFavorites();
    _cleanInvalidEntries();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadLastSeenPlaces();
    });
  }

  Future<bool> toggleFavorite(String placeId) async {
    if (userId == null) return false;

    final favRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(placeId);

    if (favoritePlaceIds.contains(placeId)) {
      await favRef.delete();
      setState(() {
        favoritePlaceIds.remove(placeId);
      });
      return false;
    } else {
      await favRef.set({
        'placeId': placeId,
      });
      setState(() {
        favoritePlaceIds.add(placeId);
      });
      return true;
    }
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
                  if (widget.onChangePage != null) {
                    widget.onChangePage!(2);
                  }
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
                  children: [ ...places.asMap().entries.map((entry) {
                    int index = entry.key;
                    var place = entry.value;
                    String name = place['name'] ?? 'Unknown';
                    String address = place['address'] ?? 'Unknown';
                    String description = place['description'] ?? 'Unknown';
                    String phoneNumber = place['phoneNumber'] ?? 'Unknown';
                    String emailAddress = place['email'] ?? 'Unknown';
                    double avgRating = (place['point'] as num?)?.toDouble() ?? 0.0;
                    bool favorite = favoritePlaceIds.contains(place.id);
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
                        onTap: () async{
                            updateLastSeenPlace(
                            placeId: place.id,
                            name: name,
                            images: images,
                            address: address,
                            description: description,
                            phoneNumber: phoneNumber,
                            emailAddress: emailAddress,
                            avgRating: avgRating,
                          );
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
                                  onFavoriteChanged: () async {
                                    await loadUserFavorites();
                                    setState(() {});
                                  }
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
                                      final placeId = place.id;
                                      final updatedStatus = await toggleFavorite(placeId);
                                      setState(() {
                                        isFavorite = updatedStatus;
                                      });

                                      setState(() {});
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(30, 30),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    child: Icon(
                                      favoritePlaceIds.contains(place.id)
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
                    SizedBox(width: 20,)
                ]
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
            children: [ ...lastSeenPlaces.map((place) {
              final placeId = place['id'] ?? '';
              final name = place['name'] ?? 'Unknown';
              final images = (place['images'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
                  [];
              final address = place['address'] ?? '';
              final description = place['description'] ?? '';
              final phoneNumber = place['phoneNumber'] ?? '';
              final emailAddress = place['emailAddress'] ?? '';
              final avgRating = (place['avgRating'] as num?)?.toDouble() ?? 0.0;
              final favorite = favoritePlaceIds.contains(placeId);

              return Padding(
                padding: EdgeInsets.only(left: 20),
                child: InkWell(
                  onTap: () async {
                    await updateLastSeenPlace(
                      placeId: placeId,
                      name: name,
                      images: images,
                      address: address,
                      description: description,
                      phoneNumber: phoneNumber,
                      emailAddress: emailAddress,
                      avgRating: avgRating,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlacesPage(
                          placeId: placeId,
                          name: name,
                          address: address,
                          description: description,
                          phoneNumber: phoneNumber,
                          emailAddress: emailAddress,
                          avgRating: avgRating,
                          images: images,
                          favorite: favorite,
                          onFavoriteChanged: () async {
                            await loadUserFavorites();
                            setState(() {});
                          },
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 200,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.brown[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.brown[200],
                                borderRadius: BorderRadius.circular(20),
                                image: images.isNotEmpty
                                    ? DecorationImage(
                                  image: NetworkImage(images[0]),
                                  fit: BoxFit.cover,
                                )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            name,
                            style: TextStyle(
                              color: Colors.brown,
                              fontSize: 18,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
              SizedBox(width: 10,)
            ]
          ),
        )
        ,
      ],
    );
  }
}