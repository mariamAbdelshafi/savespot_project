import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:savespot_project/pages/CommentItem.dart';

class CommentsPage extends StatefulWidget {
  final String placeId;
  const CommentsPage({Key? key, required this.placeId}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _commentController = TextEditingController();
  double _rating = 0;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _sendComment() async {
    final commentText = _commentController.text.trim();
    if (commentText.isEmpty) return;

    try {
      await _firestore.collection('comments').add({
        'placeId': widget.placeId,
        'userId': _auth.currentUser!.uid,
        'userEmail': _auth.currentUser!.email ?? 'Anonymous',
        'content': commentText,
        'rating': _rating,
        'createdAt': FieldValue.serverTimestamp(),
        'likes': 0,
        'likedBy': [],
      });

      _commentController.clear();
      setState(() => _rating = 0);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, size: 35, color: Colors.brown),
                onPressed: () => Navigator.pop(context),
              ),
              Text('Comments',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('comments')
                  .where('placeId', isEqualTo: widget.placeId)
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Colors.brown));
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No comments yet", style: TextStyle(color: Colors.brown)));
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final doc = snapshot.data!.docs[index];
                    return CommentItem(
                      key: ValueKey(doc.id),
                      data: doc.data() as Map<String, dynamic>,
                      commentId: doc.id,
                      auth: _auth,
                      firestore: _firestore,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.brown[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.brown, width: 2.0),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 7),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        RatingBar.builder(
                          itemSize: 25,
                          initialRating: _rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            if (_rating >= index + 1) {
                              return Icon(Icons.star, color: Colors.brown);
                            } else if (_rating > index) {
                              return Icon(Icons.star_half, color: Colors.brown);
                            } else {
                              return Icon(Icons.star_border, color: Colors.brown);
                            }
                          },
                          onRatingUpdate: (rating) => setState(() => _rating = rating),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextField(
                            controller: _commentController,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: 'Add a comment',
                              hintStyle: TextStyle(color: Colors.brown),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.brown),
                        onPressed: _sendComment,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}