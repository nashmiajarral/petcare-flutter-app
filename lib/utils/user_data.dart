
// Temporary dummy user data for frontend demo
// Will be replaced with backend database
List<Map<String, String>> fakeUsers = [
  {"email": "test@gmail.com", "password": "123456"},
  {"email": "user@gmail.com", "password": "password"},
];
// ===============================
// PET MODEL (Frontend Only)
// ===============================
class Pet {
  String name;
  String type;
  String breed;
  int age;
  String? imageUrl; // 👈 ADD THIS

  Pet({
    required this.name,
    required this.type,
    required this.breed,
    required this.age,
    this.imageUrl,
  });
}


// ===============================
// LOCAL PET STORAGE (In-Memory)
// ===============================
List<Pet> petList = [];
class Appointment {
  final String petName;
  final String doctorName;
  final String date;
  final String time;
  final String status;

  Appointment({
    required this.petName,
    required this.doctorName,
    required this.date,
    required this.time,
    this.status = "Pending",
  });
}

// Dummy doctors
List<String> doctorList = [
  "Dr. Ahmed",
  "Dr. Sarah",
  "Dr. Ali",
];

// Dummy appointments list (LOCAL STORAGE)
List<Appointment> appointmentList = [];


