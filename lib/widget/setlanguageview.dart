import 'package:country_flags/country_flags.dart';
import 'package:createaccount/config.dart';
import 'package:createaccount/datatypes/globalstatus.dart';
import 'package:createaccount/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SetLanguageView extends StatelessWidget {
  const SetLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            color: Colors.black38,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Center(
            child: SingleChildScrollView(
                child: SizedBox(
          width: 500,
          height: 700,
          child: Material(
            color: Colors.black,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                side: BorderSide(
                    color: Colors.white, width: 6, strokeAlign: 4.0)),
            child: ListView.builder(
              itemCount: L10n.all.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Center(
                      child: Row(
                    children: [
                      //Icon flag
                      CountryFlag.fromCountryCode(
                        L10n.all[index].countryCode ?? 'US',
                      ),
                      const SizedBox(width: 20),
                      Text(
                        AppConfig.applanguage
                            .where((element) =>
                                element.countrycode ==
                                L10n.all[index].languageCode)
                            .first
                            .languagename,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
                  onTap: () {
                    Provider.of<GlobalStatus>(context, listen: false)
                        .setLanguage(
                      Locale.fromSubtags(
                          languageCode: L10n.all[index].languageCode,
                          countryCode: L10n.all[index].countryCode),
                    );
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ))),
      ],
    );
  }
}
