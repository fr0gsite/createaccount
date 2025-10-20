// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get language => 'Deutsch';

  @override
  String get countrycode => 'DE';

  @override
  String get thelanguage => 'Sprache';

  @override
  String get createaccount => 'Konto erstellen';

  @override
  String get usernamemustmatchformat =>
      'Benutzername muss diesem Format entsprechen';

  @override
  String get usernamerule1 => 'Buchstaben a - z (klein) und Zahlen von 1 - 5';

  @override
  String get usernamerule2 => 'max. 12 Zeichen';

  @override
  String get accountsavailable => 'Konten verfügbar';

  @override
  String get username => 'Benutzername';

  @override
  String get next => 'Weiter';

  @override
  String get usernamevalid => 'Benutzername gültig';

  @override
  String get usernameavaribale => 'Benutzername verfügbar';

  @override
  String get usernameinvalid =>
      'Benutzername ist ungültig. Bitte beachte das Format.';

  @override
  String get usernameunavailable => 'Benutzername existiert leider schon.';

  @override
  String get noaccountsavailable => 'Derzeit sind keine Konten verfügbar';

  @override
  String get privatekey => 'Privatschlüssel';

  @override
  String get publickey => 'Öffentlicher Schlüssel';

  @override
  String get pleasesavethiscredentials =>
      'Bitte speichern Sie diese Zugangsdaten, sonst gehen sie verloren';

  @override
  String get saveasfile => 'Als Datei speichern';

  @override
  String get copiedtoclipboard => 'In die Zwischenablage kopiert';

  @override
  String get pleasewait => 'Bitte warten';

  @override
  String get loading => 'Laden';

  @override
  String get loadingcaptcha => 'Lade Captcha';

  @override
  String get captchafaild => 'Captcha-Überprüfung fehlgeschlagen';

  @override
  String get errorappeared => 'Ein Fehler ist aufgetreten';

  @override
  String get slidepuzzle =>
      'Schieben Sie das Puzzleteil in die richtige Position';

  @override
  String get trylater =>
      'Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut';

  @override
  String get certwarning =>
      'Bewahren Sie dieses Zertifikat an einem sicheren Ort auf.\nGeben Sie es an niemanden weiter.\nMit diesem Zertifikat gewähren Sie vollen Zugriff auf Ihr Konto.';

  @override
  String get relatedpublickey => 'Zugehöriger öffentlicher Schlüssel';

  @override
  String get issued => 'Ausgestellt';

  @override
  String get withtransactionid => 'mit TransaktionsID';

  @override
  String get network => 'Netzwerk';

  @override
  String get certificate => 'ZERTIFIKAT';

  @override
  String get clicktocopy => 'Zum kopieren anklicken';

  @override
  String get activepermissionexplain => 'Für den täglichen Gebrauch';

  @override
  String get tologin => 'Zum Login';

  @override
  String get ownerpermissionexplain =>
      'Kann ACTIVE überschreiben. Im Falle eines Hacks oder des Verlusts von ACTIVE';

  @override
  String get retryagain => 'Erneut versuchen';

  @override
  String get connectionproblem => 'Uff, Verbindungsproblem';

  @override
  String get accountsthatcanbegeneratedtoday =>
      'Accounts die heute erzeugt werden können';

  @override
  String get disclaimer01 =>
      'Diese Plattform ist aktuell noch in der Beta Phase. Es können also Fehler auftreten oder Accounts dieser Plattform können sich ohne Vorankündigung verändern oder gelöscht werden.';

  @override
  String get accountsponsored => 'Account gesponsort von der Community';

  @override
  String get noacountavailable => 'Leider kann kein Account erzeugt werden.';
}
