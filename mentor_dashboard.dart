import 'package:flutter/material.dart';
import 'glass_card.dart';
import 'search_box.dart';

class MentorDashboard extends StatefulWidget {
  const MentorDashboard({super.key});

  @override
  State<MentorDashboard> createState() => _MentorDashboardState();
}

class _MentorDashboardState extends State<MentorDashboard> {
  List<Map<String, dynamic>> interns = [
    {"name": "Ahmed", "mark": 15},
    {"name": "Sara", "mark": 17},
    {"name": "Omar", "mark": 14},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mentor Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            const SearchBox(),

            const SizedBox(height: 10),

            GlassCard(
              title: "Evaluate Interns",
              subtitle: "Give performance marks",
              onTap: () {},
            ),

            const SizedBox(height: 10),

            const Text("Intern List",
                style: TextStyle(fontSize: 18)),

            const SizedBox(height: 10),

            // 📌 ListView inside ListView (advanced usage)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: interns.length,
              itemBuilder: (context, i) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(interns[i]["name"]),
                      Text("Mark: ${interns[i]["mark"]}"),
                    ],
                  ),
                );
              },
            ),

            GlassCard(
              title: "Upload Training",
              subtitle: "PDF / Videos / Docs",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}