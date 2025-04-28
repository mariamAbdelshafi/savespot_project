import 'package:savespot_project/User.dart';
import 'package:savespot_project/base_class.dart';
import 'package:savespot_project/entity.dart';

class Comment extends BaseClass{
  String? message;
  User? user; // hangi usera ait comment
  Entity? entity; // transportaiona mı accomodationa mı yazılmış görebilmek için
}