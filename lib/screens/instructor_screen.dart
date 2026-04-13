import 'package:flutter/material.dart';
import '../main.dart';
import '../data/app_data.dart';
// Screen 7 — Ch05: Instructor domain, Ch06: Verified digital certificate
class InstructorScreen extends StatelessWidget {
  final Map<String, dynamic> instructor;
  const InstructorScreen({required this.instructor, super.key});
  @override
  Widget build(BuildContext context) {
    final name = instructor['name'] ?? 'Angela Yu';
    final initials = instructor['initials'] ?? 'AY';
    return Scaffold(
      appBar: AppBar(title: Text(name), backgroundColor: AppColors.purple, leading: const BackButton(color: Colors.white)),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Center(child: Column(children: [
          CircleAvatar(radius: 44, backgroundColor: AppColors.light,
            child: Text(initials, style: const TextStyle(color: AppColors.purple, fontSize: 24, fontWeight: FontWeight.bold))),
          const SizedBox(height: 12),
          Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.dark)),
          Container(margin: const EdgeInsets.only(top: 6), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(20)),
            child: const Text('✅ Verified Instructor', style: TextStyle(color: Color(0xFF166534), fontWeight: FontWeight.bold, fontSize: 12))),
          const SizedBox(height: 8),
          const Text('Lead Instructor at London App Brewery', style: TextStyle(color: AppColors.gray, fontSize: 13)),
        ])),
        const SizedBox(height: 16),
        Row(children: [
          _stat('1.8M', 'Students'), _stat('4.8', 'Rating'), _stat('72', 'Courses'),
        ]),
        const SizedBox(height: 16),
        SizedBox(width: double.infinity, height: 46,
          child: ElevatedButton.icon(onPressed: (){}, icon: const Icon(Icons.add), label: const Text('FOLLOW'),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.orange, foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))))),
        const SizedBox(height: 16),
        const Text('Top Courses', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.dark)),
        ...kCourses.where((c) => c.instructor == name).map((c) => ListTile(
          leading: const Icon(Icons.play_circle_filled, color: AppColors.purple, size: 36),
          title: Text(c.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          subtitle: Text('⭐ ${c.rating}  •  ${c.students} students  •  ${c.price}'),
          onTap: () => Navigator.pushNamed(context, '/course-detail', arguments: c.toMap()))),
        const SizedBox(height: 12),
      ]),
    );
  }
  Widget _stat(String v, String l) => Expanded(child: Column(children: [
    Text(v, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.purple)),
    Text(l, style: const TextStyle(fontSize: 11, color: AppColors.gray))]));
}
