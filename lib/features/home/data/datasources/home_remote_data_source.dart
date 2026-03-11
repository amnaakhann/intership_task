import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/home_entity.dart';
import 'package:task/core/services/firestore_service.dart';

class HomeRemoteDataSource {
  final FirestoreService firestoreService;

  HomeRemoteDataSource(this.firestoreService);

  Future<List<HomeEntity>> fetchItems() async {
    final snapshot = await firestoreService.getDocument('home', 'items');
    // Minimal implementation - expects a map with 'items'
    if (!snapshot.exists) return [];
    final data = snapshot.data() as Map<String, dynamic>?;
    final items = <HomeEntity>[];
    if (data != null && data['items'] is List) {
      for (final e in data['items']) {
        items.add(HomeEntity.fromMap(Map<String, dynamic>.from(e)));
      }
    }
    return items;
  }

  Stream<List<HomeEntity>> streamItems() {
    return firestoreService.streamCollection('home').map((snapshot) {
      return snapshot.docs.map((d) {
        return HomeEntity.fromMap(d.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> addItem(HomeEntity item) async {
    await firestoreService.addDocument('home', item.toMap());
  }
}
