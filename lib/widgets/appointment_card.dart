import 'package:flutter/material.dart';
import 'package:petcare/utils/app_colors.dart';
import 'package:petcare/utils/user_data.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.calendar_today, color: AppColors.primary),
        title: Text(
          "${appointment.petName} • ${appointment.doctorName}",
        ),
        subtitle: Text(
          "${appointment.date} at ${appointment.time}\nStatus: ${appointment.status}",
        ),
      ),
    );
  }
}
