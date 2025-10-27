import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class MyCommentsPage extends StatefulWidget{
  final String? placeId;
  MyCommentsPage({super.key, this.placeId}) {}

  @override
  State<MyCommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<MyCommentsPage>{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  double rating = 0;
  final TextEditingController _commentController = TextEditingController();

  String _formatDate(Timestamp timestamp) {
    return DateFormat('MM-dd-yyyy HH:mm',).format(timestamp.toDate());
  }

  Future<void> _deleteComment(String commentId) async {
    try {
      await _firestore.collection('comments').doc(commentId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comment deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting comment: ${e.toString()}')),
      );
    }
  }

  void _showDeleteDialog(String commentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Comment"),
          content: Text("Are you sure you want to delete this comment?"),
          backgroundColor: Colors.brown[50],
          actions: [
            TextButton(
              child: Text("Cancel", style: TextStyle(color: Colors.brown[800]),),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () {
                _deleteComment(commentId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCommentItem(Map<String, dynamic> data, String commentId) {
    final likes = data['likes'] ?? 0;
    final likedBy = List<String>.from(data['likedBy'] ?? []);
    final currentUserId = _auth.currentUser?.uid ?? '';
    bool isLiked = likedBy.contains(currentUserId);

    return FutureBuilder<DocumentSnapshot>(
        future: _firestore.collection('Places').doc(data['placeId']).get(),
        builder: (context, snapshot) {
          final placeName = snapshot.hasData ? snapshot.data!['name'] ??
              'Unknown Place' : 'Loading...';

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
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text(placeName, style: TextStyle(color: Colors.brown),),
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
                        onPressed: () =>
                            _toggleLike(commentId, isLiked, likes, likedBy),
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                          color: isLiked ? Colors.red : Colors.brown,
                        ),
                      ),
                      Text('$likes', style: TextStyle(color: Colors.brown)),
                      Spacer(),
                      TextButton(
                        onPressed: () => _showDeleteDialog(commentId),
                        child: Text('Delete', style: TextStyle(color: Colors.brown[800])),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }
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
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
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
              IconButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, size: 35, color: Colors.brown),
              ),
              Text('My Comments',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800]
                ),),
            ],
          ),
          SizedBox(height: 20,),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('comments')
                  .where('userId', isEqualTo: _auth.currentUser?.uid)
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
        ],
      ),
    );
  }
}