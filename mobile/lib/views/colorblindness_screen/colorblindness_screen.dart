import 'package:flutter/material.dart';
import 'package:myapp/views/deuteranopia/deuteranopiacamera_screen.dart';
import 'package:myapp/views/protanopia/protanopiacamera_screen.dart';
import 'package:myapp/views/tritanopia/tritanopiacamera_screen.dart';

class ColorBlindnessScreen extends StatelessWidget {
  const ColorBlindnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002D5B), // Dark blue gradient background
      body: SafeArea(
        child: Center(
          // Center the entire content
          child: Column(
            mainAxisSize: MainAxisSize.min, // Minimize the vertical space taken
            children: [
              // Eye icon at the top
              const Icon(
                Icons.remove_red_eye,
                size: 60,
                color: Colors.white,
              ),
              const SizedBox(height: 10),

              // Title
              const Text(
                "COLOR-BLINDNESS",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Subtitle
              const Text(
                "PICK YOUR DIAGNOSED TYPE:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 40),

              // Options
              Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center options vertically
                children: [
                  // Deuteranopia
                  _buildOption(
                    context,
                    label: "DEUTERANOPIA",
                    imagePath:
                        "assets/deuteranopia.png", // Replace with your image path
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DeuteranopiaView(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20), // Add spacing between options
                  // Tritanopia
                  _buildOption(
                    context,
                    label: "TRITANOPIA",
                    imagePath:
                        "assets/tritanopia.png", // Replace with your image path
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TritanopiaView(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20), // Add spacing between options
                  // Protanopia
                  _buildOption(
                    context,
                    label: "PROTANOPIA",
                    imagePath:
                        "assets/protanopia.png", // Replace with your image path
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProtanopiaView(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build options
  Widget _buildOption(BuildContext context,
      {required String label,
      required String imagePath,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
