import 'package:eosdart_ecc/eosdart_ecc.dart';

class Keypair {
  EOSPrivateKey privateKey;
  EOSPublicKey publicKey;

  Keypair({required this.publicKey, required this.privateKey});
}
