import 'package:flutter/material.dart';
import '../main.dart';
import '../data/app_data.dart';
// Screen 6 — Ch06: Encrypted video stream (HTTPS/TLS), Ch05: ACL watch rights
class VideoPlayerScreen extends StatelessWidget {
  final Map<String, dynamic> course;
  const VideoPlayerScreen({required this.course, super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, leading: const BackButton(color: Colors.white),
        title: Text(course['title'] ?? '', style: const TextStyle(color: Colors.white, fontSize: 13), overflow: TextOverflow.ellipsis)),
      body: Column(children: [
        // Video area
        Container(height: 220, color: const Color(0xFF111122),
          child: const Center(child: Icon(Icons.play_circle_filled, size: 64, color: Colors.white54))),
        // Progress bar
        LinearProgressIndicator(value: 0.54, backgroundColor: Colors.grey.shade800, color: AppColors.red, minHeight: 3),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(children: [
            Text('14:32', style: TextStyle(color: Colors.white54, fontSize: 12)),
            Spacer(), Text('28:45', style: TextStyle(color: Colors.white54, fontSize: 12))])),
        // Chapters
        Expanded(child: ListView(padding: const EdgeInsets.all(12), children: [
          const Text('Chapters', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 8),
          ...List.generate(5, (i) => ListTile(
            leading: CircleAvatar(radius: 16, backgroundColor: i==1 ? AppColors.red : Colors.grey.shade800,
              child: Text('${i+12}', style: const TextStyle(color: Colors.white, fontSize: 12))),
            title: Text(['Intro to State', 'State Management ▶', 'Navigation', 'Firebase', 'Testing'][i],
              style: TextStyle(color: i==1 ? AppColors.red : Colors.white70, fontSize: 13)),
            subtitle: Text(['12:10','28:45','20:30','35:15','18:00'][i], style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
            trailing: i < 2 ? const Icon(Icons.check_circle, color: AppColors.green, size: 18) : null)),
        ])),
      ]),
    );
  }
}
