import 'package:createaccount/wordlist/chinese.dart';
import 'package:createaccount/wordlist/czech.dart';
import 'package:createaccount/wordlist/english.dart';
import 'package:createaccount/wordlist/frensh.dart';
import 'package:createaccount/wordlist/german.dart';
import 'package:createaccount/wordlist/italian.dart';
import 'package:createaccount/wordlist/japanese.dart';
import 'package:createaccount/wordlist/korean.dart';
import 'package:createaccount/wordlist/portuguese.dart';
import 'package:createaccount/wordlist/spanish.dart';

class Mnemonicwordlist {
  List<String> getwordlist(String lang) {
    List<String> wordlist = [];

    switch (lang) {
      case "en":
        wordlist = englishList;
        break;
      case "de":
        wordlist = germanList;
        break;
      case "es":
        wordlist = spanishList;
        break;
      case "fr":
        wordlist = frenchList;
        break;
      case "it":
        wordlist = italianList;
        break;
      case "ja":
        wordlist = japaneseList;
        break;
      case "ko":
        wordlist = koreanList;
        break;
      case "zh":
        wordlist = chineseList;
        break;
      case "pt":
        wordlist = portugueseList;
        break;
      case "cz":
        wordlist = czechList;
        break;
      default:
        wordlist = englishList;
    }

    return wordlist;
  }
}
