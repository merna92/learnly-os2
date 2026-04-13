import 'package:flutter/material.dart';
import '../main.dart';
import '../data/app_data.dart';
// Screen 8 — Ch06: Search history encrypted (AES concept), Ch06: IDS anomaly detection
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
  final _ctrl = TextEditingController();
  String _query = '';
  @override
  Widget build(BuildContext context) {
    final results = _query.isEmpty ? kCourses : kCourses.where((c) =>
      c.title.toLowerCase().contains(_query.toLowerCase()) ||
      c.instructor.toLowerCase().contains(_query.toLowerCase())).toList();
    return Scaffold(
      appBar: AppBar(title: TextField(controller: _ctrl, autofocus: true,
        style: const TextStyle(color: Colors.white), cursorColor: Colors.white,
        decoration: InputDecoration(hintText: 'Search courses, instructors...', hintStyle: const TextStyle(color: Colors.white54),
          border: InputBorder.none, prefixIcon: const Icon(Icons.search, color: Colors.white54)),
        onChanged: (v) => setState(() => _query = v)), backgroundColor: AppColors.dark),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Text('${results.length} results${_query.isNotEmpty ? " for \"$_query\"" : ""}',
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.dark)),
        const SizedBox(height: 10),
        ...results.map((c) => ListTile(
          leading: const Icon(Icons.play_circle_filled, color: AppColors.purple, size: 36),
          title: Text(c.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          subtitle: Text('${c.instructor}  •  ⭐${c.rating}  •  ${c.price}'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.gray),
          onTap: () => Navigator.pushNamed(context, '/course-detail', arguments: c.toMap()))),
      ]),
    );
  }
}
