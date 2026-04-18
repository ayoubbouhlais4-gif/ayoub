import 'package:flutter/material.dart';
import 'admin_dashboard.dart';
import 'mentor_dashboard.dart';
import 'intern_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();

  bool loading = false;
  String error = "";

  void login() {
    setState(() {
      error = "";
      loading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => loading = false);

      String e = email.text.toLowerCase();

      if (e.contains("admin")) {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const AdminDashboard()));
      } else if (e.contains("mentor")) {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const MentorDashboard()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const InternDashboard()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Container(
          width: size.width * 0.85,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
              colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "PRO-LINK",
                style: TextStyle(
                    fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Email",
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),

              const SizedBox(height: 15),

              if (error.isNotEmpty)
                Text(error,
                    style: const TextStyle(color: Colors.red)),

              const SizedBox(height: 10),

              loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 45)),
                      child: const Text("Login"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}