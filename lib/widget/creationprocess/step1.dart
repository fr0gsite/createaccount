import 'package:auto_size_text/auto_size_text.dart';
import 'package:createaccount/datatypes/globalstatus.dart';
import 'package:createaccount/datatypes/puzzle.dart';
import 'package:createaccount/datatypes/captcharesponse.dart';
import 'package:createaccount/l10n/app_localizations.dart';
import 'package:createaccount/networkaction.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:slider_captcha/slider_captcha.dart';

class Step1 extends StatefulWidget {
  const Step1({super.key});

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  Future<bool> getcaptchafuture = Future.value(false);
  late Puzzle puzzle;
  bool done = false;

  @override
  void initState() {
    super.initState();
    getcaptchafuture = getcaptcha();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<GlobalStatus>(
        builder: (context, globalstatus, child) {
          globalstatus.generatephassphrase();

          return FutureBuilder(
            future: getcaptchafuture.timeout(const Duration(seconds: 10),
                onTimeout: () {
              debugPrint("Timeout");
              return false;
            }),
            builder: (context, snapshot) {
              if (done) {
                return Column(
                  children: [
                    AutoSizeText(
                      AppLocalizations.of(context)!.slidepuzzle,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 500,
                      child: SliderCaptchaClient(
                        provider: SliderCaptchaClientProvider(
                          puzzleBase64: puzzle.puzzleImage,
                          pieceBase64: puzzle.pieceImage,
                          coordinatesY: puzzle.y,
                        ),
                        onConfirm: (value) async {
                          /// Can you verify captcha at here
                          CaptchaResponse response = await NetworkAction()
                              .verifycaptcha(puzzle.id, value);
                          if (response.message == "VERIFIED!") {
                            if (mounted) {
                              globalstatus.setCaptchaVerified(true);
                              globalstatus.setCurrentStep(2);
                              globalstatus.setCaptchaResponse(response);
                            }
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.black,
                                  content: AutoSizeText(
                                    AppLocalizations.of(context)!.captchafaild,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              );
                            }
                            getcaptcha();
                          }
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return SizedBox(
                  width: 500,
                  child: Consumer<GlobalStatus>(
                    builder: (context, globalstatus, child) {
                      if (!globalstatus.requestcaptchtimeout) {
                        return Column(
                          children: [
                            const AutoSizeText(
                              "Loading...",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            SizedBox(
                              height: 300,
                              width: 300,
                              child: Lottie.asset('assets/fr0g/12.json'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AutoSizeText(
                              AppLocalizations.of(context)!.connectionproblem,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                getcaptcha();
                                globalstatus.setRequestcaptchtimeout(false);
                              },
                              child: AutoSizeText(
                                AppLocalizations.of(context)!.retryagain,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  Future<bool> getcaptcha() async {
    if (done) {
      setState(() {
        done = false;
      });
    }
    Puzzle temp = await NetworkAction().getcaptcha();
    if (temp.id != "1") {
      setState(() {
        puzzle = temp;
        done = true;
        debugPrint("Puzzle: ${puzzle.id}");
      });
      return false;
    }
    if(mounted){
      Provider.of<GlobalStatus>(context, listen: false).setCaptchaVerified(false);
      Provider.of<GlobalStatus>(context, listen: false)
          .setRequestcaptchtimeout(true);
    }
    return true;
  }
}
