// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class LocalizationPt extends Localization {
  LocalizationPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Motel Go';

  @override
  String get seeTitle => 'ver';

  @override
  String get allTitle => 'todos';

  @override
  String get tryAgainInputitle => 'Tentar novamente';

  @override
  String get goNowInputTitle => 'ir agora';

  @override
  String get goLaterInputTitle => 'ir outro dia';

  @override
  String httpErrorMessage(Object method) {
    return 'Unsupported HTTP method: \$$method';
  }

  @override
  String get defaultErrorMessage => 'Algo deu errado tente novamente';
}
