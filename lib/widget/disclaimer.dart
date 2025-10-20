import 'package:auto_size_text/auto_size_text.dart';
import 'package:createaccount/datatypes/globalstatus.dart';
import 'package:createaccount/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Disclaimer extends StatefulWidget {
  const Disclaimer({super.key});

  @override
  State<Disclaimer> createState() => _DisclaimerState();
}

class _DisclaimerState extends State<Disclaimer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalStatus>(
      builder: (context, globalstatus, child) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Center(
            child: globalstatus.availableaccounts <= 0
                ? Text(
                    AppLocalizations.of(context)!.noaccountsavailable,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                : Column(
                    children: [
                      AutoSizeText(AppLocalizations.of(context)!.disclaimer01,
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Provider.of<GlobalStatus>(context, listen: false)
                              .setAcceptDisclaimer(true);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                        ),
                        child: Text(AppLocalizations.of(context)!.createaccount,
                            style:
                                TextStyle(color: Colors.black, fontSize: 20, 
                                    fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
