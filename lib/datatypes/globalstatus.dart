import 'package:createaccount/datatypes/accountrequest.dart';
import 'package:createaccount/datatypes/captcharesponse.dart';
import 'package:createaccount/datatypes/keypair.dart';
import 'package:createaccount/tools.dart';
import 'package:flutter/material.dart';

class GlobalStatus extends ChangeNotifier {
  bool requestcaptchtimeout = false;
  bool _isCaptchaVerified = false;
  int currentStep = 1;
  CaptchaResponse? captcharesponse;
  int availableaccounts = -1;
  bool acceptdisclaimer = false;

  String choosenusername = "";
  bool isusernamevalid = false;
  bool isusernameavailable = false;
  Keypair keypairActive = Tools().generatekeypair();
  Keypair keypairOwner = Tools().generatekeypair();
  AccountRequest accountRequest = AccountRequest.dummy();

  bool get isUsernameValid => isusernamevalid;
  bool get isUsernameAvailable => isusernameavailable;
  bool get isCaptchaVerified => _isCaptchaVerified;
  CaptchaResponse? get getCaptchaResponse => captcharesponse;

  void setCaptchaVerified(bool value) {
    _isCaptchaVerified = value;
    notifyListeners();
  }

  void setCurrentStep(int value) {
    currentStep = value;
    notifyListeners();
  }

  void setCaptchaResponse(CaptchaResponse value) {
    captcharesponse = value;
    notifyListeners();
  }

  void setAvailableAccounts(int value) {
    availableaccounts = value;
    notifyListeners();
  }

  void setAcceptDisclaimer(bool value) {
    acceptdisclaimer = value;
    notifyListeners();
  }

  void setkeypair(Keypair value) {
    keypairActive = value;
  }

  void setRequestcaptchtimeout(bool value) {
    requestcaptchtimeout = value;
    notifyListeners();
  }

  void generatephassphrase() {}
}
