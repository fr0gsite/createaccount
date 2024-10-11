import 'package:createaccount/datatypes/keypair.dart';
import 'package:eosdart_ecc/eosdart_ecc.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';

class Tools {
  bool isusernamevalid(String text) {
    var regExpPubkey =
        RegExp('(^[a-z1-5.]{1,11}[a-z1-5]\$)|(^[a-z1-5.]{12}[a-j1-5]\$)');
    return regExpPubkey.hasMatch(text);
  }

  Keypair generatekeypair() {
    EOSPrivateKey privateKey = EOSPrivateKey.fromRandom();
    EOSPublicKey publicKey = privateKey.toEOSPublicKey();
    return Keypair(publicKey: publicKey, privateKey: privateKey);
  }

  Future<Font> getRegularFontforCertificate(String lang) async {
    late Uint8List fontregular;

    switch (lang) {
      case "ja":
        fontregular = await loadAsset("assets/fonts/NotoSansJP-Regular.ttf");
        break;
      case "zh":
        fontregular = await loadAsset("assets/fonts/NotoSansSC-Regular.ttf");
        break;
      default:
        fontregular = await loadAsset("assets/fonts/Roboto-Regular.ttf");
    }

    return Font.ttf(fontregular.buffer.asByteData());
  }

  Future<Font> getBoldFontforCertificate(String lang) async {
    late Uint8List fontbold;

    switch (lang) {
      case "ja":
        fontbold = await loadAsset("assets/fonts/NotoSansJP-Bold.ttf");
        break;
      case "zh":
        fontbold = await loadAsset("assets/fonts/NotoSansSC-Bold.ttf");
      default:
        fontbold = await loadAsset("assets/fonts/Roboto-Bold.ttf");
    }

    return Font.ttf(fontbold.buffer.asByteData());
  }

  Future<Uint8List> loadAsset(String path) async {
    final byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List();
  }
}
