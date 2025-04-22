import 'package:auto_size_text/auto_size_text.dart';
import 'package:createaccount/datatypes/accountrequest.dart';
import 'package:createaccount/datatypes/globalstatus.dart';
import 'package:createaccount/networkaction.dart';
import 'package:createaccount/tools.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Step2 extends StatefulWidget {
  const Step2({super.key});

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  TextEditingController usernamecontroller = TextEditingController();
  bool isusernamevalid = false;
  bool isusernameavaribale = false;
  bool isNextButtonEnabled = false;
  bool loading = false;

  @override
  void initState() {
    //add listener to usernamecontroller for each change
    usernamecontroller.addListener(() {
      setState(() {
        isusernamevalid = Tools().isusernamevalid(usernamecontroller.text);
        //Check if username is valid after 2 seconds of no change
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Textbox for username and next button
    return Consumer<GlobalStatus>(builder: (context, globalstatus, child) {
      return Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AppLocalizations.of(context)!.usernamemustmatchformat}:",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "- ${AppLocalizations.of(context)!.usernamerule1}",
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "- ${AppLocalizations.of(context)!.usernamerule2}",
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: TextField(
              controller: usernamecontroller,
              style: const TextStyle(color: Colors.white),
              autofillHints: const [AutofillHints.password],
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.username,
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 3)),
                  fillColor: Colors.blueGrey,
                  filled: true),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Wrap(
            spacing: 20,
            direction: Axis.horizontal,
            children: [
              Icon(
                isusernamevalid ? Icons.check : Icons.close,
                color: isusernamevalid ? Colors.green : Colors.red,
              ),
              Text(
                AppLocalizations.of(context)!.usernamevalid,
                style: TextStyle(
                    color: isusernamevalid ? Colors.green : Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: isusernamevalid && !loading
                ? () async {
                    bool validusername =
                        Tools().isusernamevalid(usernamecontroller.text);
                    if (!validusername) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.black,
                            content: AutoSizeText(
                              AppLocalizations.of(context)!.usernameinvalid,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                        );
                      }
                      return;
                    }
                    //Check if username is unique
                    bool uniqueusername = await NetworkAction()
                        .isusernameunique(usernamecontroller.text);
                    if (!uniqueusername) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.black,
                            content: AutoSizeText(
                              AppLocalizations.of(context)!.usernameunavailable,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                        );
                      }

                      return;
                    }
                    //If valid and unique, go to next step
                    if (uniqueusername && validusername) {
                      globalstatus.choosenusername = usernamecontroller.text;
                      String pubkeyactive =
                          globalstatus.keypairActive.publicKey.toString();
                      String pubkeyowner =
                          globalstatus.keypairOwner.publicKey.toString();
                      setState(() {
                        loading = true;
                      });
                      AccountRequest request = await NetworkAction()
                          .requestaccount(
                              globalstatus.getCaptchaResponse!,
                              usernamecontroller.text,
                              pubkeyowner,
                              pubkeyactive);
                      if (request.message == "success") {
                        if (context.mounted) {
                          Provider.of<GlobalStatus>(context, listen: false)
                              .accountRequest = request;
                          Provider.of<GlobalStatus>(context, listen: false)
                              .setCurrentStep(3);
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.black,
                              content: AutoSizeText(
                                AppLocalizations.of(context)!.errorappeared,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          );
                        }
                      }
                      setState(() {
                        loading = false;
                      });
                    }
                  }
                 // Open Snackbar if username is not valid 
                : () {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black,
                          content: AutoSizeText(
                            AppLocalizations.of(context)!.usernameinvalid,
                            style:
                                const TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      );
                    }
                  },
            style: TextButton.styleFrom(
              backgroundColor: isusernamevalid && !loading
                  ? Colors.white
                  : Colors.white.withAlpha((0.5 * 255).toInt()),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: 12.0, horizontal: 24.0), 
            ),
            child: loading
                ? const CircularProgressIndicator(
                    color: Colors.black,
                  )
                : Text(
                    AppLocalizations.of(context)!.next,
                    style: const TextStyle(color: Colors.black, fontSize: 20, 
                        fontWeight: FontWeight.bold),
                  ),
          ),
        ],
      );
    });
  }
}
