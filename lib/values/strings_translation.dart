import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class StringsTranslation {
  StringsTranslation(this.locale);

  final Locale locale;

  static StringsTranslation? of(BuildContext context) {
    return Localizations.of<StringsTranslation>(context, StringsTranslation);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    ///Español
    'es': {
      "hueveria_nieto": "Huevería Nieto"
    },

    ///Francés
    'gl': {
      "hueveria_nieto": "Huevería Nieto" // TODO Traducir
    }
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? "ERROR-$key";
  }
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<StringsTranslation> {
  const DemoLocalizationsDelegate();

  static const supportedLanguages = ['es', 'gl'];

  @override
  bool isSupported(Locale locale) =>
      supportedLanguages.contains(locale.languageCode);

  @override
  Future<StringsTranslation> load(Locale locale) {
    if (!supportedLanguages.contains(locale.languageCode)) {
      locale = const Locale('es', '');
    }

    return SynchronousFuture<StringsTranslation>(StringsTranslation(locale));
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
