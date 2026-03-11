import '../entities/home_entity.dart';

abstract class HomeRepository {
  Future<List<HomeEntity>> fetchItems();
  Stream<List<HomeEntity>> streamItems();
  Future<void> addItem(HomeEntity item);
}
