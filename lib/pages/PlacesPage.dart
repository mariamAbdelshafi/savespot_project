import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:savespot_project/pages/CommentsPage.dart';

class PlacesPage extends StatefulWidget {
  final String placeId;
  final String name;
  final String address;
  final String description;
  final String phoneNumber;
  final String emailAddress;
  final double avgRating;
  final List<String> images;
  final bool favorite;
  final VoidCallback? onFavoriteChanged;

  const PlacesPage({
    super.key,
    required this.placeId,
    required this.name,
    required this.address,
    required this.description,
    required this.phoneNumber,
    required this.emailAddress,
    required this.avgRating,
    required this.images,
    required this.favorite,
    this.onFavoriteChanged,
  });

  @override
  State<PlacesPage> createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  int currentImageIndex = 0;
  bool isFavorite = false;
  double _currentAvgRating = 0.0;
  bool _isLoadingRating = true;

  Future<void> _loadAverageRating() async {
    try {
      setState(() => _isLoadingRating = true);

      final commentsSnapshot = await FirebaseFirestore.instance
          .collection('comments')
          .where('placeId', isEqualTo: widget.placeId)
          .get();

      if (commentsSnapshot.docs.isEmpty) {
        setState(() => _currentAvgRating = 0.0);
        return;
      }

      double total = 0.0;
      for (final doc in commentsSnapshot.docs) {
        total += (doc.data()['rating'] as num).toDouble();
      }

      setState(() {
        _currentAvgRating = total / commentsSnapshot.docs.length;
        _isLoadingRating = false;
      });
    } catch (e) {
      setState(() => _isLoadingRating = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
    _loadAverageRating();
  }

  void _loadFavoriteStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(widget.placeId)
        .get();

    setState(() {
      isFavorite = doc.exists;
    });
  }


  void _toggleFavorite() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final favRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(widget.placeId);

    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      await favRef.set({
        'placeId': widget.placeId,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } else {
      await favRef.delete();
    }
    widget.onFavoriteChanged?.call();
  }




  void nextImage() {
    setState(() {
      currentImageIndex = (currentImageIndex + 1) % widget.images.length;
    });
  }

  void previousImage() {
    setState(() {
      currentImageIndex = (currentImageIndex - 1 + widget.images.length) % widget.images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            SizedBox(
              height: 350,
              width: 350,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Image.network(
                        widget.images[currentImageIndex],
                        fit: BoxFit.cover,
                        width: 350,
                        height: 350,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/placeholder_image.jpg', fit: BoxFit.cover);
                        },
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 10,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: previousImage,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                        onPressed: nextImage,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FilledButton(
                          onPressed: _toggleFavorite,
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(30, 30),
                            backgroundColor: Colors.transparent,
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
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
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 30),
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
                Spacer(),
                SizedBox(
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
                        _isLoadingRating
                            ? Text("─", style: TextStyle(color: Colors.brown),)
                            : Text(
                          _currentAvgRating.toStringAsFixed(1),
                          style: TextStyle(color: Colors.brown),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 35),
                Icon(
                  Icons.place,
                  size: 20,
                  color: Colors.brown,
                ),
                Text(widget.address),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 30),
                Text(
                  'Description',
                  style: TextStyle(
                    color: Colors.brown[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 330,
              height: 70,
              child: Text(widget.description),
            ),
            //SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 30),
                Text(
                  'Contact',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                SizedBox(width: 30),
                Icon(
                  Icons.phone,
                  color: Colors.brown,
                ),
                SizedBox(width: 15),
                Text(widget.phoneNumber),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 30),
                Icon(
                  Icons.email,
                  color: Colors.brown,
                ),
                SizedBox(width: 15),
                Text(widget.emailAddress),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: Text(
                    'Go back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    final shouldRefresh = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentsPage(placeId: widget.placeId),
                      ),
                    );

                    if (shouldRefresh == true) {
                      _loadAverageRating();
                    }
                  },
                  child: Text(
                    'See comments',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}