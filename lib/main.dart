import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/course_detail_screen.dart';
import 'screens/my_learning_screen.dart';
import 'screens/video_player_screen.dart';
import 'screens/instructor_screen.dart';
import 'screens/search_screen.dart';
import 'screens/wishlist_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/certificate_screen.dart';
import 'screens/profile_screen.dart';

// ══════════════════════════════════════════════════════════
// LEARNLY — Online Course Platform
// OS2 Project — Mansoura University 2025/2026
// Dr. Mohamed Handosa
// Account: Mirna Mohamed
//
// OS Concepts Applied (from lectures):
//   Ch05 Protection: RBAC, ACL, Access Matrix,
//                    Least Privilege, Capabilities
//   Ch06 Security:   Authentication, Encryption,
//                    PKI, Firewall, Audit Log, IDS
// ══════════════════════════════════════════════════════════

// ── BRAND COLORS ────────────────────────────────────────
class AppColors {
  static const purple  = Color(0xFF6C35DE);
  static const dPurple = Color(0xFF4A1FA8);
  static const orange  = Color(0xFFF97316);
  static const dark    = Color(0xFF1E1B4B);
  static const light   = Color(0xFFF5F3FF);
  static const bg      = Color(0xFFF8F7FF);
  static const gray    = Color(0xFF64748B);
  static const green   = Color(0xFF10B981);
  static const red     = Color(0xFFEF4444);
  static const gold    = Color(0xFFF59E0B);
  static const white   = Color(0xFFFFFFFF);
}

void main() {
  // Uncomment when Firebase is configured:
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const LearnlyApp());
}

class LearnlyApp extends StatelessWidget {
  const LearnlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learnly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.purple),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.bg,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.dark,
          foregroundColor: AppColors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.purple,
            foregroundColor: AppColors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/':           (_) => const SplashScreen(),
        '/login':      (_) => const LoginScreen(),
        '/register':   (_) => const RegisterScreen(),
        '/home':       (_) => const HomeScreen(),
        '/my-learning':(_) => const MyLearningScreen(),
        '/search':     (_) => const SearchScreen(),
        '/wishlist':   (_) => const WishlistScreen(),
        '/certificate':(_) => const CertificateScreen(),
        '/profile':    (_) => const ProfileScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/course-detail') {
          final course = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(builder: (_) => CourseDetailScreen(course: course));
        }
        if (settings.name == '/video-player') {
          final course = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(builder: (_) => VideoPlayerScreen(course: course));
        }
        if (settings.name == '/instructor') {
          final instructor = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(builder: (_) => InstructorScreen(instructor: instructor));
        }
        if (settings.name == '/checkout') {
          final course = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(builder: (_) => CheckoutScreen(course: course));
        }
        return null;
      },
    );
  }
}
