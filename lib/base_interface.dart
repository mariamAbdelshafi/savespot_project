abstract class BaseInterface<T> {
  T add(T entity);
  void update(T entity);
  void delete(T entity);

  //List<T> getAll();
  //TODO(ebru) filtre ile getirme nasıl yapılır arastır
  // TODO(ebru) admin add delete yapabilir ayrıca diğer userlar yorum ekleme silme de bu interface ile yapabilir pp ekleme de
}