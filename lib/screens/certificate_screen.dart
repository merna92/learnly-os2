import 'package:flutter/material.dart';
import '../main.dart';
import '../data/app_data.dart';
// Screen 11 — Ch06: Digital Certificates & PKI
class CertificateScreen extends StatelessWidget {
  const CertificateScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('🎓 Certificate'), backgroundColor: AppColors.gold, foregroundColor: Colors.black),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      Container(
        decoration: BoxDecoration(color: const Color(0xFFFFFBEB), borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.gold, width: 2),
          boxShadow: [BoxShadow(color: AppColors.gold.withOpacity(0.2), blurRadius: 12)]),
        child: Column(children: [
          Container(width: double.infinity, padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14))),
            child: const Center(child: Text('🎓 CERTIFICATE OF COMPLETION', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)))),
          const SizedBox(height: 20),
          const Text('This is to certify that', style: TextStyle(color: AppColors.gray, fontSize: 13)),
          const SizedBox(height: 8),
          const Text('Mirna Mohamed', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.purple)),
          const SizedBox(height: 8),
          const Text('has successfully completed', style: TextStyle(color: AppColors.gray)),
          const SizedBox(height: 8),
          const Text('Flutter & Dart — Complete Guide 2025', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.dark), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          const Text('Angela Yu  •  December 2025', style: TextStyle(color: AppColors.gray, fontSize: 13)),
          const Divider(height: 24),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Column(children: [
            _row('Issued by', 'Learnly Certificate Authority (CA)'),
            _row('Serial #', 'LRN-2025-MM-00123'),
            _row('Valid Until', '2030-12-01'),
            _row('Public Key', 'RSA-2048'),
            _row('Signature', 'SHA-256withRSA'),
          ])),
          const SizedBox(height: 16),
          Container(margin: const EdgeInsets.all(16), padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: const Row(children: [Icon(Icons.verified, color: AppColors.green), SizedBox(width: 8), Text('✅ Certificate is Valid and Trusted', style: TextStyle(color: AppColors.green, fontWeight: FontWeight.bold))])),
          Padding(padding: const EdgeInsets.all(16), child: ElevatedButton.icon(onPressed: (){},
            icon: const Icon(Icons.download), label: const Text('Download PDF Certificate'),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.purple, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 46),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))))),
        ])),
      const SizedBox(height: 16),
    ]),
  );
  Widget _row(String k, String v) => Padding(padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [SizedBox(width: 80, child: Text('$k:', style: const TextStyle(color: AppColors.gray, fontSize: 12))),
      Expanded(child: Text(v, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)))]));
}
