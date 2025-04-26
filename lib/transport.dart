import 'package:savespot_project/comment.dart';
import 'package:savespot_project/picture.dart';
import 'package:savespot_project/enums/vehicle_enum.dart';

class Transport{
  EVehicle? vehicleType;
  int? price;
  String? description;

  List<Picture>? pictureList; 
  List<Comment>? commentList;

}