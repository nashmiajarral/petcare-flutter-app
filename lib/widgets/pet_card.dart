import 'package:flutter/material.dart';
import 'package:petcare/utils/app_colors.dart';
import 'package:petcare/utils/user_data.dart';

class PetCard extends StatelessWidget {
  final Pet pet;
  final VoidCallback onDelete;

  const PetCard({
    super.key,
    required this.pet,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.pets, color: AppColors.primary),
        title: Text(pet.name),
        subtitle: Text(
          "${pet.type} • ${pet.age} yrs\nBreed: ${pet.breed}",
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
