import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../main.dart';
import '../data/app_data.dart';

class HomeScreenFive extends StatefulWidget {
  const HomeScreenFive({super.key});
  @override State<HomeScreenFive> createState() => _HomeScreenFiveState();
}

class _HomeScreenFiveState extends State<HomeScreenFive> {
  int _selectedCategory = 0;

  List<Course> get _filtered {
    if (_selectedCategory == 0) return kCourses;
    final cat = (kCategories[_selectedCategory]['name'] as String);
    return kCourses.where((c) => c.category == cat).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        title: Row(children: [
          Container(width: 32, height: 32,
            decoration: const BoxDecoration(shape: BoxShape.circle,
              gradient: LinearGradient(colors: [AppColors.purple, AppColors.dPurple])),
            child: const Icon(Icons.school, size: 18, color: Colors.white)),
          const SizedBox(width: 8),
          const Text('Learnly', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ]),
      ),
      body: ListView(children: [
        // Welcome banner
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [AppColors.purple, AppColors.dPurple],
              begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: AppColors.purple.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: const Row(children: [
            CircleAvatar(radius: 26, backgroundColor: Colors.white24,
              child: Text('MM', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15))),
            SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Hi, Mirna! 👋', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 2),
              Text('Choose a course and start learning', style: TextStyle(color: Colors.white70, fontSize: 12)),
              SizedBox(height: 4),
              Text('Role: Student  •  Featured courses', style: TextStyle(color: Colors.white54, fontSize: 11)),
            ])),
          ]),
        ),

        // Categories
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
          child: const Text('Categories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.dark))),
        const SizedBox(height: 10),
        SizedBox(height: 44, child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: kCategories.length,
          itemBuilder: (_, i) {
            final sel = _selectedCategory == i;
            final cat = kCategories[i];
            return GestureDetector(
              onTap: () => setState(() => _selectedCategory = i),
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: sel ? AppColors.purple : Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.purple.withOpacity(0.4)),
                  boxShadow: sel ? [BoxShadow(color: AppColors.purple.withOpacity(0.2), blurRadius: 6)] : [],
                ),
                child: Row(children: [
                  Icon(cat['icon'] as IconData, size: 14, color: sel ? Colors.white : AppColors.purple),
                  const SizedBox(width: 6),
                  Text(cat['name'] as String, style: TextStyle(fontSize: 13, color: sel ? Colors.white : AppColors.purple, fontWeight: FontWeight.w600)),
                ]),
              ),
            );
          })),
        const SizedBox(height: 16),

        // Course list
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('${_filtered.length} Courses', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.dark))),
        const SizedBox(height: 10),
        ..._filtered.map((c) => _courseCard(context, c)),
        const SizedBox(height: 16),
      ]),
    );
  }

  Widget _courseCard(BuildContext context, Course c) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/course-detail', arguments: c.toMap()),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))]),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _courseThumb(c.thumbnail, c.category),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (c.isBestseller) Container(margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(4)),
              child: const Text('Bestseller', style: TextStyle(fontSize: 10, color: Color(0xFF92400E), fontWeight: FontWeight.bold))),
            Text(c.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.dark), maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(c.instructor, style: const TextStyle(fontSize: 11, color: AppColors.gray)),
            const SizedBox(height: 4),
            Row(children: [
              Text('⭐ ${c.rating}', style: const TextStyle(fontSize: 11, color: AppColors.gold)),
              Text('  •  ${c.students} students', style: const TextStyle(fontSize: 11, color: AppColors.gray)),
              const Spacer(),
              Text(c.price, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.purple)),
            ]),
          ])),
        ]),
      ),
    );
  }

  Widget _courseThumb(String url, String category) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(children: [
        CachedNetworkImage(
          imageUrl: url,
          width: 80,
          height: 60,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(
            width: 80,
            height: 60,
            color: AppColors.purple.withOpacity(0.15),
            child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
          errorWidget: (_, __, ___) => Container(
            width: 80,
            height: 60,
            color: AppColors.purple.withOpacity(0.15),
            child: const Icon(Icons.image_not_supported, color: AppColors.purple),
          ),
        ),
        Positioned(
          left: 6,
          bottom: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.55),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              category,
              style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ]),
    );
  }
}
