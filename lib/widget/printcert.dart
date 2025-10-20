import 'dart:ui';

import 'package:base_x/base_x.dart';
import 'package:createaccount/config.dart';
import 'package:createaccount/l10n/app_localizations.dart';
import 'package:createaccount/tools.dart';
import 'package:createaccount/wordlist/wordlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qr_flutter/qr_flutter.dart';
  
  Future<Uint8List> printcert(
      String username,
      String permissiontitle,
      String permissionqr,
      String pubkey,
      String prikey,
      String transactionid,
      context) async {
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

    int chunkSize = 4; // You can adjust the chunk size as needed

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
                      thickness: 1.0, // Line thickness
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

    return await pdf.save();
  }

  Future<Uint8List> loadAsset(String path) async {
    final byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List();
  }