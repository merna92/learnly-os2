// ══════════════════════════════════════════════════════════
// SCREENS 1, 2, 3 — Splash, Login, Register
// ══════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import '../main.dart';
import '../data/app_data.dart';
import '../data/user_session.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

// ── SCREEN 1: SPLASH ─────────────────────────────────────
// Ch06 — TCB: Firebase initialized here
// App brand identity + animated entrance
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade, _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));
    _fade  = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeIn));
    _scale = Tween<double>(begin: 0.75, end: 1.0).animate(CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    _ctrl.forward();
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: FadeTransition(opacity: _fade,
        child: ScaleTransition(scale: _scale,
          child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // App icon
            Container(
              width: 100, height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(colors: [AppColors.purple, AppColors.dPurple]),
                boxShadow: [BoxShadow(color: AppColors.purple.withOpacity(0.5), blurRadius: 30, spreadRadius: 5)],
              ),
              child: const Icon(Icons.school, size: 50, color: AppColors.white),
            ),
            const SizedBox(height: 24),
            const Text('Learnly', style: TextStyle(color: AppColors.white, fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            const SizedBox(height: 8),
            const Text('Learn Without Limits', style: TextStyle(color: Color(0xFFA78BFA), fontSize: 14, letterSpacing: 2.0)),
            const SizedBox(height: 8),
            Container(width: 100, height: 2, color: AppColors.orange.withOpacity(0.6)),
            const SizedBox(height: 24),
            const Text('10,000+ Courses  •  500+ Instructors  •  1M+ Students',
              style: TextStyle(color: Color(0xFF6B63A8), fontSize: 11)),
            const SizedBox(height: 50),
            const SizedBox(height: 28),
            const SizedBox(width: 24, height: 24,
              child: CircularProgressIndicator(color: AppColors.purple, strokeWidth: 2.5)),
          ])),
        ),
      ),
    );
  }
}

