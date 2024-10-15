import 'package:flutter/material.dart';

class AppConfig {
  static const Color colorPrimary = Color(0xFF060716);
  static const Color colorSecondary = Color(0xFF161722);

  static const websiteurl = "https://fr0g.site";
  static const chainserverurl = "https://testnet.fr0g.site:8443";
  static const captchaserverurl = "https://captcha.fr0g.site:2096";
  static const captchacreateserverurl = "$captchaserverurl/puzzle";
  static const captchaverifyserverurl = "$captchaserverurl/puzzle/solution";
  static const createaccountserverurl = "https://accountserver.fr0g.site:8443";
  static const TextStyle titlestyle = TextStyle(
    color: Colors.white,
    fontSize: 30,
  );
  static const TextStyle subtitlestyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
  );
  static const TextStyle normaltextstyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  static List<AppLanguage> applanguage = [
    AppLanguage("international/none", "none"),
    AppLanguage("German", "de"),
    AppLanguage("English", "en"),
    AppLanguage("Français", "fr"),
    AppLanguage("Español", "es"),
    AppLanguage("Português", "pt"),
    AppLanguage("Русский", "ru"),
    AppLanguage("Українська", "uk"),
    AppLanguage("中文", "zh"),
    AppLanguage("日本語", "ja"),
    AppLanguage("اللغة العربية", "ar"),
    AppLanguage("हिन्दी", "hi"),
    AppLanguage("Italiano", "it"),
    AppLanguage("Čeština", "cs"),
  ];
}

class AppLanguage {
  final String languagename;
  final String countrycode;

  AppLanguage(this.languagename, this.countrycode);
}
