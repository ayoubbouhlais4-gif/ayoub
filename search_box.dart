import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  String query = "";

  List<String> data = [
    "Schedule",
    "Marks",
    "Training",
    "Reports",
    "Interns"
  ];

  @override
  Widget build(BuildContext context) {
    var filtered = data
        .where((e) => e.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "Search anything...",
            filled: true,
            fillColor: Colors.black26,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onChanged: (v) => setState(() => query = v),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 80,
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.all(5),
              child: Text(filtered[i]),
            ),
          ),
        )
      ],
    );
  }
}