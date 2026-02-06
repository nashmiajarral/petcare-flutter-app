import 'package:flutter/material.dart';
import 'package:petcare/utils/app_colors.dart';
import 'package:petcare/utils/user_data.dart';
import 'package:petcare/widgets/appointment_card.dart';

class ViewAppointmentPage extends StatefulWidget {
  const ViewAppointmentPage({super.key});

  @override
  State<ViewAppointmentPage> createState() => _ViewAppointmentPageState();
}

class _ViewAppointmentPageState extends State<ViewAppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("My Appointments")),
      body: appointmentList.isEmpty
          ? const Center(child: Text("No appointments booked yet"))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: appointmentList.length,
        itemBuilder: (_, index) {
          return AppointmentCard(
            appointment: appointmentList[index],
          );
        },
      ),
    );
  }
}
