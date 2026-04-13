import 'dart:convert';
import 'package:http/http.dart' as http;
import 'app_data.dart';

class ApiCourses {
  static const _endpoint = 'https://dummyjson.com/products?limit=6';

  static Future<List<Course>> fetch() async {
    final res = await http.get(Uri.parse(_endpoint));
    if (res.statusCode != 200) return [];
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    final list = (data['products'] as List<dynamic>?) ?? [];
    return list.map((p) {
      final m = p as Map<String, dynamic>;
      final id = m['id'].toString();
      final title = (m['title'] ?? 'Course') as String;
      final category = (m['category'] ?? 'General') as String;
      final price = m['price'] != null ? '\$${m['price']}' : 'Free';
      final rating = (m['rating'] ?? 4.5).toString();
      final students = (m['stock'] ?? 1200).toString();
      final thumbnail = (m['thumbnail'] ?? '') as String;
      final description = (m['description'] ?? 'Course overview from API.') as String;
      return Course(
        id: 'api_$id',
        title: title,
        instructor: 'API Partner',
        instructorAvatar: 'AP',
        category: _normalizeCategory(category),
        description: description,
        thumbnail: thumbnail,
        price: price,
        rating: rating,
        students: students,
        duration: '8 hours',
        level: 'Beginner',
        lectures: 40,
        whatYouLearn: const [
          'Hands-on projects and practice',
          'Real-world examples from the API',
          'Downloadable resources',
          'Certificate of completion',
          'Community Q&A support',
        ],
      );
    }).toList();
  }

  static String _normalizeCategory(String raw) {
    final c = raw.toLowerCase();
    if (c.contains('phone') || c.contains('smartphone')) return 'Development';
    if (c.contains('laptop') || c.contains('electronics')) return 'Cloud';
    if (c.contains('beauty') || c.contains('fragrance')) return 'Design';
    if (c.contains('groceries') || c.contains('kitchen')) return 'Business';
    return 'Development';
  }
}
