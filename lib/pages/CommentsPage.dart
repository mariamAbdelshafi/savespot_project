import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:savespot_project/pages/PlacesPage.dart';

class CommentsPage extends StatefulWidget{
  final String placeId;
  CommentsPage({super.key, required this.placeId}) {
    print("PlaceId reçu: $placeId"); // Debug
  }

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage>{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  double rating = 0;
  final TextEditingController _commentController = TextEditingController();

  String _formatDate(Timestamp timestamp) {
    return DateFormat('MM-dd-yyyy HH:mm',).format(timestamp.toDate());
  }

  Widget _buildCommentItem(Map<String, dynamic> data, String commentId) {
    final likes = data['likes'] ?? 0;
    final likedBy = List<String>.from(data['likedBy'] ?? []);
    final currentUserId = _auth.currentUser?.uid ?? '';
    bool isLiked = likedBy.contains(currentUserId);

    return Center(
      child: Container(
        width: 370,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.brown[100],
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 10),
                Text(
                  data['userEmail'] ?? 'Anonymous',
                  style: TextStyle(color: Colors.brown, fontSize: 16),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.amber[50],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 5),
                      Text(data['rating'].toStringAsFixed(1)),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 10),
                Text(
                  _formatDate(data['createdAt']),
                  style: TextStyle(color: Colors.brown),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    data['content'],
                    style: TextStyle(color: Colors.brown, fontSize: 17),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => _toggleLike(commentId, isLiked, likes, likedBy),
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    size: 20,
                    color: isLiked ? Colors.red : Colors.brown,
                  ),
                ),
                Text('$likes', style: TextStyle(color: Colors.brown)),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text('Reply', style: TextStyle(color: Colors.brown[800])),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleLike(String commentId, bool isCurrentlyLiked, int currentLikes, List<String> likedBy) async {
    final currentUserId = _auth.currentUser?.uid;
    if (currentUserId == null) return;

    try {
      await _firestore.collection('comments').doc(commentId).update({
        'likes': isCurrentlyLiked ? currentLikes - 1 : currentLikes + 1,
        'likedBy': isCurrentlyLiked
            ? FieldValue.arrayRemove([currentUserId])
            : FieldValue.arrayUnion([currentUserId]),
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}')),
      );
    }
  }

  Future<void> _sendComment() async {
    final commentText = _commentController.text.trim();

    if (commentText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez écrire un commentaire valide')),
      );
      return;
    }

    if (rating < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez attribuer une note (1 à 5 étoiles)')),
      );
      return;
    }

    try {
      // Ajoute un indicateur de chargement
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Envoi en cours...'), duration: Duration(seconds: 1)),
      );

      await _firestore.collection('comments').add({
        'placeId': widget.placeId,
        'userId': _auth.currentUser!.uid,
        'userEmail': _auth.currentUser!.email ?? 'Anonyme',
        'content': commentText,
        'rating': rating,
        'createdAt': FieldValue.serverTimestamp(),
        'likes': 0,
        'likedBy': [], // Initialise la liste des likes
      });

      // Rafraîchit manuellement l'état
      setState(() {
        _commentController.clear();
        rating = 0;
      });

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}')),
      );
    }
  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body:
      Column(
        children: [
          SizedBox(height: 50,),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                    Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, size: 35, color: Colors.brown),
              ),
              Text('Comments',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.brown
              ),),
            ],
          ),
          SizedBox(height: 20,),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('comments')
                  .where('placeId', isEqualTo: widget.placeId)
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.brown));
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No comments yet", style: TextStyle(color: Colors.brown)));
                }

                // Crée une liste stable des documents
                final comments = snapshot.data!.docs;

                return ListView.builder(
                  padding: EdgeInsets.only(bottom: 20),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final data = comments[index].data() as Map<String, dynamic>;
                    return _buildCommentItem(data, comments[index].id);
                  },
                );
              },
            ),
          ),
          Spacer(),
          Container(
            width: 350,
            decoration: BoxDecoration(
              color: Colors.brown[100],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.brown,
                width: 2.0,
              ),
            ),
            child:
            Column(
              children: [
                SizedBox(height: 7,),
                Row(
                  children: [
                    SizedBox(width: 10,),
                    RatingBar.builder(
                      itemSize: 25,
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        if (rating >= index + 1) {
                          return Icon(Icons.star, color: Colors.brown);
                        } else if (rating > index) {
                          return Icon(Icons.star_half, color: Colors.brown);
                        } else {
                          return Icon(Icons.star_border, color: Colors.brown);
                        }
                      },
                      onRatingUpdate: (newRating) {
                        setState(() => rating = newRating);
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _commentController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Add a comment',
                          hintStyle: TextStyle(
                            color: Colors.brown
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 15),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _sendComment, // Appelle la méthode d'envoi
                      icon: Icon(Icons.send, color: Colors.brown),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}