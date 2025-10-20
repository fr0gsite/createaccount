import 'dart:convert';

import 'package:createaccount/config.dart';
import 'package:createaccount/datatypes/accountrequest.dart';
import 'package:createaccount/datatypes/puzzle.dart';
import 'package:createaccount/datatypes/captcharesponse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eosdart/eosdart.dart';

class NetworkAction {
  int getcurrentavailableaccountnumber() {
    return 0;
  }

  Future<bool> isusernameunique(String text) async {
    EOSClient client =
        EOSClient(AppConfig.chainserverurl, "v1", privateKeys: []);

    try {
      // ignore: unused_local_variable
      var test = await client.getAccount(text);
      return false;
    } catch (e) {
      return true;
    }
  }

  Future<CaptchaResponse> verifycaptcha(String id, double xvalue) async {
    var url = Uri.parse(AppConfig.captchaverifyserverurl);

    var requestBody = jsonEncode({
      "id": id.toString(),
      "x": xvalue,
    });

    try {
      var response = await http.post(url, body: requestBody, headers: {
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        CaptchaResponse verifyCaptchaResponse =
            CaptchaResponse.fromJson(json.decode(response.body));
        debugPrint(
            "Captcha verified. id: ${verifyCaptchaResponse.id} UUID: ${verifyCaptchaResponse.uuid}");

        if (verifyCaptchaResponse.message == "VERIFIED!") {
          return verifyCaptchaResponse;
        }
      } else {
        debugPrint("Captcha verification failed");
        return CaptchaResponse.dummy();
      }
    } catch (e) {
      debugPrint("Error: $e");
    }

    return CaptchaResponse.dummy();
  }

  Future<Puzzle> getcaptcha() async {
    debugPrint("Request Captcha");
    try {
      final response = await http
          .get(Uri.parse(AppConfig.captchacreateserverurl))
          .timeout(Duration(seconds: 10), onTimeout: () {
        return http.Response("{}", 408);
      });
      debugPrint("Captcha received");
      if (response.statusCode == 200) {
        return Puzzle.fromJson(json.decode(response.body));
      } else {
        debugPrint('Failed to load puzzle');
        return Puzzle.dummy();
      }
    } catch (e) {
      return Puzzle.dummy();
    }
  }

  Future<AccountRequest> requestaccount(CaptchaResponse response,
      String username, String pubkeyowner, String pubkeyactive) async {
    var url = Uri.parse('${AppConfig.createaccountserverurl}/createaccount');

    var requestBody = jsonEncode({
      "id": response.id,
      "uuid": response.uuid,
      "username": username,
      "pubkeyowner": pubkeyowner,
      "pubkeyactive": pubkeyactive,
    });

    try {
      var response = await http.post(url, body: requestBody, headers: {
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 201) {
        AccountRequest accountRequest =
            AccountRequest.fromJson(json.decode(response.body));
        debugPrint("Account requested");

        return accountRequest;
      } else {
        debugPrint("Account request failed");
        return AccountRequest.dummy();
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
    return AccountRequest.dummy();
  }

  Future<TransactionBlock> requtestblockheightoftransaction(
      String transactionid) async {
    EOSClient client =
        EOSClient(AppConfig.chainserverurl, "v1", privateKeys: []);
    try {
      TransactionBlock temp = await client.getTransaction(transactionid);
      return temp;
    } catch (e) {
      debugPrint("requtestblockheightoftransaction Error: $e");
      return TransactionBlock.fromJson(json.decode('{"block_num":0}'));
    }
  }

  Future<int> getavailableaccounts() async {
    var url =
        Uri.parse('${AppConfig.createaccountserverurl}/remainingaccounts');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Success: The response is being processed
        final data = json.decode(response.body);

        int remainingAccounts = data['remainingAccounts'];
        //return 0;
        return remainingAccounts;
      } else {
        // Error: Server returned a different status code
        debugPrint(
            'Failed to fetch remaining accounts. Status code: ${response.statusCode}');
        return -1;
      }
    } catch (error) {
      // Error with the network request
      debugPrint('Error fetching remaining accounts: $error');
      return -1;
    }
  }
}
