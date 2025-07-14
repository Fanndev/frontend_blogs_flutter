import 'package:flutter/material.dart';
import 'package:blogs_apps/resource/resource.dart';
import 'package:blogs_apps/app/modules/users/main/views/main_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Splash delay untuk 2 detik agar user sempat melihat logo
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainView()),
      );
    });

    // Animasi scale agar logo muncul dengan halus
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo splash screen dengan animasi scale
            ScaleTransition(
              scale: _animation,
              child: Image.asset(
                logo,
                height: 400,
                width: 400,
              ),
            ),
            const SizedBox(height: 20),
            // Nama aplikasi
            const Text(
              "RIBUT",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Berita Gabut",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 40),
            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
