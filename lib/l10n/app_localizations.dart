import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('cs'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('pt'),
    Locale('ru'),
    Locale('uk'),
    Locale('zh'),
    Locale('hi'),
  ];

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// No description provided for @countrycode.
  ///
  /// In en, this message translates to:
  /// **'US'**
  String get countrycode;

  /// No description provided for @thelanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get thelanguage;

  /// No description provided for @createaccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createaccount;

  /// No description provided for @usernamemustmatchformat.
  ///
  /// In en, this message translates to:
  /// **'Username must match this format'**
  String get usernamemustmatchformat;

  /// No description provided for @usernamerule1.
  ///
  /// In en, this message translates to:
  /// **'Letters a - z (small) and numbers from 1 - 5'**
  String get usernamerule1;

  /// No description provided for @usernamerule2.
  ///
  /// In en, this message translates to:
  /// **'max. 12 characters'**
  String get usernamerule2;

  /// No description provided for @accountsavailable.
  ///
  /// In en, this message translates to:
  /// **'Accounts available'**
  String get accountsavailable;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @usernamevalid.
  ///
  /// In en, this message translates to:
  /// **'Username valid'**
  String get usernamevalid;

  /// No description provided for @usernameavaribale.
  ///
  /// In en, this message translates to:
  /// **'Username avaribale'**
  String get usernameavaribale;

  /// No description provided for @usernameinvalid.
  ///
  /// In en, this message translates to:
  /// **'Username is invalid. Please note the format.'**
  String get usernameinvalid;

  /// No description provided for @usernameunavailable.
  ///
  /// In en, this message translates to:
  /// **'Username unfortunately already exists.'**
  String get usernameunavailable;

  /// No description provided for @noaccountsavailable.
  ///
  /// In en, this message translates to:
  /// **'Currently no Accounts are available'**
  String get noaccountsavailable;

  /// No description provided for @privatekey.
  ///
  /// In en, this message translates to:
  /// **'Privatekey'**
  String get privatekey;

  /// No description provided for @publickey.
  ///
  /// In en, this message translates to:
  /// **'Publickey'**
  String get publickey;

  /// No description provided for @pleasesavethiscredentials.
  ///
  /// In en, this message translates to:
  /// **'Please save this credentials\notherwise they will be lost'**
  String get pleasesavethiscredentials;

  /// No description provided for @saveasfile.
  ///
  /// In en, this message translates to:
  /// **'Save as File'**
  String get saveasfile;

  /// No description provided for @copiedtoclipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to the clipboard'**
  String get copiedtoclipboard;

  /// No description provided for @pleasewait.
  ///
  /// In en, this message translates to:
  /// **'Please wait'**
  String get pleasewait;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @loadingcaptcha.
  ///
  /// In en, this message translates to:
  /// **'Loading Captcha'**
  String get loadingcaptcha;

  /// No description provided for @captchafaild.
  ///
  /// In en, this message translates to:
  /// **'Captcha verification failed'**
  String get captchafaild;

  /// No description provided for @errorappeared.
  ///
  /// In en, this message translates to:
  /// **'An error has appeared'**
  String get errorappeared;

  /// No description provided for @slidepuzzle.
  ///
  /// In en, this message translates to:
  /// **'Slide the puzzle piece to the correct position'**
  String get slidepuzzle;

  /// No description provided for @trylater.
  ///
  /// In en, this message translates to:
  /// **'Please try again at a later time'**
  String get trylater;

  /// No description provided for @certwarning.
  ///
  /// In en, this message translates to:
  /// **'Store this certificate in a safe place.\nDon\'t share it with anyone.\nWith this certificate you grant full access to your account.'**
  String get certwarning;

  /// No description provided for @relatedpublickey.
  ///
  /// In en, this message translates to:
  /// **'Related Public Key'**
  String get relatedpublickey;

  /// No description provided for @issued.
  ///
  /// In en, this message translates to:
  /// **'Issued'**
  String get issued;

  /// No description provided for @withtransactionid.
  ///
  /// In en, this message translates to:
  /// **'with TransactionID'**
  String get withtransactionid;

  /// No description provided for @network.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get network;

  /// No description provided for @certificate.
  ///
  /// In en, this message translates to:
  /// **'CERTIFICATE'**
  String get certificate;

  /// No description provided for @clicktocopy.
  ///
  /// In en, this message translates to:
  /// **'Click to copy'**
  String get clicktocopy;

  /// No description provided for @clicktocopyfullykey.
  ///
  /// In en, this message translates to:
  /// **'Click to copy full key to clipboard'**
  String get clicktocopyfullykey;

  /// No description provided for @activepermissionexplain.
  ///
  /// In en, this message translates to:
  /// **'For daily use'**
  String get activepermissionexplain;

  /// No description provided for @tologin.
  ///
  /// In en, this message translates to:
  /// **'To login'**
  String get tologin;

  /// No description provided for @ownerpermissionexplain.
  ///
  /// In en, this message translates to:
  /// **'Can overwrite ACTIVE. In case of hack or lost of ACTIVE permission'**
  String get ownerpermissionexplain;

  /// No description provided for @retryagain.
  ///
  /// In en, this message translates to:
  /// **'Retry again'**
  String get retryagain;

  /// No description provided for @connectionproblem.
  ///
  /// In en, this message translates to:
  /// **'Uff, Connection Problem'**
  String get connectionproblem;

  /// No description provided for @accountsthatcanbegeneratedtoday.
  ///
  /// In en, this message translates to:
  /// **'Accounts that can be generated today'**
  String get accountsthatcanbegeneratedtoday;

  /// No description provided for @disclaimer01.
  ///
  /// In en, this message translates to:
  /// **'This platform is currently still in the beta phase. Errors may occur, or accounts on this platform may change or be deleted without notice.'**
  String get disclaimer01;

  /// No description provided for @accountsponsored.
  ///
  /// In en, this message translates to:
  /// **'Account sponsored by the community'**
  String get accountsponsored;

  /// No description provided for @noacountavailable.
  ///
  /// In en, this message translates to:
  /// **'Unfortunately, no account can be generated.'**
  String get noacountavailable;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'cs',
    'de',
    'en',
    'es',
    'fr',
    'it',
    'ja',
    'pt',
    'ru',
    'uk',
    'zh',
    'hi',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'cs':
      return AppLocalizationsCs();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'uk':
      return AppLocalizationsUk();
    case 'zh':
      return AppLocalizationsZh();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
