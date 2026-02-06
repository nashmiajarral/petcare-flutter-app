import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petcare/utils/app_colors.dart';
import 'package:petcare/utils/user_data.dart';
import 'package:petcare/widgets/custom_button.dart';

class AddAppointmentPage extends StatefulWidget {
  const AddAppointmentPage({super.key});

  @override
  State<AddAppointmentPage> createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
  final _formKey = GlobalKey<FormState>();

  String? selectedPet;
  String? selectedDoctor;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  // ===============================
  // TEMPORARY FRONTEND DATA
  // Backend will replace this later
  // ===============================
  final List<String> petNames =
  petList.map((pet) => pet.name).toList();

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: DateTime.now(),
    );
    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  Future<void> pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() => selectedTime = time);
    }
  }

  void bookAppointment() {
    if (!_formKey.currentState!.validate() ||
        selectedDate == null ||
        selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please complete all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // ===============================
    // TEMPORARY FRONTEND LOGIC
    // Backend API will replace this
    // ===============================
    appointmentList.add(
      Appointment(
        petName: selectedPet!,
        doctorName: selectedDoctor!,
        date: DateFormat.yMMMd().format(selectedDate!),
        time: selectedTime!.format(context),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Appointment booked successfully"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Book Appointment")),
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
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Select Pet",
                        prefixIcon: Icon(Icons.pets),
                      ),
                      items: petNames
                          .map(
                            (pet) => DropdownMenuItem(
                          value: pet,
                          child: Text(pet),
                        ),
                      )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedPet = value),
                      validator: (value) =>
                      value == null ? "Select a pet" : null,
                    ),
                    const SizedBox(height: 16),

                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Select Doctor",
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      items: doctorList
                          .map(
                            (doc) => DropdownMenuItem(
                          value: doc,
                          child: Text(doc),
                        ),
                      )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedDoctor = value),
                      validator: (value) =>
                      value == null ? "Select a doctor" : null,
                    ),
                    const SizedBox(height: 16),

                    ListTile(
                      leading: const Icon(Icons.date_range),
                      title: Text(
                        selectedDate == null
                            ? "Select Date"
                            : DateFormat.yMMMd().format(selectedDate!),
                      ),
                      onTap: pickDate,
                    ),

                    ListTile(
                      leading: const Icon(Icons.access_time),
                      title: Text(
                        selectedTime == null
                            ? "Select Time"
                            : selectedTime!.format(context),
                      ),
                      onTap: pickTime,
                    ),

                    const SizedBox(height: 20),

                    PrimaryButton(
                      text: "Book Appointment",
                      onPressed: bookAppointment,
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
