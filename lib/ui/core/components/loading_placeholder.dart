import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class LoadingPlaceholder extends StatelessWidget {
  const LoadingPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.red,
      ),
    );
  }
}
