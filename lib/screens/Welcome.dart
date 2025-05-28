import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

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
          Image.asset(
            'assets/images/bg9.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              // Partie du texte "Welcome Back!"
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 200),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20), // Espace entre les textes
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        child: const Text(
                          "Enter personal details to your employee account",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Espace entre le texte et les boutons
              const SizedBox(height: 20),

              // Partie avec les boutons en bas
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                        ),
                      ),
                      child:  Center(
                        child: TextButton(
                          onPressed: () => Navigator.pushNamed(context, "/login"),
                          child: const Text(
                            "Sign in",
                            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50), // Correction ici
                        ),
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: () => Navigator.pushNamed(context, '/register'),
                          child: const Text(
                            "Sign up",
                            style: TextStyle(fontSize: 20, color: Colors.purple, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
