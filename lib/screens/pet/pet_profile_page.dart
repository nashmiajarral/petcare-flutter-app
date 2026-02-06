import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcare/utils/app_colors.dart';
import 'package:petcare/utils/user_data.dart';

class PetProfilePage extends StatefulWidget {
  final Pet pet;
  final int index;

  const PetProfilePage({
    super.key,
    required this.pet,
    required this.index,
  });

  @override
  State<PetProfilePage> createState() => _PetProfilePageState();
}

class _PetProfilePageState extends State<PetProfilePage> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController breedController;
  String? selectedType;
  XFile? profileImage;


  final picker = ImagePicker();

  final petTypes = ["Dog", "Cat", "Bird", "Rabbit", "Other"];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.pet.name);
    ageController =
        TextEditingController(text: widget.pet.age.toString());
    breedController =
        TextEditingController(text: widget.pet.breed);
    selectedType = widget.pet.type;
  }

  Future<void> pickImage() async {
    final XFile? picked =
    await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        profileImage = picked;
      });
    }
  }


  void saveChanges() {
    petList[widget.index] = Pet(
      name: nameController.text.trim(),
      type: selectedType!,
      breed: breedController.text.trim(),
      age: int.parse(ageController.text.trim()),
      imageUrl: profileImage?.path, // 👈 THIS LINE FIXES IT
    );

    Navigator.pop(context);
  }

  void deletePet() {
    petList.removeAt(widget.index);
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
        title: const Text("Pet Profile",
        style: TextStyle(color: AppColors.primary,fontWeight: FontWeight.bold,fontSize: 22),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ======================
            // PROFILE IMAGE
            // ======================
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: profileImage != null
                    ? NetworkImage(profileImage!.path)
                    : null,
                child: profileImage == null
                    ? Icon(Icons.camera_alt)
                    : null,
              )
            ),

            const SizedBox(height: 20),

            // ======================
            // FORM
            // ======================
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Pet Name"),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: selectedType,
              decoration: const InputDecoration(labelText: "Pet Type"),
              items: petTypes
                  .map(
                    (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() => selectedType = value);
              },
            ),
            const SizedBox(height: 12),

            TextField(
              controller: breedController,
              decoration: const InputDecoration(labelText: "Breed"),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Age"),
            ),

            const SizedBox(height: 24),

            // ======================
            // ACTION BUTTONS
            // ======================
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: saveChanges,
                    child: const Text("Save Changes",
                    style: TextStyle(color: Colors.white),),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: deletePet,
                    child: const Text("Delete Pet",
                    style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
