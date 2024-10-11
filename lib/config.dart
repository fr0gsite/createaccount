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
}
