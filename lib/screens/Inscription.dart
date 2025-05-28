import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Méthode pour l'inscription
  void _signUp() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Les mots de passe ne correspondent pas.')),
      );
      return;
    }

    try {
      // Création d'un utilisateur avec Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        // L'utilisateur a été créé avec succès
        print("✅ Inscription réussie : ${user.email}");

        // Ajouter une logique supplémentaire ici, comme l'enregistrement du nom dans la base de données Firestore
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inscription réussie!')),
        );

        // Rediriger vers la page de bienvenue ou la page de connexion
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        print("❌ Erreur lors de la création de l'utilisateur");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Échec de l\'inscription, veuillez réessayer.')),
        );
      }
    } catch (e) {
      print("Erreur lors de l'inscription: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur de connexion, veuillez réessayer.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Fond avec image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg9.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Conteneur blanc en bas
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 700,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Titre "Create an Account"
                  const Text(
                    "Create an Account",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Champ Nom
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "Full Name",
                      prefixIcon: const Icon(Icons.person, color: Colors.purple),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Champ Email
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "Email",
                      prefixIcon: const Icon(Icons.email, color: Colors.purple),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Champ Mot de passe
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.lock, color: Colors.purple),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Champ Confirmation Mot de passe
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "Confirm Password",
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.purple),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Bouton d'inscription
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _signUp, // Appel de la méthode d'inscription
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Lien pour se connecter
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');  // Redirection vers la page de connexion
                    },
                    child: const Text(
                      "Already have an account? Sign in",
                      style: TextStyle(color: Colors.purple, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
