import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const GlassCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [Color(0xFF1F2937), Color(0xFF111827)],
          ),
          boxShadow: const [
            BoxShadow(color: Colors.black54, blurRadius: 10),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(subtitle),
          ],
        ),
      ),
    );
  }
}