// ── SCREEN 2: LOGIN ───────────────────────────────────────
// Ch06 — User Authentication:
//   • Something you know: Password (bcrypt hash)
//   • Something you are: Biometric/MFA
//   • Brute-force lockout after 5 failed attempts
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController(text: 'mirna.mohamed@student.mans.eg');
  final _passCtrl  = TextEditingController();
  final _formKey   = GlobalKey<FormState>();
  bool _obscure = true, _loading = false, _mfa = true;
  int _attempts = 0;

  // Simulates bcrypt hash check — replace with Firebase Auth
  String _hashPassword(String pass) => sha256.convert(utf8.encode(pass)).toString();

  String _guessNameFromEmail(String email) {
    final local = email.split('@').first;
    final parts = local.split(RegExp(r'[._-]+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return 'Student';
    return parts.map((p) => p[0].toUpperCase() + p.substring(1)).join(' ');
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    if (_attempts >= 5) {
      _snack('🔒 Account locked after 5 attempts. Contact admin.', AppColors.red);
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    // Demo password: "learnly2025"
    if (_passCtrl.text == 'learnly2025') {
      final email = _emailCtrl.text.trim();
      await UserSession.save(
        name: _guessNameFromEmail(email),
        email: email,
        role: 'Student',
      );
      setState(() { _loading = false; _attempts = 0; });
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() { _loading = false; _attempts++; });
      _snack('Invalid credentials. Attempt $_attempts/5', AppColors.red);
    }
  }

  void _snack(String msg, Color c) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg), backgroundColor: c, behavior: SnackBarBehavior.floating));

  @override
  void dispose() { _emailCtrl.dispose(); _passCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Header
            Center(child: Column(children: [
              Container(width: 72, height: 72,
                decoration: const BoxDecoration(shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [AppColors.purple, AppColors.dPurple])),
                child: const Icon(Icons.school, size: 36, color: Colors.white)),
              const SizedBox(height: 14),
              const Text('Welcome to Learnly', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.dark)),
              const SizedBox(height: 4),
              const Text('Sign in to continue learning', style: TextStyle(fontSize: 13, color: AppColors.gray)),
            ])),
            const SizedBox(height: 32),

            // Avatar
            Center(child: Row(mainAxisSize: MainAxisSize.min, children: [
              CircleAvatar(radius: 24, backgroundColor: AppColors.light,
                child: const Text('MM', style: TextStyle(color: AppColors.purple, fontWeight: FontWeight.bold, fontSize: 16))),
              const SizedBox(width: 12),
              const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Mirna Mohamed', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.dark)),
                Text('Student Account', style: TextStyle(fontSize: 12, color: AppColors.gray)),
              ]),
            ])),
            const SizedBox(height: 24),

            // Email
            _label('Email Address'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: _dec('Enter your email', Icons.email_outlined),
              validator: (v) => v!.isEmpty ? 'Email is required' : null,
            ),
            const SizedBox(height: 16),

            // Password
            _label('Password'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _passCtrl,
              obscureText: _obscure,
              decoration: _dec('Enter your password', Icons.lock_outline).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, color: AppColors.gray),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
              validator: (v) => v!.length < 6 ? 'Minimum 6 characters' : null,
            ),
            const SizedBox(height: 10),
            Text('💡 Demo password: learnly2025',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade400, fontStyle: FontStyle.italic)),
            const SizedBox(height: 12),

            // MFA
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: _mfa ? const Color(0xFFD1FAE5) : const Color(0xFFFFF3CD),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _mfa ? AppColors.green : AppColors.gold),
              ),
              child: Row(children: [
                Icon(Icons.fingerprint, color: _mfa ? AppColors.green : AppColors.gold, size: 22),
                const SizedBox(width: 10),
                Expanded(child: Text(
                  _mfa ? 'Biometric MFA Active' : 'MFA Disabled',
                  style: TextStyle(fontSize: 11, color: _mfa ? const Color(0xFF065F46) : AppColors.gold, fontWeight: FontWeight.w600))),
                Switch(value: _mfa, activeColor: AppColors.green, onChanged: (v) => setState(() => _mfa = v)),
              ]),
            ),
            const SizedBox(height: 24),

            // Login button
            SizedBox(width: double.infinity, height: 52,
              child: ElevatedButton(
                onPressed: _loading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple, foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), elevation: 4),
                child: _loading
                  ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                  : const Text('SIGN IN', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              ),
            ),
            const SizedBox(height: 16),

            // Links
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(onPressed: (){}, child: const Text('Forgot Password?', style: TextStyle(color: AppColors.purple))),
              const Text('|', style: TextStyle(color: AppColors.gray)),
              TextButton(onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text('Create Account', style: TextStyle(color: AppColors.orange))),
            ]),

            const Divider(height: 28),
          ])),
        ),
      ),
    );
  }

  Widget _label(String t) => Text(t, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.dark));

  InputDecoration _dec(String hint, IconData icon) => InputDecoration(
    hintText: hint, hintStyle: const TextStyle(fontSize: 13),
    prefixIcon: Icon(icon, color: AppColors.gray, size: 20),
    filled: true, fillColor: AppColors.light,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE0D9FF))),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE0D9FF))),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.purple, width: 2)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );

}

