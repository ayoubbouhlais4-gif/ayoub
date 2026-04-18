import 'package:flutter/material.dart';
import 'glass_card.dart';
import 'search_box.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            const SearchBox(),

            const SizedBox(height: 10),

            // 📊 Stats section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statCard("Interns", "24"),
                _statCard("Mentors", "5"),
                _statCard("Projects", "12"),
              ],
            ),

            const SizedBox(height: 20),

            GlassCard(
              title: "Assign Interns",
              subtitle: "Manage internship distribution",
              onTap: () {},
            ),

            GlassCard(
              title: "Departments",
              subtitle: "IT / HR / Finance / Dev",
              onTap: () {},
            ),

            GlassCard(
              title: "Upload Schedules",
              subtitle: "Weekly planning system",
              onTap: () {},
            ),

            GlassCard(
              title: "Company Rules",
              subtitle: "Policies & regulations",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value) {
    return Container(
      width: 90,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 18)),
          Text(title),
        ],
      ),
    );
  }
}