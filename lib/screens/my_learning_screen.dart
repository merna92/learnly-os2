// ══════════════════════════════════════════════════════════
// SCREEN 5 — MY LEARNING
// Ch05 — Capability: enrollment = unforgeable access token
// Ch06 — PKI: certificate validity
// ══════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../main.dart';
import '../data/app_data.dart';

class MyLearningScreen extends StatelessWidget {
  const MyLearningScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(title: const Text('📚 My Learning'), backgroundColor: AppColors.dark,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'))),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        // Stats
        Row(children: [
          _stat('3', 'Courses', AppColors.purple),
          const SizedBox(width: 10),
          _stat('68%', 'Avg', AppColors.green),
          const SizedBox(width: 10),
          _stat('1', 'Cert', AppColors.gold),
        ]),
        const SizedBox(height: 16),
        const Text('Enrolled Courses', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.dark)),
        const SizedBox(height: 10),
        ...kEnrolled.map((e) {
          final c = e['course'] as Course;
          final prog = e['progress'] as double;
          final last = e['lastLesson'] as String;
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade100),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0,2))]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                _courseThumb(c.thumbnail, c.category),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(c.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.dark), maxLines: 2, overflow: TextOverflow.ellipsis),
                  Text(c.instructor, style: const TextStyle(fontSize: 11, color: AppColors.gray)),
                ])),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/video-player', arguments: c.toMap()),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.orange, foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  child: const Text('Resume', style: TextStyle(fontSize: 12))),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(value: prog, minHeight: 7,
                    backgroundColor: Colors.grey.shade200, color: AppColors.purple))),
                const SizedBox(width: 10),
                Text('${(prog*100).round()}%', style: const TextStyle(fontSize: 12, color: AppColors.purple, fontWeight: FontWeight.bold)),
              ]),
              const SizedBox(height: 4),
              Text('Last: $last', style: const TextStyle(fontSize: 11, color: AppColors.gray)),
            ]),
          );
        }),
        const SizedBox(height: 16),
        // Certificate section
        Container(padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFFFFBEB), Color(0xFFFEF3C7)]),
            borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gold.withOpacity(0.5))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Row(children: [
              Icon(Icons.workspace_premium, color: AppColors.gold, size: 24),
              SizedBox(width: 8),
              Text('Certificates Earned', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.dark)),
            ]),
            const SizedBox(height: 10),
            ListTile(
              leading: const CircleAvatar(backgroundColor: AppColors.gold, child: Icon(Icons.school, color: Colors.white)),
              title: const Text('Flutter & Dart Complete Guide', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              subtitle: const Text('Issued: Dec 2025  •  Learnly CA  •  RSA-2048', style: TextStyle(fontSize: 10)),
              trailing: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/certificate'),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.gold, foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                child: const Text('View', style: TextStyle(fontSize: 12))),
            ),
          ])),
        const SizedBox(height: 16),
        const SizedBox(height: 12),
      ]),
    );
  }

  Widget _stat(String v, String l, Color c) => Expanded(
    child: Container(padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: c.withOpacity(0.3))),
      child: Column(children: [
        Text(v, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: c)),
        Text(l, style: const TextStyle(fontSize: 10, color: Colors.black45), textAlign: TextAlign.center),
      ])));

  Widget _courseThumb(String url, String category) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(children: [
        CachedNetworkImage(
          imageUrl: url,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(color: AppColors.purple.withOpacity(0.15)),
          errorWidget: (_, __, ___) => Container(
            color: AppColors.purple.withOpacity(0.15),
            child: const Icon(Icons.image_not_supported, color: AppColors.purple),
          ),
        ),
        Positioned(
          left: 4,
          bottom: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.55),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              category,
              style: const TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ]),
    );
  }
}
