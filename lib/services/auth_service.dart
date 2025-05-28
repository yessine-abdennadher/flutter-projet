import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔹 Connexion avec email et mot de passe
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user; // Si la connexion réussit, on retourne l'utilisateur
    } on FirebaseAuthException catch (e) {
      print("Erreur Firebase: ${e.code}");

      // Gestion spécifique des erreurs Firebase
      if (e.code == 'user-not-found') {
        print("Aucun utilisateur trouvé pour cet email.");
      } else if (e.code == 'wrong-password') {
        print("Mot de passe incorrect.");
      } else {
        print("Erreur inconnue: ${e.message}");
      }

      return null; // Si la connexion échoue, on retourne null
    }
  }

  // 🔹 Inscription avec email & mot de passe
  Future<User?> signUp(String email, String password) async {
    try {
      // Vérifier si l'email est déjà utilisé
      await _auth.fetchSignInMethodsForEmail(email).then((signInMethods) {
        if (signInMethods.isNotEmpty) {
          throw FirebaseAuthException(
              code: 'email-already-in-use', message: 'L\'email est déjà utilisé');
        }
      });

      // Créer un utilisateur si l'email n'est pas déjà utilisé
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Erreur d'inscription: ${e.code}");

      // Gestion des erreurs spécifiques
      if (e.code == 'email-already-in-use') {
        print("Cet email est déjà utilisé.");
      } else if (e.code == 'weak-password') {
        print("Le mot de passe est trop faible.");
      } else {
        print("Erreur inconnue: ${e.message}");
      }

      return null;
    }
  }

  // 🔹 Déconnexion
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // 🔹 Vérifier si un utilisateur est connecté
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
