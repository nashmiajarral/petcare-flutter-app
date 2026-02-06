import 'package:flutter/material.dart';
import '../auth/login_page.dart';
import '../auth/signup_page.dart';
import '../../utils/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int gridCount = screenWidth > 1200
        ? 4
        : screenWidth > 800
        ? 3
        : 2;

    return Scaffold(
      backgroundColor: AppColors.background,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,

        title: Row(
          children: const [
            Icon(Icons.favorite, color: AppColors.primary),
            SizedBox(width: 8),
            Text(
              "PetCare+",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
            child: const Text(
              "Login",
              style: TextStyle(color: AppColors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // pill shape
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignupPage()),
                );
              },
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= MENU BAR =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  navButton("About Us", () {}),
                  popupMenu(context),
                  navButton("Shop", () {}),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ================= HERO =================
            Container(
              height: 350,
              width: double.infinity,
              color: Colors.black,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to PetCare+",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,

                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Professional care for your beloved pets",
                    style: TextStyle(color: Colors.white,
                    fontSize: 14,),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // ================= ABOUT =================
            const Text(
              "About Us",
              style: TextStyle(fontSize: 28, color: Colors.black),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "PetCare+ is a modern pet care management platform designed to simplify and enhance the way pet owners access veterinary services. The system provides a centralized solution for managing pet profiles, booking doctor appointments, and accessing essential pet healthcare services through a user-friendly interface. PetCare+ aims to bridge the gap between pet owners and veterinary professionals by offering a reliable, efficient, and organized digital environment. By integrating structured workflows and intuitive navigation, the platform ensures ease of use for clients while maintaining scalability for future enhancements. The system is developed with a focus on professionalism, trust, and accessibility, making pet healthcare management more convenient and dependable for users.",

                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),

            const SizedBox(height: 60),

            // ================= OUR DOCTORS =================
            const Text(
              "Our Doctors",
              style: TextStyle(fontSize: 26, color: Colors.black),
            ),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GridView.count(
                crossAxisCount: gridCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: const [
                  DoctorCard(
                    name: "Dr. Sarah Johnson",
                    role: "Veterinary Surgeon",
                    experience: "15 years experience",
                  ),
                  DoctorCard(
                    name: "Dr. Michael Chen",
                    role: "Pet Specialist",
                    experience: "10 years experience",
                  ),
                  DoctorCard(
                    name: "Dr. Emily Rodriguez",
                    role: "Animal Behaviorist",
                    experience: "12 years experience",
                  ),
                  DoctorCard(
                    name: "Dr. James Wilson",
                    role: "Exotic Specialist",
                    experience: "8 years experience",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 80),

            // ================= FOOTER =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: AppColors.darkBackground,
              child: Column(
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "PetCare+",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),

                  SizedBox(height: 6),
                  Text(
                    "© 2025 PetCare+. All rights reserved.",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= MENU ITEMS =================
  Widget menuItem(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget popupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        // Ask user to login/signup first
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Login Required"),
              content: Text(
                value == "pet"
                    ? "Please login or sign up to manage your pet profile."
                    : "Please login or sign up to book appointments.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    );
                  },
                  child: const Text("Login"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignupPage()),
                    );
                  },
                  child: const Text("Sign Up",
                    style: TextStyle(
                      color: AppColors.textLight,
                    ),),
                ),
              ],
            );
          },
        );
      },
      child: Row(
        children: const [
          Text(
            "Pet Service",
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
          ),
          Icon(Icons.arrow_drop_down),
        ],
      ),
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: "pet",
          child: Text("Pet Profile"),
        ),
        PopupMenuItem(
          value: "appointment",
          child: Text("Appointments"),
        ),
      ],
    );
  }

  // ================= NAV BUTTON =================
  Widget navButton(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

// ================= DOCTOR CARD =================
class DoctorCard extends StatelessWidget {
  final String name;
  final String role;
  final String experience;

  const DoctorCard({
    super.key,
    required this.name,
    required this.role,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Container(
            height: 160,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Center(
              child: Icon(Icons.pets, size: 70, color: AppColors.primary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black)),
                Text(role, style: const TextStyle(color: AppColors.primary)),
                Text(experience,
                    style: const TextStyle(color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





