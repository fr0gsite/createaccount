// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get language => 'Русский';

  @override
  String get countrycode => 'RU';

  @override
  String get thelanguage => 'Язык';

  @override
  String get createaccount => 'Создать учетную запись';

  @override
  String get usernamemustmatchformat =>
      'Имя пользователя должно соответствовать этому формату';

  @override
  String get usernamerule1 => 'Буквы a - z (строчные) и цифры от 1 до 5';

  @override
  String get usernamerule2 => 'Максимум 12 символов';

  @override
  String get accountsavailable => 'Доступные учетные записи';

  @override
  String get username => 'Имя пользователя';

  @override
  String get next => 'Далее';

  @override
  String get usernamevalid => 'Имя пользователя действительно';

  @override
  String get usernameavaribale => 'Имя пользователя доступно';

  @override
  String get usernameinvalid =>
      'Имя пользователя недействительно. Пожалуйста, следуйте формату.';

  @override
  String get usernameunavailable => 'Имя пользователя уже существует.';

  @override
  String get noaccountsavailable =>
      'В настоящее время учетные записи недоступны';

  @override
  String get privatekey => 'Закрытый ключ';

  @override
  String get publickey => 'Открытый ключ';

  @override
  String get pleasesavethiscredentials =>
      'Пожалуйста, сохраните эти учетные данные\nили они будут потеряны';

  @override
  String get saveasfile => 'Сохранить как файл';

  @override
  String get copiedtoclipboard => 'Скопировано в буфер обмена';

  @override
  String get pleasewait => 'Пожалуйста, подождите';

  @override
  String get loading => 'Загрузка';

  @override
  String get loadingcaptcha => 'Загрузка Captcha';

  @override
  String get captchafaild => 'Не удалось пройти проверку Captcha';

  @override
  String get errorappeared => 'Произошла ошибка';

  @override
  String get slidepuzzle => 'Переместите часть пазла в правильное положение';

  @override
  String get trylater => 'Пожалуйста, попробуйте позже';

  @override
  String get certwarning =>
      'Сохраните этот сертификат в безопасном месте.\nНе передавайте его никому.\nЭтот сертификат предоставляет полный доступ \nк вашей учетной записи.';

  @override
  String get relatedpublickey => 'Связанный открытый ключ';

  @override
  String get issued => 'Выдано';

  @override
  String get withtransactionid => 'с идентификатором транзакции';

  @override
  String get network => 'Сеть';

  @override
  String get certificate => 'СЕРТИФИКАТ';

  @override
  String get clicktocopy => 'Нажмите, чтобы скопировать';

  @override
  String get activepermissionexplain => 'Для ежедневного использования';

  @override
  String get tologin => 'Войти в систему';

  @override
  String get ownerpermissionexplain =>
      'Может перезаписать ACTIVE. В случае взлома или утери ACTIVE';

  @override
  String get retryagain => 'Повторить попытку';

  @override
  String get connectionproblem => 'Уф, проблема с подключением';

  @override
  String get accountsthatcanbegeneratedtoday =>
      'Аккаунты, которые можно создать сегодня';

  @override
  String get disclaimer01 =>
      'Эта платформа все еще находится на стадии бета-тестирования. Могут возникать ошибки, а аккаунты на этой платформе могут изменяться или удаляться без предварительного уведомления.';

  @override
  String get accountsponsored => 'Аккаунт спонсирован сообществом';

  @override
  String get noacountavailable => 'К сожалению, аккаунт создать невозможно.';
}