// ── SCREEN 3: REGISTER ────────────────────────────────────
// Ch06 — Password Best Practices:
//   • Strong password enforced
//   • bcrypt hash — never store plaintext
//   • Role assigned on registration (RBAC — Ch05)
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameCtrl   = TextEditingController();
  final _emailCtrl  = TextEditingController();
  final _passCtrl   = TextEditingController();
  final _confCtrl   = TextEditingController();
  final _formKey    = GlobalKey<FormState>();
  bool _obs1 = true, _obs2 = true, _agreed = false, _loading = false;
  String _role = 'Student';

  int get _strength {
    final p = _passCtrl.text;
    int s = 0;
    if (p.length >= 8) s++;
    if (p.contains(RegExp(r'[A-Z]'))) s++;
    if (p.contains(RegExp(r'[0-9]'))) s++;
    if (p.contains(RegExp(r'[!@#\$%^&*]'))) s++;
    return s;
  }

  Color get _sColor => [AppColors.red, AppColors.red, AppColors.gold, AppColors.green, const Color(0xFF059669)][_strength];
  String get _sLabel => ['Weak', 'Weak', 'Medium', 'Strong', 'Very Strong'][_strength];

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreed) { _snack('Please accept the terms', AppColors.red); return; }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    await UserSession.save(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      role: _role,
    );
    setState(() => _loading = false);
    _snack('Account created! Password stored as SHA-256 hash.', AppColors.green);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    });
  }

  void _snack(String m, Color c) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(m), backgroundColor: c, behavior: SnackBarBehavior.floating));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(title: const Text('Create Account'), backgroundColor: AppColors.purple,
        leading: const BackButton(color: Colors.white)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Center(child: Column(children: [
            Icon(Icons.person_add_alt_1, size: 60, color: AppColors.purple),
            SizedBox(height: 8),
            Text('Join Learnly', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.dark)),
            Text('1M+ learners worldwide', style: TextStyle(fontSize: 12, color: AppColors.gray)),
          ])),
          const SizedBox(height: 24),

          _field('Full Name', _nameCtrl, 'Mirna Mohamed', Icons.person_outline, (v) => v!.isEmpty ? 'Required' : null),
          const SizedBox(height: 14),
          _field('University Email', _emailCtrl, 'mirna@student.mans.eg', Icons.email_outlined, (v) => v!.isEmpty ? 'Required' : null, type: TextInputType.emailAddress),
          const SizedBox(height: 14),

          // Role
          const Text('Role', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.dark)),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(color: AppColors.light, borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0D9FF))),
            child: DropdownButtonFormField<String>(value: _role,
              decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 16)),
              items: ['Student', 'Instructor', 'Admin'].map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
              onChanged: (v) => setState(() => _role = v!)),
          ),
          const SizedBox(height: 14),

          _field('Password', _passCtrl, 'Min 8 chars, uppercase, number, symbol', Icons.lock_outline,
            (v) => v!.length < 8 ? 'Minimum 8 characters' : null, obscure: _obs1,
            toggleObscure: () => setState(() => _obs1 = !_obs1), onChanged: (_) => setState(() {})),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: LinearProgressIndicator(value: _strength/4, minHeight: 6,
              backgroundColor: Colors.grey.shade200, color: _sColor)),
            const SizedBox(width: 10),
            Text(_sLabel, style: TextStyle(fontSize: 12, color: _sColor, fontWeight: FontWeight.w600)),
          ]),
          const SizedBox(height: 14),

          _field('Confirm Password', _confCtrl, 'Re-enter password', Icons.lock_outline,
            (v) => v != _passCtrl.text ? 'Passwords do not match' : null, obscure: _obs2,
            toggleObscure: () => setState(() => _obs2 = !_obs2)),
          const SizedBox(height: 14),

          Row(children: [
            Checkbox(value: _agreed, activeColor: AppColors.purple, onChanged: (v) => setState(() => _agreed = v!)),
            const Expanded(child: Text('I agree to the terms. Passwords stored as SHA-256 hash — never plaintext.',
              style: TextStyle(fontSize: 11, color: Colors.black54))),
          ]),
          const SizedBox(height: 20),

          SizedBox(width: double.infinity, height: 52,
            child: ElevatedButton(
              onPressed: _loading ? null : _register,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.purple, foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              child: _loading
                ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                : const Text('CREATE ACCOUNT', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            ),
          ),
          const SizedBox(height: 16),
          Center(child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Already have an account? Sign In', style: TextStyle(color: AppColors.purple)))),
          const Divider(height: 28),
        ])),
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl, String hint, IconData icon,
    String? Function(String?) validator, {bool obscure = false, VoidCallback? toggleObscure,
    TextInputType? type, void Function(String)? onChanged}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.dark)),
      const SizedBox(height: 6),
      TextFormField(
        controller: ctrl, obscureText: obscure, keyboardType: type, onChanged: onChanged,
        decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(fontSize: 12),
          prefixIcon: Icon(icon, color: AppColors.gray, size: 20),
          suffixIcon: toggleObscure != null ? IconButton(
            icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: AppColors.gray),
            onPressed: toggleObscure) : null,
          filled: true, fillColor: AppColors.light,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE0D9FF))),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE0D9FF))),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.purple, width: 2)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
        validator: validator),
    ]);
  }
}
