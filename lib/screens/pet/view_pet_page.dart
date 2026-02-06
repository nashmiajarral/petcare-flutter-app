import 'package:flutter/material.dart';
import 'package:petcare/utils/app_colors.dart';
import 'package:petcare/utils/user_data.dart';
import 'package:petcare/widgets/pet_card.dart';
import 'add_pet_page.dart';

class ViewPetPage extends StatefulWidget {
  const ViewPetPage({super.key});

  @override
  State<ViewPetPage> createState() => _ViewPetPageState();
}

class _ViewPetPageState extends State<ViewPetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("My Pets")),
      body: petList.isEmpty
          ? const Center(child: Text("No pets added yet"))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: petList.length,
        itemBuilder: (_, index) {
          final pet = petList[index];

          return PetCard(
            pet: pet,
            onDelete: () {
              setState(() {
                petList.removeAt(index);
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddPetPage()),
          );
          setState(() {});
        },
      ),
    );
  }
}
