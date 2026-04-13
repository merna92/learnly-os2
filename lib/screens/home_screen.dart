// ══════════════════════════════════════════════════════════
// SCREEN 3 — HOME / DISCOVER
// Ch05 — RBAC: Student sees different content than Instructor
// Ch06 — Search history encrypted (AES concept)
// ══════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../main.dart';
import '../data/app_data.dart';
import '../data/user_session.dart';
import '../data/api_courses.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;
  int _navIndex = 0;
  late Future<UserSessionData> _sessionFuture;

  @override
  void initState() {
    super.initState();
    _sessionFuture = UserSession.load();
  }

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
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/search')),
          IconButton(icon: const Icon(Icons.notifications_outlined, color: Colors.white), onPressed: (){}),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/profile'),
            child: Container(margin: const EdgeInsets.only(right: 12),
              width: 36, height: 36,
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.purple.withOpacity(0.3),
                border: Border.all(color: AppColors.purple, width: 1.5)),
              child: Center(
                child: FutureBuilder<UserSessionData>(
                  future: _sessionFuture,
                  builder: (_, snap) {
                    final initials = UserSession.initialsFromName(snap.data?.name ?? 'Mirna Mohamed');
                    return Text(initials, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold));
                  },
                ),
              ))),
        ],
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
          child: FutureBuilder<UserSessionData>(
            future: _sessionFuture,
            builder: (_, snap) {
              final user = snap.data ??
                  const UserSessionData(
                    name: 'Mirna Mohamed',
                    email: 'mirna.mohamed@student.mans.eg',
                    role: 'Student',
                    clearance: 'Unclassified',
                  );
              final initials = UserSession.initialsFromName(user.name);
              return Row(children: [
                CircleAvatar(radius: 26, backgroundColor: Colors.white24,
                  child: Text(initials, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15))),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Hi, ${user.name.split(' ').first}! 👋', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  const Text('Continue where you left off', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text('Role: ${user.role}  •  3 active courses', style: const TextStyle(color: Colors.white54, fontSize: 11)),
                ])),
                GestureDetector(
                  onTap: () {
                    final c = kEnrolled[0]['course'] as Course;
                    Navigator.pushNamed(context, '/video-player', arguments: c.toMap());
                  },
                  child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: AppColors.orange, borderRadius: BorderRadius.circular(20)),
                    child: const Text('Resume →', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
                ),
              ]);
            },
          ),
        ),

        // Stats
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(children: [
            _stat('3', 'Enrolled', AppColors.purple),
            const SizedBox(width: 10),
            _stat('68%', 'Avg Progress', AppColors.green),
            const SizedBox(width: 10),
            _stat('1', 'Certificate', AppColors.gold),
          ])),
        const SizedBox(height: 20),

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

        // API Courses
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
          child: const Text('API Courses (REST Integration)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.dark))),
        const SizedBox(height: 8),
        SizedBox(
          height: 140,
          child: FutureBuilder<List<Course>>(
            future: ApiCourses.fetch(),
            builder: (context, snap) {
              final items = snap.data ?? [];
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (items.isEmpty) {
                return const Center(child: Text('No API data. Check connection.'));
              }
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (_, i) => _apiCard(context, items[i]),
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        // Course list
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('${_filtered.length} Courses', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.dark))),
        const SizedBox(height: 10),
        ..._filtered.map((c) => _courseCard(context, c)),
        const SizedBox(height: 16),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navIndex, onTap: (i) {
          setState(() => _navIndex = i);
          if (i == 1) Navigator.pushNamed(context, '/my-learning');
          if (i == 2) Navigator.pushNamed(context, '/wishlist');
          if (i == 3) Navigator.pushNamed(context, '/profile');
        },
        selectedItemColor: AppColors.purple, unselectedItemColor: AppColors.gray,
        type: BottomNavigationBarType.fixed, backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle_outline), label: 'My Learning'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _stat(String v, String l, Color c) => Expanded(
    child: Container(padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(12),
        border: Border.all(color: c.withOpacity(0.3))),
      child: Column(children: [
        Text(v, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: c)),
        const SizedBox(height: 2),
        Text(l, style: const TextStyle(fontSize: 10, color: Colors.black45), textAlign: TextAlign.center),
      ])));

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

  Widget _apiCard(BuildContext context, Course c) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/course-detail', arguments: c.toMap()),
      child: Container(
        width: 190,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: c.thumbnail,
              width: double.infinity,
              height: 70,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(height: 70, color: AppColors.purple.withOpacity(0.15)),
              errorWidget: (_, __, ___) => Container(
                height: 70,
                color: AppColors.purple.withOpacity(0.15),
                child: const Icon(Icons.image_not_supported, color: AppColors.purple),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(c.title, maxLines: 2, overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.dark)),
          const SizedBox(height: 2),
          Text(c.category, style: const TextStyle(fontSize: 10, color: AppColors.gray)),
          const Spacer(),
          Row(children: [
            Text('⭐ ${c.rating}', style: const TextStyle(fontSize: 10, color: AppColors.gold)),
            const Spacer(),
            Text(c.price, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.purple)),
          ]),
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
