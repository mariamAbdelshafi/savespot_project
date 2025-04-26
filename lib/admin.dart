import 'package:savespot_project/base_interface.dart';
import 'package:savespot_project/user.dart';

class Admin extends User implements BaseInterface{
  @override
  add(entity) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  void delete(entity) {
    // TODO: implement delete - databaseden entity silinecek
  }

  @override
  void update(entity) {
    // TODO: implement update - db den data cekilir ve updatelenip geri gönderilir(ama bu iyi yol değil)?? sanki track sorunu oluyor
  }
// TODO(ebru) food-drink, transport... etc add, delete, update yapabilir interface ile 


}