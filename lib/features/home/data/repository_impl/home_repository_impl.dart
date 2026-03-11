import '../../domain/entities/home_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remote;

  HomeRepositoryImpl(this.remote);

  @override
  Future<List<HomeEntity>> fetchItems() => remote.fetchItems();

  @override
  Stream<List<HomeEntity>> streamItems() => remote.streamItems();

  @override
  Future<void> addItem(HomeEntity item) => remote.addItem(item);
}
