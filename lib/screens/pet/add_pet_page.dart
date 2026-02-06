import 'package:flutter/material.dart';
import 'package:petcare/utils/app_colors.dart';
import 'package:petcare/utils/user_data.dart';
import 'package:petcare/widgets/custom_textfield.dart';
import 'package:petcare/widgets/custom_button.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController breedController = TextEditingController();

  String? selectedType;

  final List<String> petTypes = ["Dog", "Cat", "Bird", "Other"];

  void addPet() {
    if (!_formKey.currentState!.validate()) return;

    petList.add(
      Pet(
        name: nameController.text.trim(),
        type: selectedType!,
        breed: breedController.text.trim(),
        age: int.parse(ageController.text.trim()),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Pet added successfully"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          backgroundColor: AppColors.scaffoldBackground,
          surfaceTintColor: Colors.white,
          elevation: 1,
          title: const Text("Add Pet",style: TextStyle(color: AppColors.primary,fontWeight: FontWeight.bold,fontSize: 22),),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Container(
              padding: const EdgeInsets.all(20),
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
                  children: [
                    Text(
                      "Pet Information",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 20),

                    // PET NAME
                    CustomTextField(
                      controller: nameController,
                      label: "Pet Name",
                      icon: Icons.pets,
                      validator: (value) =>
                      value!.isEmpty ? "Enter pet name" : null,
                    ),
                    const SizedBox(height: 16),

                    // PET TYPE
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Pet Type",
                        prefixIcon: Icon(Icons.category_outlined),
                      ),
                      value: selectedType,
                      items: petTypes
                          .map(
                            (type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ),
                      )
                          .toList(),
                      onChanged: (value) {
                        setState(() => selectedType = value);
                      },
                      validator: (value) =>
                      value == null ? "Select pet type" : null,
                    ),
                    const SizedBox(height: 16),

                    // BREED
                    CustomTextField(
                      controller: breedController,
                      label: "Breed",
                      icon: Icons.info_outline,
                      validator: (value) =>
                      value!.isEmpty ? "Enter breed" : null,
                    ),
                    const SizedBox(height: 16),

                    // AGE
                    CustomTextField(
                      controller: ageController,
                      label: "Age",
                      icon: Icons.calendar_today_outlined,
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                      value!.isEmpty ? "Enter age" : null,
                    ),
                    const SizedBox(height: 24),

                    // SUBMIT
                    PrimaryButton(
                      text: "Add Pet",
                      onPressed: addPet,
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
