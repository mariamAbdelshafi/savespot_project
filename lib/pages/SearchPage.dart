import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:savespot_project/pages/Place.dart';

import 'PlacesPage.dart';


class SearchPage extends StatefulWidget{
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{
  final TextEditingController _controller = TextEditingController();
  List<Place> allPlaces = [];
  List<Place> filteredPlaces = [];

  Future<void> fetchPlacesFromFirebase() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('Places').get();
    List<Place> places = [];
    for (var doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final place = Place.fromMap(data, doc.id);
      places.add(place);
    }

    setState(() {
      allPlaces = places;
      filteredPlaces = places;
    });
  }


  @override
  void initState() {
    super.initState();
    fetchPlacesFromFirebase();
    _controller.addListener(() {
      filterPlaces();
    });
  }

  void filterPlaces() {
    final query = _controller.text.toLowerCase();
    setState(() {
      filteredPlaces = allPlaces.where((place) {
        return place.name.toLowerCase().contains(query) ||
            place.address.toLowerCase().contains(query) ||
            place.description.toLowerCase().contains(query) ||
            place.category.toLowerCase().contains(query);
      }).toList();
    });
  }


  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body:
      Column(
        children: [
          SizedBox(height: 80,),
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
                    TextField(
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
                          fontWeight: FontWeight.bold
                        ),
                        border: InputBorder.none,
                        suffixIcon: Transform.translate(
                            offset: Offset(30, 0),
                        child:
                        IconButton(
                            onPressed: (){
                              _controller.clear();
                            },
                            icon: Icon(Icons.clear,
                            color: Colors.brown,)
                        )
                        )
                      ),
                    )
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

      Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: 30),
              for (var place in filteredPlaces) ...[
                Row(
                  children: [
                    SizedBox(width: 20),
                    InkWell(
                      onTap: (){
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
                              avgRating: place.avgRating ?? 0.0,
                              images: place.images ?? ['assets/placeholder_image.jpg'],
                              favorite: place.favorite ?? false,
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
                                          place.name ?? 'Unknown',
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
                                              Text('${(place.avgRating)?.toDouble() ?? 0.0}'),
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
                    )
                  ],
                ),
                SizedBox(height: 20),
              ],
            ],
          ),
        ),
      )
        ],
      ),
    );
  }
}