import 'package:guia_de_motel_teste/config/generated/l10n/localization.dart';
import 'package:guia_de_motel_teste/config/localization/localize.dart';

import 'localization_mock.dart';

class LocalizeMock extends LocalizeProtocol {
  static LocalizeMock instance = LocalizeMock._();

  LocalizeMock._();

  @override
  Localization get l10n => LocalizationMock();
}
