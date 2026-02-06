import 'package:flutter/material.dart';
import 'package:petcare/utils/app_colors.dart';
import 'package:petcare/utils/user_data.dart';
import 'package:petcare/screens/pet/add_pet_page.dart';
import 'package:petcare/screens/appointment/add_appointment_page.dart';
import 'package:petcare/screens/pet/pet_profile_page.dart';
import 'package:petcare/screens/splash/splash_screen.dart';


class ClientDashboard extends StatefulWidget {
  const ClientDashboard({super.key});

  @override
  State<ClientDashboard> createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        surfaceTintColor: Colors.white,
        elevation: 1,

        leadingWidth: 140,

        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: const [
                  const Icon(Icons.favorite, color: AppColors.primary),
                  const SizedBox(width: 6),
                  Text(
                    "PetCare+",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        title: const SizedBox.shrink(),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min, // 🔥 prevents overflow
              children: [

                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    // TODO: Navigate to Shop page later
                    debugPrint("Shop icon clicked");
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      Icons.storefront_outlined,
                      color: AppColors.primary,
                      size: 22,
                    ),
                  ),
                ),

                const SizedBox(width: 6),

                // 🚪 LOGOUT / LEAVE ICON
                IconButton(
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SplashScreen(),
                      ),
                          (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),



      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =========================
            // PET PROFILES (CLICKABLE)
            // =========================
            const Text(
              "Pet Profiles",
              style: TextStyle(color: Colors.black,fontSize: 22),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 110,
              child: petList.isEmpty
                  ? const Center(child: Text("No pets added"))
                  : ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: petList.length,
                separatorBuilder: (_, __) =>
                const SizedBox(width: 12),
                itemBuilder: (_, index) {
                  final pet = petList[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () async {
                      debugPrint("Open profile of ${pet.name}");

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PetProfilePage(
                            pet: pet,
                            index: index,
                          ),
                        ),
                      );

                      setState(() {}); // refresh after edit/delete
                    },
                    child: Container(
                      width: 220,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: pet.imageUrl != null
                                ? NetworkImage(pet.imageUrl!)
                                : null,
                            child: pet.imageUrl == null
                                ? Icon(Icons.pets)
                                : null,
                          ),

                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                pet.name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                pet.type,
                                style: const TextStyle(color: Colors.blueGrey),
                              ),
                              Text("${pet.age} years"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // =========================
            // VIEW PET & APPOINTMENTS
            // =========================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "View Pet & Appointments",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,

                    ),
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    "Your Pets",
                    style: TextStyle(color:Colors.blueGrey,fontSize: 16,fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),

                  ...petList.map((pet) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${pet.name} - ${pet.type}",
                              style: const TextStyle(
                                color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                          Text("${pet.age} years old"),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 20),

                  // =========================
                  // APPOINTMENTS VIEW
                  // =========================
                  const Text(
                    "Appointments View",
                    style: TextStyle(color: Colors.blueGrey,fontSize: 16,fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),

                  ...appointmentList.map((appt) {
                    final isPending =
                        appt.status == "Pending";

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${appt.petName} - ${appt.doctorName}",
                                style: const TextStyle( color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text("${appt.date} at ${appt.time}"),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isPending
                                  ? Colors.orange.shade100
                                  : Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              appt.status,
                              style: TextStyle(
                                color: isPending
                                    ? Colors.orange
                                    : Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // =========================
            // ACTION BUTTONS
            // =========================
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add,
                    color: Colors.white,),
                    label: const Text("Add Pet",
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddPetPage(),
                        ),
                      );
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_today,
                    color: Colors.white,),
                    label: const Text("Book Appointment",
                    style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddAppointmentPage(),
                        ),
                      );
                      setState(() {});
                    },
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


