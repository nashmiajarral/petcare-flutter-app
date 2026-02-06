import 'package:flutter/material.dart';

class AppColors {
  // ================= BRAND BLUE COLORS =================
  // Primary blue used for buttons, links, headings
  static const Color primary = Color(0xFF2563EB); // Blue-600
  static const Color primaryDark = Color(0xFF1E40AF); // Blue-800
  static const Color primaryLight = Color(0xFF93C5FD); // Blue-300

  // Accent (used in doctor cards background / subtle highlights)
  static const Color accent = Color(0xFFDBEAFE); // Light blue

  // ================= BACKGROUND COLORS =================
  static const Color background = Color(0xFFF8FAFC); // Page background
  static const Color scaffoldBackground = Colors.white;
  static const Color darkBackground = Color(0xFF1E293B); // Footer / dark sections

  // ================= TEXT COLORS =================
  static const Color textPrimary = Color(0xFF0F172A); // Dark blue-black
  static const Color textSecondary = Color(0xFF64748B); // Muted text
  static const Color textLight = Colors.white;

  // ================= COMMON =================
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;

  // ================= STATUS COLORS =================
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
}
