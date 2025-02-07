import 'package:flutter_gen/gen_l10n/localization.dart';
import 'package:mocktail/mocktail.dart';

class LocalizationMock extends Mock implements Localization {
  @override
  String get appTitle => 'Motel Go';

  @override
  String get tryAgainInputitle => 'Tentar novamente';

  @override
  String get goNowInputTitle => 'ir agora';

  @override
  String get goLaterInputTitle => 'ir outro dia';

  @override
  String get seeTitle => 'ver';

  @override
  String get allTitle => 'todos';
}
