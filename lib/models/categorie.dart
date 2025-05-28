// models/quiz_category.dart
class Categorie {
  final int id;
  final String name;

  const Categorie({
    required this.id, // Non-nullable
    required this.name,
  });

  factory Categorie.fromJson(Map<String, dynamic> json) {
    return Categorie(
      id: json["id"] ?? 0,
      name: json["name"] ?? "Sans nom",
    );
  }
}