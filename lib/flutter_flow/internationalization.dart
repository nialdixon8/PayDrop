import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'es', 'de', 'ar'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? esText = '',
    String? deText = '',
    String? arText = '',
  }) =>
      [enText, esText, deText, arText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // requestFunds
  {
    'wv1862li': {
      'en': 'Send request',
      'ar': 'طلب التمويل',
      'de': 'Geld anfordern',
      'es': 'Pedír fondos',
    },
    'xvj3fan8': {
      'en': 'Amount',
      'ar': 'المبلغ بالدولار',
      'de': '\$ Betrag',
      'es': '\$ Monto',
    },
    '9f4god2g': {
      'en': 'XRP',
      'ar': '',
      'de': '',
      'es': '',
    },
    'wwjahvpl': {
      'en': 'XRP',
      'ar': 'ميزانية المكتب',
      'de': 'Bürobudget',
      'es': 'Presupuesto de oficina',
    },
    'sx0vvzxd': {
      'en': '\$ USD',
      'ar': 'التحويل الخارجي',
      'de': 'Externe Übertragung',
      'es': 'Transferencia externa',
    },
    'ai453kej': {
      'en': '€ EUR',
      'ar': 'دفع ACH',
      'de': 'ACH-Zahlung',
      'es': 'Pago CCA',
    },
    'wo9cebk7': {
      'en': 'Choose receival currency',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rcevwwju': {
      'en': 'What is this for?',
      'ar': 'سبب',
      'de': 'Grund',
      'es': 'Razón',
    },
    '59p3a5b3': {
      'en': 'Share',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xk0bwox3': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // homePage_alt_1Copy
  {
    'h8086aeq': {
      'en': 'Food',
      'ar': 'احصل على مكافآت بعيدة',
      'de': 'Go-Far-Prämien',
      'es': 'Recompensas Ve Lejos',
    },
    'kbudp46h': {
      'en': '1',
      'ar': 'دخل',
      'de': 'Einkommen',
      'es': 'Ingreso',
    },
    '03h5hkco': {
      'en': '\$50.00',
      'ar': '50.00 دولارًا أمريكيًا',
      'de': '\$50,00',
      'es': '\$50.00',
    },
    '57h9fd5w': {
      'en': 'Coffee',
      'ar': 'احصل على مكافآت بعيدة',
      'de': 'Go-Far-Prämien',
      'es': 'Recompensas Ve Lejos',
    },
    'kt92l447': {
      'en': '0',
      'ar': 'دخل',
      'de': 'Einkommen',
      'es': 'Ingreso',
    },
    'l7x0gv6c': {
      'en': '11.23 XRP',
      'ar': '50.00 دولارًا أمريكيًا',
      'de': '\$50,00',
      'es': '\$50.00',
    },
    'smfjh1p0': {
      'en': 'Pizza',
      'ar': 'احصل على مكافآت بعيدة',
      'de': 'Go-Far-Prämien',
      'es': 'Recompensas Ve Lejos',
    },
    'na9fvt5h': {
      'en': '2',
      'ar': 'دخل',
      'de': 'Einkommen',
      'es': 'Ingreso',
    },
    'upor1z0o': {
      'en': '44.05 XRP',
      'ar': '50.00 دولارًا أمريكيًا',
      'de': '\$50,00',
      'es': '\$50.00',
    },
    'pw66yzaj': {
      'en': 'Gift for Sam',
      'ar': 'احصل على مكافآت بعيدة',
      'de': 'Go-Far-Prämien',
      'es': 'Recompensas Ve Lejos',
    },
    'h1126sxr': {
      'en': '0',
      'ar': 'دخل',
      'de': 'Einkommen',
      'es': 'Ingreso',
    },
    'fsn3g4xf': {
      'en': '€7,50',
      'ar': '50.00 دولارًا أمريكيًا',
      'de': '\$50,00',
      'es': '\$50.00',
    },
    'a1bttxhg': {
      'en': '\$',
      'ar': '',
      'de': '',
      'es': '',
    },
    'fj47k0ic': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // paymentrequest
  {
    '5ozrwvgc': {
      'en': 'Send request',
      'ar': 'طلب التمويل',
      'de': 'Geld anfordern',
      'es': 'Pedír fondos',
    },
    'uk4mpapc': {
      'en': 'Amount',
      'ar': 'المبلغ بالدولار',
      'de': '\$ Betrag',
      'es': '\$ Monto',
    },
    '9bnf42c4': {
      'en': 'XRP',
      'ar': '',
      'de': '',
      'es': '',
    },
    'zyex3m77': {
      'en': 'XRP',
      'ar': 'ميزانية المكتب',
      'de': 'Bürobudget',
      'es': 'Presupuesto de oficina',
    },
    'ybbpsv3v': {
      'en': '\$ USD',
      'ar': 'التحويل الخارجي',
      'de': 'Externe Übertragung',
      'es': 'Transferencia externa',
    },
    'k729hksu': {
      'en': '€ EUR',
      'ar': 'دفع ACH',
      'de': 'ACH-Zahlung',
      'es': 'Pago CCA',
    },
    'cycyposm': {
      'en': 'Choose receival currency',
      'ar': '',
      'de': '',
      'es': '',
    },
    'r0qn2k6d': {
      'en': 'What is this for?',
      'ar': 'سبب',
      'de': 'Grund',
      'es': 'Razón',
    },
    'q6cc2kle': {
      'en': 'Share',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // Miscellaneous
  {
    'lzyb73wy': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kx9cdks4': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'efvtwj7k': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ec5hfa1e': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'q5ljwvfo': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'j4rmwb3h': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6ah1b18f': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2kos1hen': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'q37qtoh2': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'bdb8ou7e': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jy7mgd0t': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'euz2dd5u': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'o0ga0sag': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'aox3s4fb': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'l8hv5a7z': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4pjwb70a': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0xlokf4y': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8twlwiwt': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ppqqcmbd': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ceq204jl': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'x371fjsu': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'f1p8rver': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jgc3ltpv': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'igt0fx0t': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    't4xzlq9q': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '513nj4m0': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'a1jxfgju': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
].reduce((a, b) => a..addAll(b));
