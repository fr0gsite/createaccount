import 'package:createaccount/config.dart';
import 'package:createaccount/datatypes/globalstatus.dart';
import 'package:createaccount/l10n/app_localizations.dart';
import 'package:createaccount/networkaction.dart';
import 'package:createaccount/widget/creationprocess/step1.dart';
import 'package:createaccount/widget/creationprocess/step2.dart';
import 'package:createaccount/widget/creationprocess/step3.dart';
import 'package:createaccount/widget/disclaimer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreationProcess extends StatefulWidget {
  const CreationProcess({super.key});

  @override
  State<CreationProcess> createState() => _CreationProcessState();
}

class _CreationProcessState extends State<CreationProcess> {
  double iconsize = 100;

  List<Widget> steps = [
    const Step1(),
    const Step2(),
    const Step3(),
  ];

  @override
  void initState() {
    super.initState();

    //Get the number of available accounts
    NetworkAction().getavailableaccounts().then((value) {
      if(mounted){
        Provider.of<GlobalStatus>(context, listen: false).setAvailableAccounts(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<GlobalStatus>(
          builder: (context, globalstatus, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: globalstatus.availableaccounts >= 0 &&
                          globalstatus.currentStep == 1
                      ? Text(
                          "${globalstatus.availableaccounts} ${AppLocalizations.of(context)!.accountsthatcanbegeneratedtoday}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Container(),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppConfig.colorPrimary.withAlpha((0.5 * 255).toInt()),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: !globalstatus.acceptdisclaimer
                        ? Disclaimer()
                        : steps[globalstatus.currentStep - 1],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
