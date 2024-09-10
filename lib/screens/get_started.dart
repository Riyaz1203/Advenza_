import 'package:flutter/material.dart';
import 'login.dart';
import 'sign_up.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
          0xFFD9D9D9), // Replace this color with your background image
      // decoration: BoxDecoration(image: AssetImage('assets/bg_image.png')), // Background image
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Stretch widgets horizontally
            children: [
              const Text(
                'ADVENZA',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 42, 88, 42),
                ),
                textAlign: TextAlign.center, // Center text horizontally
              ),
              const SizedBox(height: 10),
              const Text(
                'IF NOT NOW, WHEN?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center, // Center text horizontally
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 42, 88, 42), // Background color
                  padding: const EdgeInsets.symmetric(
                      vertical: 15), // Stretch button vertically
                ),
                child: const Text('LOG IN',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 42, 88, 42), // Background color
                  padding: const EdgeInsets.symmetric(
                      vertical: 15), // Stretch button vertically
                ),
                child: const Text('SIGN UP',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
