import 'package:flutter/material.dart';
import 'glass_card.dart';
import 'search_box.dart';


class InternDashboard extends StatefulWidget {
  const InternDashboard({super.key});

  @override
  State<InternDashboard> createState() => _InternDashboardState();
}

class _InternDashboardState extends State<InternDashboard> {
  bool showSchedule = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Intern Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            const SearchBox(),

            const SizedBox(height: 10),

            GlassCard(
              title: "My Profile",
              subtitle: "Intern - Software Department",
              onTap: () {},
            ),

            GlassCard(
              title: "My Schedule",
              subtitle: "Weekly working hours",
              onTap: () => setState(() => showSchedule = !showSchedule),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: showSchedule ? 120 : 0,
              child: showSchedule
                  ? Column(
                      children: const [
                        Text("Monday: 9AM - 5PM"),
                        Text("Tuesday: 9AM - 5PM"),
                        Text("Wednesday: Training"),
                      ],
                    )
                  : null,
            ),

            GlassCard(
              title: "My Marks",
              subtitle: "Performance score: 16/20",
              onTap: () {},
            ),

            GlassCard(
              title: "Training Materials",
              subtitle: "Videos + PDFs + Courses",
              onTap: () {},
            ),

            GlassCard(
              title: "Company Rules",
              subtitle: "Read internship policies",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}