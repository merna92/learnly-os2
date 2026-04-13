import 'package:flutter/material.dart';
import '../main.dart';
import '../data/app_data.dart';
// Screen 10 — Ch06: Encrypted payment (HTTPS), Hash (card data), PKI (SSL cert)
class CheckoutScreen extends StatelessWidget {
  final Map<String, dynamic> course;
  const CheckoutScreen({required this.course, super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('🔒 Checkout'), backgroundColor: AppColors.orange, leading: const BackButton(color: Colors.white)),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.orange.withOpacity(0.3))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Order Summary', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.dark)),
          const SizedBox(height: 10),
          Text(course['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.dark)),
          Text('${course['instructor']}  •  ⭐${course['rating']}', style: const TextStyle(color: AppColors.gray, fontSize: 12)),
          const Divider(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Price:', style: TextStyle(color: AppColors.gray)),
            Text(course['price'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.purple, fontSize: 16)),
          ]),
        ])),
      const SizedBox(height: 16),
      const Text('Payment Method', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.dark)),
      const SizedBox(height: 8),
      ...['💳 Visa ****4242', '🏦 Fawry Pay', '📱 Vodafone Cash'].map((m) => RadioListTile<String>(
        value: m, groupValue: '💳 Visa ****4242', onChanged: (_){},
        title: Text(m), activeColor: AppColors.purple)),
      const SizedBox(height: 16),
      SizedBox(width: double.infinity, height: 50,
        child: ElevatedButton.icon(onPressed: (){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('✅ Enrolled! Welcome to the course.'), backgroundColor: AppColors.green));
          Future.delayed(const Duration(seconds: 1), () => Navigator.pushReplacementNamed(context, '/my-learning'));
        },
          icon: const Icon(Icons.lock), label: const Text('COMPLETE PURCHASE', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.orange, foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))))),
      const SizedBox(height: 12),
    ]),
  );
}
