import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentItem extends StatefulWidget {
  final Map<String, dynamic> data;
  final String commentId;
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const CommentItem({
    Key? key,
    required this.data,
    required this.commentId,
    required this.auth,
    required this.firestore,
  }) : super(key: key);

  @override
  CommentItemState createState() => CommentItemState();
}

class CommentItemState extends State<CommentItem> {
  late bool isLiked;
  late int likes;
  late List<String> likedBy;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    likes = widget.data['likes'] ?? 0;
    likedBy = List<String>.from(widget.data['likedBy'] ?? []);
    isLiked = likedBy.contains(widget.auth.currentUser?.uid ?? '');
  }

  Future<void> _toggleLike() async {
    final currentUserId = widget.auth.currentUser?.uid;
    if (currentUserId == null) return;

    final oldLikes = likes;
    final oldLikedBy = List<String>.from(likedBy);
    final oldIsLiked = isLiked;

    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        likes++;
        likedBy.add(currentUserId);
      } else {
        likes--;
        likedBy.remove(currentUserId);
      }
    });

    try {
      await widget.firestore.collection('comments').doc(widget.commentId).update({
        'likes': isLiked ? FieldValue.increment(1) : FieldValue.increment(-1),
        'likedBy': isLiked
            ? FieldValue.arrayUnion([currentUserId])
            : FieldValue.arrayRemove([currentUserId]),
      });
    } catch (e) {
      setState(() {
        isLiked = oldIsLiked;
        likes = oldLikes;
        likedBy = oldLikedBy;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update like: ${e.toString()}')),
      );
    }
  }

  String _formatDate(Timestamp? timestamp) {
    if (timestamp == null) return 'unknown date';
    return DateFormat('MM-dd-yyyy HH:mm').format(timestamp.toDate());
  }

  @override
  Widget build(BuildContext context) {
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
                  widget.data['userEmail'] ?? 'Anonymous',
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
                      Text(widget.data['rating']?.toStringAsFixed(1) ?? '0.0'),
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
                  _formatDate(widget.data['createdAt'] as Timestamp?),
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
                    widget.data['content'] ?? '',
                    style: TextStyle(color: Colors.brown, fontSize: 17),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _toggleLike,
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    size: 20,
                    color: isLiked ? Colors.red : Colors.brown,
                  ),
                ),
                Text('$likes', style: TextStyle(color: Colors.brown)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}