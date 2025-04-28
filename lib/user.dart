import 'package:savespot_project/base_class.dart';
import 'package:savespot_project/comment.dart';
import 'package:savespot_project/enums/gender_enum.dart';
import 'package:savespot_project/picture.dart';

class User extends BaseClass{
  String? firstName;
  String? lastName;
  String? userName;
  String? password;
  String? phoneNumber;
  String? email;
  DateTime? dateOfBirth;
  EGender? gender;
  Picture? picture; // profil photo
 




  List<Comment>? commentList;
  List<Object>? favoriteList;
  // TODO(ebru) object için başka bişi olabilir gibi
  //favorilerden restorantları getir veya transportları getir favori classa sanırım gerek yok

}