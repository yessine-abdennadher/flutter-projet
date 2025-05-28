import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_library/models/categorie.dart';
import 'package:my_library/screens/quizz_screen.dart';
import 'package:my_library/services/api_service.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  final List<String> bookImages = [
    'assets/images/bg1.png',
    'assets/images/bg2.png',
  ];

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Categorie>> futureCategories;
  final TextEditingController _searchController = TextEditingController();
  List<Categorie> _allCategories = [];
  List<Categorie> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    futureCategories = ApiService.fetchCategories();

    // Charger les catégories
    futureCategories.then((categories) {
      setState(() {
        _allCategories = categories;
        _filteredCategories = categories;
      });
    });
  }

  void _filterCategories(String query) {
    final filtered = _allCategories.where((cat) {
      return cat.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredCategories = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 246, 246),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header avec message de bienvenue et champ de recherche
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hi, yessine!",
                    style: TextStyle(
                      color: Color.fromRGBO(50, 58, 71, 10),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Explore tons of images",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: _searchController,
                    onChanged: _filterCategories,
                    decoration: InputDecoration(
                      hintText: "Search...",
                      prefixIcon: const Icon(Icons.search, color: Colors.black26),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Section images horizontales
            Container(
              width: double.infinity,
              height: 216,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.bookImages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      width: 380,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: Card(
                        color: Colors.deepPurpleAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            widget.bookImages[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                "|  For You",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // Section catégories avec filtre
            Container(
              width: double.infinity,
              height: 320,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: FutureBuilder<List<Categorie>>(
                future: futureCategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Erreur : ${snapshot.error}",
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        "Aucune catégorie trouvée.",
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  } else {
                    // Initialiser les listes uniquement si elles sont encore vides
                    if (_allCategories.isEmpty) {
                      _allCategories = snapshot.data!;
                      _filteredCategories = snapshot.data!;
                    }

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filteredCategories.length,
                      itemBuilder: (context, index) {
                        final categorie = _filteredCategories[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    QuizzScreen(categories: categorie),
                              ),
                            );
                          },
                          child: Container(
                            width: 180,
                            height: 200,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    const BorderRadius.vertical(top: Radius.circular(15)),
                                    child: Image.asset(
                                      'assets/images/card-image.png',
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    child: Text(
                                      categorie.name,
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              )

            ),
          ],
        ),
      ),
    );
  }
}
