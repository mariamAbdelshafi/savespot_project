import 'package:savespot_project/base_class.dart';
import 'package:savespot_project/gender_enum.dart';

class User extends BaseClass{
  String? firstName;
  String? lastName;
  String? password;
  EGender? gender;
  
  List<Object>? favorites;
  // TODO(ebru) object için başka bişi olabilir gibi
  //favorilerden restorantları getir veya transportları getir favori classa sanırım gerek yok

}