/// Home entity
class HomeEntity {
  final String id;
  final String title;
  final String imageUrl;

  const HomeEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
    };
  }

  factory HomeEntity.fromMap(Map<String, dynamic> map) {
    return HomeEntity(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
