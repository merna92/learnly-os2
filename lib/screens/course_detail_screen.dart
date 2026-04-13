// ══════════════════════════════════════════════════════════
// SCREEN 4 — COURSE DETAIL
// Ch05 — ACL: enrolled vs non-enrolled views
// Ch05 — DAC: owner (instructor) controls access
// ══════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../main.dart';
import '../data/app_data.dart';

class CourseDetailScreen extends StatelessWidget {
  final Map<String, dynamic> course;
  const CourseDetailScreen({required this.course, super.key});

  @override
  Widget build(BuildContext context) {
    final isEnrolled = kEnrolled.any((e) => (e['course'] as Course).id == course['id']);
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: CustomScrollView(slivers: [
        SliverAppBar(expandedHeight: 200, pinned: true,
          backgroundColor: AppColors.dark,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(course['title'] ?? '', style: const TextStyle(fontSize: 13, color: Colors.white), maxLines: 2, overflow: TextOverflow.ellipsis),
            background: Stack(children: [
              CachedNetworkImage(
                imageUrl: course['thumbnail'] ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                placeholder: (_, __) => Container(color: AppColors.dark),
                errorWidget: (_, __, ___) => Container(color: AppColors.dark),
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xCC1E1B4B), Color(0x661E1B4B)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              const Center(child: Icon(Icons.play_circle_filled, size: 64, color: Colors.white70)),
            ])),
          leading: const BackButton(color: Colors.white)),
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (course['isBestseller'] == true)
            Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(6)),
              child: const Text('🏆 Bestseller', style: TextStyle(fontSize: 12, color: Color(0xFF92400E), fontWeight: FontWeight.bold))),
          Text(course['title'] ?? '', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.dark)),
          const SizedBox(height: 8),
          Text(course['instructor'] ?? '', style: const TextStyle(fontSize: 14, color: AppColors.purple, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(children: [
            Text('⭐ ${course['rating']}', style: const TextStyle(color: AppColors.gold, fontSize: 14, fontWeight: FontWeight.bold)),
            Text('  (${course['students']} students)', style: const TextStyle(fontSize: 13, color: AppColors.gray)),
          ]),
          const SizedBox(height: 8),
          Wrap(spacing: 8, children: [
            _chip(course['level'] ?? '', AppColors.purple),
            _chip('${course['duration']}', AppColors.green),
            _chip('${course['lectures']} lectures', AppColors.orange),
          ]),
          const SizedBox(height: 16),
          Container(padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade100)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(course['price'] ?? '', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.purple)),
                const Spacer(),
                if (isEnrolled)
                  Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(20)),
                    child: const Text('✅ Enrolled', style: TextStyle(color: Color(0xFF065F46), fontWeight: FontWeight.bold))),
              ]),
              const SizedBox(height: 14),
              SizedBox(width: double.infinity, height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (isEnrolled) {
                      Navigator.pushNamed(context, '/video-player', arguments: course);
                    } else {
                      Navigator.pushNamed(context, '/checkout', arguments: course);
                    }
                  },
                  icon: Icon(isEnrolled ? Icons.play_arrow : Icons.shopping_cart),
                  label: Text(isEnrolled ? 'Continue Learning' : 'ENROLL NOW — ${course['price']}',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isEnrolled ? AppColors.green : AppColors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                )),
              const SizedBox(height: 8),
            ])),
          const SizedBox(height: 16),
          const Text('What You\'ll Learn', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.dark)),
          const SizedBox(height: 10),
          const Text('Course content from curriculum...', style: TextStyle(fontSize: 13, color: AppColors.gray)),
        ])))
      ]),
    );
  }

  Widget _chip(String t, Color c) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: c.withOpacity(0.3))),
    child: Text(t, style: TextStyle(fontSize: 11, color: c, fontWeight: FontWeight.w600)));
}
