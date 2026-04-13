import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../main.dart';
import '../data/app_data.dart';
// Screen 9 — Ch05: Revocation of access rights (remove from wishlist = selective revocation)
class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('❤️ Wishlist'), backgroundColor: const Color(0xFFEC4899),
      leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pushReplacementNamed(context, '/home'))),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      ...kWishlist.map((c) => Card(margin: const EdgeInsets.only(bottom: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: _courseThumb(c.thumbnail, c.category),
          title: Text(c.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          subtitle: Text('${c.instructor}  •  ${c.price}'),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.favorite, color: Color(0xFFEC4899), size: 20),
            const SizedBox(width: 8),
            ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/checkout', arguments: c.toMap()),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.orange, foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              child: const Text('Enroll', style: TextStyle(fontSize: 12))),
          ]),
          onTap: () => Navigator.pushNamed(context, '/course-detail', arguments: c.toMap())))),
    ]),
  );

  Widget _courseThumb(String url, String category) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(children: [
        CachedNetworkImage(
          imageUrl: url,
          width: 44,
          height: 44,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(color: AppColors.purple.withOpacity(0.15)),
          errorWidget: (_, __, ___) => Container(
            color: AppColors.purple.withOpacity(0.15),
            child: const Icon(Icons.image_not_supported, color: AppColors.purple, size: 20),
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
