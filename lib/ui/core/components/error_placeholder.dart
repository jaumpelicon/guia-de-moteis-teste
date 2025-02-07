import 'package:flutter/material.dart';

import '../../../config/localization/localize.dart';
import '../../../utils/service_locator/service_locator.dart';
import '../styles/app_colors.dart';
import '../styles/app_fonts.dart';

class ErrorPlaceholder extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onTryAgain;

  const ErrorPlaceholder({
    required this.errorMessage,
    super.key,
    this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = ServiceLocator.get<LocalizeProtocol>().l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: AppFonts.bold(20, AppColors.red),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: onTryAgain,
          child: Text(
            l10n.tryAgainInputitle,
            style: AppFonts.bold(20, AppColors.gray),
          ),
        )
      ],
    );
  }
}
