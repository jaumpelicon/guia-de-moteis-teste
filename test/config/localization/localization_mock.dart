import 'package:guia_de_motel_teste/config/generated/l10n/localization.dart';
import 'package:mocktail/mocktail.dart';

class LocalizationMock extends Mock implements Localization {
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
