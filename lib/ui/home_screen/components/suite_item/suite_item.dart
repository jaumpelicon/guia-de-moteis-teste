import 'package:flutter/material.dart';

import '../../../../config/localization/localize.dart';
import '../../../../domain/suite/suite_entity.dart';
import '../../../../utils/service_locator/service_locator.dart';
import '../../../core/extensions/numbers_extensions.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/app_fonts.dart';

class SuiteItem extends StatelessWidget {
  final SuiteEntity suite;
  const SuiteItem({required this.suite, super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = ServiceLocator.get<LocalizeProtocol>().l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: CarouselView(
                    backgroundColor: Colors.transparent,
                    itemExtent: double.infinity,
                    children: suite.fotos.map((foto) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          foto,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 8),
                Text(suite.nome),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 80,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...suite.categoriaItens.map((categoria) {
                    return Container(
                      height: 52,
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: AppColors.softWhite, borderRadius: BorderRadius.circular(8)),
                      child: Image.network(
                        categoria.icone,
                        height: 52,
                      ),
                    );
                  }),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        l10n.seeTitle,
                        style: AppFonts.bold(15, AppColors.softGray),
                      ),
                      Text(
                        l10n.allTitle,
                        style: AppFonts.bold(15, AppColors.softGray),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_drop_down_sharp,
                    color: AppColors.softGray,
                    size: 20,
                  )
                ],
              ),
            ),
          ),
          ...suite.periodos.map((periodo) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          periodo.tempoFormatado,
                          style: AppFonts.bold(28, AppColors.gray),
                        ),
                        Text(
                          periodo.valorTotal.toReal(),
                          style: AppFonts.bold(28, AppColors.gray),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_right)
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
