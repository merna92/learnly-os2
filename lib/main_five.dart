import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/course_detail_screen.dart';
import 'screens/home_screen_five.dart';
import 'main.dart';

void main() {
  runApp(const LearnlyFiveApp());
}

class LearnlyFiveApp extends StatelessWidget {
  const LearnlyFiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learnly (5 Screens)',
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
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/home': (_) => const HomeScreenFive(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/course-detail') {
          final course = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(builder: (_) => CourseDetailScreen(course: course));
        }
        return null;
      },
    );
  }
}
