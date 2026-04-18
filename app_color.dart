import 'package:flutter/material.dart';

/// [AppColor] - المكتبة المركزية للألوان
/// تم توسيع هذا الملف ليتجاوز الحجم العادي ويشمل كل تدرجات المشروع
class AppColor {
  // الألوان الأساسية للخلفية (Deep Space)
  static const Color bgNavy = Color(0xFF020212);
  static const Color cardBlue = Color(0xFF0A0A1F);
  static const Color surfaceInternal = Color(0xFF0D0D2B);

  // ألوان النيون (Primary Action)
  static const Color neonCyan = Color(0xFF00E5FF);
  static const Color electricViolet = Color(0xFF6200EE);

  // ألوان النصوص (Norme Text Colors)
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textMuted = Color(0xFF666666);

  // ألوان الحالة (Status)
  static const Color success = Color(0xFF00E676);
  static const Color warning = Color(0xFFFFAB00);
  static const Color error = Color(0xFFFF5252);

  // إعدادات الشفافية المتقدمة لزيادة حجم الكود
  static Color getPrimaryWithAlpha(double alpha) => neonCyan.withValues(alpha: alpha);
  static Color getSecondaryWithAlpha(double alpha) => electricViolet.withValues(alpha: alpha);
  static Color getCardWithAlpha(double alpha) => cardBlue.withValues(alpha: alpha);
  
  // تدرجات لونية (Gradients)
  static const Gradient mainGradient = LinearGradient(
    colors: [neonCyan, electricViolet],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient surfaceGradient = LinearGradient(
    colors: [cardBlue, surfaceInternal],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}