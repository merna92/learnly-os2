import 'package:flutter/material.dart';
import '../main.dart';
import '../data/user_session.dart';

// Screen 12 — Ch05: Domain of Protection, Least Privilege, Ch06: Bell-LaPadula
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<UserSessionData> _sessionFuture;

  @override
  void initState() {
    super.initState();
    _sessionFuture = UserSession.load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('👤 Profile'),
      backgroundColor: AppColors.purple,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
      ),
    ),
    body: FutureBuilder<UserSessionData>(
      future: _sessionFuture,
      builder: (context, snap) {
        final user = snap.data ??
            const UserSessionData(
              name: 'Mirna Mohamed',
              email: 'mirna.mohamed@student.mans.eg',
              role: 'Student',
              clearance: 'Unclassified',
            );
        final initials = UserSession.initialsFromName(user.name);
        return ListView(children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.purple, AppColors.dPurple]),
            ),
            child: Column(children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: Colors.white24,
                child: Text(
                  initials,
                  style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                user.name,
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                user.email,
                style: const TextStyle(color: Colors.white60, fontSize: 12),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20)),
                child: Text(
                  '🎓 ${user.role}  •  Clearance: ${user.clearance}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _section('My Account'),
              _tile(Icons.lock, '🔐 Change Password', 'Update your password', () => Navigator.pushNamed(context, '/login')),
              _tile(Icons.fingerprint, '🛡 MFA Settings', 'Biometric authentication', () {}),
              _tile(Icons.devices, '📱 Session History', 'Manage active sessions', () {}),
              _tile(Icons.workspace_premium, '🏆 My Certificates', 'View earned certificates', () => Navigator.pushNamed(context, '/certificate')),
              const SizedBox(height: 16),
              _section('Learning'),
              _tile(Icons.play_circle_filled, '📚 My Courses', '3 enrolled', () => Navigator.pushNamed(context, '/my-learning')),
              _tile(Icons.favorite, '❤️ Wishlist', '3 saved courses', () => Navigator.pushNamed(context, '/wishlist')),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await UserSession.clear();
                    if (mounted) Navigator.pushReplacementNamed(context, '/login');
                  },
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text('Sign Out', style: TextStyle(color: Colors.red, fontSize: 15)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ]),
          ),
        ]);
      },
    ),
  );

  Widget _section(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(t, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.dark)),
      );

  Widget _tile(IconData icon, String title, String sub, VoidCallback onTap) => ListTile(
        leading: Icon(icon, color: AppColors.purple),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Text(sub, style: const TextStyle(fontSize: 11, color: AppColors.gray)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.gray),
        onTap: onTap,
      );
}
