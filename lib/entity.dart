import 'package:savespot_project/base_class.dart';
import 'package:savespot_project/comment.dart';
import 'package:savespot_project/picture.dart';

class Entity extends BaseClass{
  //favorilerde object demek yerine entity deriz
  //TODO(ebru) entity yerine baska isim

  int? price;
  String? description;

  List<Picture>? pictureList; 
  List<Comment>? commentList;
}