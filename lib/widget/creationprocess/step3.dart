
import 'package:archive/archive.dart';
import 'package:createaccount/config.dart';
import 'package:createaccount/datatypes/globalstatus.dart';
import 'package:createaccount/l10n/app_localizations.dart';
import 'package:createaccount/widget/printcert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

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
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!
                              .pleasesavethiscredentials,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  //Save as File button
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                          ),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.red),
                        ),
                        onPressed: () async {
                          Uint8List activecert = await printcert(
                              value.choosenusername,
                              "ACTIVE KEY",
                              "active",
                              value.keypairActive.publicKey.toString(),
                              value.keypairActive.privateKey.toString(),
                              value.accountRequest.transactionid,
                              context);

                          Uint8List ownercert = await printcert(
                              value.choosenusername,
                              "OWNER KEY",
                              "owner",
                              value.keypairOwner.publicKey.toString(),
                              value.keypairOwner.privateKey.toString(),
                              value.accountRequest.transactionid,
                              context);

                          final archive = Archive();

                          archive.addFile(ArchiveFile(
                            "Fr0gsite-${value.choosenusername}-ACTIVE.pdf",
                            activecert.length,
                            activecert,
                          ));
                          archive.addFile(ArchiveFile(
                            "Fr0gsite-${value.choosenusername}-OWNER.pdf",
                            ownercert.length,
                            ownercert,
                          ));

                          final zipBytes = ZipEncoder().encode(archive);
                          downloadZip(Uint8List.fromList(zipBytes),
                              "Fr0gsite-${value.choosenusername}.zip");
                        },
                        icon: const Icon(Icons.download, color: Colors.white),
                        label: Text(AppLocalizations.of(context)!.saveasfile,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.username}:",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: double
                              .infinity, // Ensures the container spans the full width
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Tooltip(
                            message:AppLocalizations.of(context)!.clicktocopy,
                            child: InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                        text: value.choosenusername))
                                    .then((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(AppLocalizations.of(context)!
                                          .copiedtoclipboard),
                                    ),
                                  );
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      value.choosenusername,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: usernameandkeysize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Active Key

                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      Icon(
                        Icons.key,
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
                            child: Tooltip(
                              message:
                                  AppLocalizations.of(context)!.clicktocopy,
                              child: Text(
                                "${value.keypairActive.privateKey.toString().substring(0, 10)} . . . ${value.keypairActive.privateKey.toString().substring(value.keypairActive.privateKey.toString().length - 10)}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: usernameandkeysize),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // Owner Key

                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),

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

                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      Icon(
                        Icons.key,
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
                            child: Tooltip(
                              message:
                                  AppLocalizations.of(context)!.clicktocopy,
                              child: Text(
                                "${value.keypairOwner.privateKey.toString().substring(0, 10)} . . . ${value.keypairOwner.privateKey.toString().substring(value.keypairOwner.privateKey.toString().length - 10)}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: usernameandkeysize),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Button to go to website
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.blue),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 24.0),
                      ),
                    ),
                    onPressed: () {
                      launchUrl(Uri.parse(AppConfig.websiteurl));
                    },
                    child: Wrap(
                      direction: Axis.horizontal,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      children: [
                        const Icon(
                          Icons.login,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(AppLocalizations.of(context)!.tologin,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void downloadZip(Uint8List zipBytes, String filename) {
    final blob = html.Blob([zipBytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", filename)
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
