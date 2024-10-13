import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:base_x/base_x.dart';
import 'package:createaccount/config.dart';
import 'package:createaccount/datatypes/globalstatus.dart';
import 'package:createaccount/networkaction.dart';
import 'package:createaccount/tools.dart';
import 'package:createaccount/wordlist/wordlist.dart';
import 'package:eosdart/eosdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Step3 extends StatefulWidget {
  const Step3({super.key});

  @override
  State<Step3> createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  @override
  void initState() {
    super.initState();
  }

  double iconsize = 40;
  double usernameandkeysize = 20;

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalStatus>(
      builder: (context, value, child) {
        //Show the keypair
        return Stack(
          children: [
            Positioned.fill(
              child: Lottie.asset(
                'assets/lottie/celebration.json',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                repeat: false,
              ),
            ),
            Wrap(
              spacing: 20,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.vertical,
              children: [
                Text(
                  AppLocalizations.of(context)!.pleasesavethiscredentials,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: iconsize,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      spacing: 2,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.username}:",
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(
                                    ClipboardData(text: value.choosenusername))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .copiedtoclipboard),
                                ),
                              );
                            });
                          },
                          child: Text(
                            value.choosenusername,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: usernameandkeysize),
                          ),
                        )
                      ],
                    ),
                  ],
                ),

                // Active Key

                Wrap(
                  direction: Axis.vertical,
                  spacing: 2,
                  children: [
                    const Text(
                      "ACTIVE PERMISSION",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      AppLocalizations.of(context)!.activepermissionexplain,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ],
                ),

                //Wrap(
                //  direction: Axis.vertical,
                //  spacing: 2,
                //  crossAxisAlignment: WrapCrossAlignment.start,
                //  children: [
                //    Text(
                //      "${AppLocalizations.of(context)!.publickey} :",
                //      style: const TextStyle(color: Colors.white),
                //    ),
                //    InkWell(
                //      onTap: () {
                //        Clipboard.setData(ClipboardData(
                //                text: value.keypairActive.publicKey.toString()))
                //            .then((_) {
                //          ScaffoldMessenger.of(context).showSnackBar(
                //            SnackBar(
                //              content: Text(AppLocalizations.of(context)!
                //                  .copiedtoclipboard),
                //            ),
                //          );
                //        });
                //      },
                //      child: Text(
                //        value.keypairActive.publicKey.toString(),
                //        style: const TextStyle(color: Colors.white),
                //      ),
                //    )
                //  ],
                //),
                Row(
                  children: [
                    Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: iconsize,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      spacing: 2,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.privatekey} :",
                          style: const TextStyle(color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(ClipboardData(
                                    text: value.keypairActive.privateKey
                                        .toString()))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .copiedtoclipboard),
                                ),
                              );
                            });
                          },
                          child: Text(
                            "${value.keypairActive.privateKey.toString().substring(0, 10)} . . . ${value.keypairActive.privateKey.toString().substring(value.keypairActive.privateKey.toString().length - 10)} (${AppLocalizations.of(context)!.clicktocopy})",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: usernameandkeysize),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                //Save as File button
                Wrap(
                  direction: Axis.horizontal,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await printcert(
                            value.choosenusername,
                            "ACTIVE KEY",
                            "active",
                            value.keypairActive.publicKey.toString(),
                            value.keypairActive.privateKey.toString(),
                            value.accountRequest.transactionid);
                      },
                      child: Text(AppLocalizations.of(context)!.saveasfile),
                    ),
                  ],
                ),

                // Owner Key

                Wrap(
                  direction: Axis.vertical,
                  spacing: 2,
                  children: [
                    const Text(
                      "OWNER PERMISSION",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      AppLocalizations.of(context)!.ownerpermissionexplain,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ],
                ),

                //Wrap(
                //  direction: Axis.vertical,
                //  spacing: 2,
                //  crossAxisAlignment: WrapCrossAlignment.start,
                //  children: [
                //    Text(
                //      "${AppLocalizations.of(context)!.publickey} :",
                //      style: const TextStyle(color: Colors.white),
                //    ),
                //    InkWell(
                //      onTap: () {
                //        Clipboard.setData(ClipboardData(
                //                text: value.keypairOwner.publicKey.toString()))
                //            .then((_) {
                //          ScaffoldMessenger.of(context).showSnackBar(
                //            SnackBar(
                //              content: Text(AppLocalizations.of(context)!
                //                  .copiedtoclipboard),
                //            ),
                //          );
                //        });
                //      },
                //      child: Text(
                //        value.keypairOwner.publicKey.toString(),
                //        style: const TextStyle(color: Colors.white),
                //      ),
                //    )
                //  ],
                //),
                Row(
                  children: [
                    Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: iconsize,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      spacing: 2,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.privatekey} :",
                          style: const TextStyle(color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(ClipboardData(
                                    text: value.keypairOwner.privateKey
                                        .toString()))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .copiedtoclipboard),
                                ),
                              );
                            });
                          },
                          child: Text(
                            "${value.keypairOwner.privateKey.toString().substring(0, 10)} . . . ${value.keypairOwner.privateKey.toString().substring(value.keypairOwner.privateKey.toString().length - 10)} (${AppLocalizations.of(context)!.clicktocopy})",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: usernameandkeysize),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                //Save as File button
                Wrap(
                  direction: Axis.horizontal,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await printcert(
                            value.choosenusername,
                            "OWNER KEY",
                            "owner",
                            value.keypairOwner.publicKey.toString(),
                            value.keypairOwner.privateKey.toString(),
                            value.accountRequest.transactionid);
                      },
                      child: Text(AppLocalizations.of(context)!.saveasfile),
                    ),
                  ],
                ),
                Container(),
                // Button to go to website
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    launchUrl(Uri.parse(AppConfig.websiteurl));
                  },
                  child: Text(AppLocalizations.of(context)!.tologin),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<Uint8List> loadAsset(String path) async {
    final byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List();
  }

  Future<bool> getTransactionBlock(String transactionid) async {
    TransactionBlock temp =
        await NetworkAction().requtestblockheightoftransaction(transactionid);

    if (temp.blockNum != 0) {
      return true;
    }
    return false;
  }

  Future<bool> printcert(
      String username,
      String permissiontitle,
      String permissionqr,
      String pubkey,
      String prikey,
      String transactionid) async {
    String lang = Localizations.localeOf(context).languageCode;

    final pdf = pw.Document();
    //final image = pw.MemoryImage(File('assets/certificate.jpg').readAsBytesSync());
    final imageBytes = await loadAsset('assets/certificate.jpg');
    final image = pw.MemoryImage(imageBytes);

    final qrimagepainterwebsite = QrPainter(
      data: AppConfig.websiteurl,
      version: QrVersions.auto,
    );

    final qrimagewebsitetoImage = await qrimagepainterwebsite.toImage(250);
    final qrimagewebsiteByteData =
        await qrimagewebsitetoImage.toByteData(format: ImageByteFormat.png);
    final qrimagewebsiteUint8List =
        qrimagewebsiteByteData!.buffer.asUint8List();
    // ignore: unused_local_variable
    final qrimagewebsite = pw.MemoryImage(qrimagewebsiteUint8List);

    final qrimagepaintercert = QrPainter(
      data: "fr0gsitecert:$username,$permissionqr,${prikey.toString()}",
      version: QrVersions.auto,
    );

    final qrimagecerttoImage = await qrimagepaintercert.toImage(250);
    final qrimagecertByteData =
        await qrimagecerttoImage.toByteData(format: ImageByteFormat.png);
    final qrimagecertUint8List = qrimagecertByteData!.buffer.asUint8List();
    final qrimagecert = pw.MemoryImage(qrimagecertUint8List);

    //Base58 to binary
    Uint8List temp =
        BaseXCodec('123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz')
            .decode(prikey.toString());

    //Binary array
    String binary = temp.map((e) => e.toRadixString(2)).join();

    //Cut in 11 bits
    List<String> bits = [];
    for (var i = 0; i < binary.length; i += 11) {
      if (i + 11 > binary.length) {
        bits.add(binary.substring(i, binary.length));
      } else {
        bits.add(binary.substring(i, i + 11));
      }
    }

    //Convert to decimal
    List<int> decimal = [];
    for (var i = 0; i < bits.length; i++) {
      decimal.add(int.parse(bits[i], radix: 2));
    }

    List<String> mnemonicwordlist = [];

    mnemonicwordlist = Mnemonicwordlist().getwordlist(lang);

    //Convert to mnemonic
    List<String> mnemonic = [];
    for (var i = 0; i < decimal.length; i++) {
      mnemonic.add(mnemonicwordlist[decimal[i]]);
    }

    //Multidimensional array. Max 4 words per line.
    List<List<String>> multidimensionalArray = [];

    int chunkSize = 4; // Sie können die Chunk-Größe nach Bedarf anpassen

    for (int i = 0; i < mnemonic.length; i += chunkSize) {
      if (mnemonic.length - i < chunkSize) {
        chunkSize = mnemonic.length - i;
      }

      List<String> chunk = mnemonic.sublist(i, i + chunkSize);

      List<String> formattedChunk = chunk.asMap().entries.map((entry) {
        int index = entry.key + i + 1;
        return "$index. ${entry.value}";
      }).toList();

      multidimensionalArray.add(formattedChunk);
    }

    final ttfregular = await Tools().getRegularFontforCertificate(lang);
    final ttfbold = await Tools().getBoldFontforCertificate(lang);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context bcontext) {
          return pw.FullPage(
            ignoreMargins: true,
            child: pw.Stack(children: [
              pw.Image(image, fit: pw.BoxFit.cover),
              pw.Center(
                child: pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 550),
                  child: pw.Text(
                      "$permissiontitle ${AppLocalizations.of(context)!.certificate}",
                      style: pw.TextStyle(
                        fontSize: 20,
                        font: ttfbold,
                      )),
                ),
              ),
              pw.Center(
                child: pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 500),
                  child: pw.Divider(
                      thickness: 1.0, // Dicke der Linie
                      color: PdfColors.black,
                      indent: 100,
                      endIndent: 100),
                ),
              ),
              pw.Positioned(
                top: 200,
                left: 250,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      AppLocalizations.of(context)!.network,
                      style: pw.TextStyle(fontSize: 12, font: ttfbold),
                    ),
                    pw.Text(
                      "fr0gsite v1.0",
                      style: pw.TextStyle(fontSize: 12, font: ttfregular),
                    ),
                  ],
                ),
              ),

              pw.Positioned(
                top: 200,
                left: 100,
                child: pw.Image(qrimagecert, width: 120, height: 120),
              ),

              pw.Positioned(
                top: 200,
                left: 400,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      AppLocalizations.of(context)!.username,
                      style: pw.TextStyle(fontSize: 12, font: ttfbold),
                    ),
                    pw.Text(
                      username,
                      style: pw.TextStyle(fontSize: 12, font: ttfregular),
                    ),
                  ],
                ),
              ),
              pw.Positioned(
                top: 280,
                left: 250,
                child: pw.Text(
                  AppLocalizations.of(context)!.certwarning,
                  style: pw.TextStyle(fontSize: 10, font: ttfbold),
                ),
              ),

              pw.Positioned(
                top: 340,
                left: 100,
                child: pw.Text(AppLocalizations.of(context)!.relatedpublickey,
                    style: pw.TextStyle(fontSize: 09, font: ttfbold)),
              ),
              pw.Positioned(
                top: 355,
                left: 100,
                child: pw.Text(
                  pubkey,
                  style: pw.TextStyle(fontSize: 9, font: ttfregular),
                ),
              ),

              pw.Center(
                child: pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 90),
                  child: pw.Divider(
                      thickness: 1.0,
                      color: PdfColors.black,
                      indent: 100,
                      endIndent: 100),
                ),
              ),
              pw.Center(
                child: pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 70),
                  child: pw.Text("MNEMONIC KEY",
                      style: pw.TextStyle(fontSize: 12, font: ttfbold)),
                ),
              ),

              //Mnemonic Key 28 words. 7 lines, 4 words each.
              pw.Center(
                child: pw.Container(
                  margin: const pw.EdgeInsets.only(top: 130, left: 80),
                  child: pw.TableHelper.fromTextArray(
                      context: bcontext,
                      cellAlignment: pw.Alignment.centerLeft,
                      headerCount: 0,
                      columnWidths: {
                        0: const pw.FixedColumnWidth(120),
                        1: const pw.FixedColumnWidth(120),
                        2: const pw.FixedColumnWidth(120),
                        3: const pw.FixedColumnWidth(120),
                      },
                      tableWidth: pw.TableWidth.min,
                      cellStyle: pw.TextStyle(fontSize: 10, font: ttfregular),
                      border: pw.TableBorder.all(style: pw.BorderStyle.none),
                      data: multidimensionalArray),
                ),
              ),

              pw.Center(
                child: pw.Container(
                  margin: const pw.EdgeInsets.only(top: 700),
                  child: pw.Text(
                    "${AppLocalizations.of(context)!.issued}: ${DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now())} ${AppLocalizations.of(context)!.withtransactionid}: $transactionid",
                    style: pw.TextStyle(fontSize: 7, font: ttfregular),
                  ),
                ),
              ),
            ]),
          );
        },
      ),
    );

    try {
      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat('yy-MM-dd-HH-mm-ss');
      String timestring = formatter.format(now);
      await Printing.sharePdf(
          bytes: await pdf.save(),
          filename: 'Fr0gsite-$username-$permissiontitle-$timestring.pdf');
      return true;
    } catch (e) {
      debugPrint("Error: $e");
      return false;
    }
  }
}
