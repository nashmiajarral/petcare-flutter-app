import 'package:flutter/material.dart';
import 'package:petcare/utils/app_colors.dart';
import 'package:petcare/utils/user_data.dart';
import 'package:petcare/widgets/custom_textfield.dart';
import 'package:petcare/widgets/custom_button.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? selectedRole;
  bool obscurePassword = true;
  bool isLoading = false;

  final List<String> roles = ["Client", "Doctor", "Admin"];

  // ==========================================
  // TEMPORARY FRONTEND SIGNUP LOGIC
  // (Will be replaced by backend API later)
  // ==========================================
  Future<bool> fakeSignup(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 700));

    final existingUser = fakeUsers.firstWhere(
          (u) => u["email"] == email,
      orElse: () => {},
    );

    if (existingUser.isNotEmpty) return false;

    fakeUsers.add({
      "name": nameController.text.trim(),
      "email": email,
      "phone": phoneController.text.trim(),
      "role": selectedRole ?? "Client",
      "password": password,
    });


    return true;
  }

  void signupUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    // TODO (Backend): Replace fakeSignup with real API call
    bool success = await fakeSignup(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    setState(() => isLoading = false);

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account already exists"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Account created successfully"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Create Account"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Join PetCare",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 20),

                    // NAME
                    CustomTextField(
                      controller: nameController,
                      label: "Full Name",
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your full name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // EMAIL
                    CustomTextField(
                      controller: emailController,
                      label: "Email",
                      icon: Icons.email_outlined,
                      validator: (value) {
                        if (value == null || !value.contains("@")) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // PHONE
                    CustomTextField(
                      controller: phoneController,
                      label: "Phone Number",
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.length < 10) {
                          return "Enter a valid phone number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // ROLE DROPDOWN
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Select Role",
                        prefixIcon: Icon(Icons.account_circle_outlined),
                      ),
                      value: selectedRole,
                      items: roles
                          .map(
                            (role) => DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        ),
                      )
                          .toList(),
                      onChanged: (value) {
                        setState(() => selectedRole = value);
                      },
                      validator: (value) =>
                      value == null ? "Select your role" : null,
                    ),
                    const SizedBox(height: 16),

                    // PASSWORD
                    CustomTextField(
                      controller: passwordController,
                      label: "Password",
                      icon: Icons.lock_outline,
                      obscureText: obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),

                    // SIGNUP BUTTON
                PrimaryButton(
                  text: "Create Account",
                  textColor:AppColors.textLight,
                  isLoading: isLoading,
                  onPressed: signupUser,
                ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}