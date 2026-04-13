import 'package:shared_preferences/shared_preferences.dart';

class UserSessionData {
  final String name;
  final String email;
  final String role;
  final String clearance;

  const UserSessionData({
    required this.name,
    required this.email,
    required this.role,
    required this.clearance,
  });
}

class UserSession {
  static const _kName = 'session_name';
  static const _kEmail = 'session_email';
  static const _kRole = 'session_role';
  static const _kClearance = 'session_clearance';

  static const _defaultName = 'Mirna Mohamed';
  static const _defaultEmail = 'mirna.mohamed@student.mans.eg';
  static const _defaultRole = 'Student';
  static const _defaultClearance = 'Unclassified';

  static Future<UserSessionData> load() async {
    final prefs = await SharedPreferences.getInstance();
    return UserSessionData(
      name: prefs.getString(_kName) ?? _defaultName,
      email: prefs.getString(_kEmail) ?? _defaultEmail,
      role: prefs.getString(_kRole) ?? _defaultRole,
      clearance: prefs.getString(_kClearance) ?? _defaultClearance,
    );
  }

  static Future<void> save({
    required String name,
    required String email,
    required String role,
    String clearance = _defaultClearance,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kName, name);
    await prefs.setString(_kEmail, email);
    await prefs.setString(_kRole, role);
    await prefs.setString(_kClearance, clearance);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kName);
    await prefs.remove(_kEmail);
    await prefs.remove(_kRole);
    await prefs.remove(_kClearance);
  }

  static String initialsFromName(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return 'NA';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }
}
