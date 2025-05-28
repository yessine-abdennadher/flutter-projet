import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_library/models/categorie.dart'; // Correction : utiliser la bonne classe

class ApiService {
  static const String apiUrl = "https://opentdb.com/api_category.php";

  static Future<List<Categorie>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Décodage du JSON
        if (data["trivia_categories"] != null) {
          return (data["trivia_categories"] as List)
              .map((json) => Categorie.fromJson(json)) // Conversion en objets `Categorie`
              .toList();
        } else {
          throw Exception("Aucune catégorie trouvée");
        }
      } else {
        throw Exception("Erreur de chargement des catégories");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }
}
