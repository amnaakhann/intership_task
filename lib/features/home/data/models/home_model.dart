import '../../domain/entities/home_entity.dart';

/// Home data model
class HomeModel extends HomeEntity {
  const HomeModel({
    required super.id,
    required super.title,
    required super.imageUrl,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        id: json['id'] as String,
        title: json['title'] as String,
        imageUrl: json['imageUrl'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'imageUrl': imageUrl,
      };
}
