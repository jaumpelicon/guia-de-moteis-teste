import 'package:flutter/material.dart';

import '../../../../config/localization/localize.dart';
import '../../../../utils/service_locator/service_locator.dart';
import '../../../core/components/svg_viewer.dart';
import '../../../core/styles/app_assets.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/app_fonts.dart';
import 'filter_motels.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  static const List<String> brazilStates = [
    'Acre',
    'Alagoas',
    'Amapá',
    'Amazonas',
    'Bahia',
    'Ceará',
    'Espírito Santo',
    'Goiás',
    'Maranhão',
    'Mato Grosso',
    'Mato Grosso do Sul',
    'Minas Gerais',
    'Pará',
    'Paraíba',
    'Paraná',
    'Pernambuco',
    'Piauí',
    'Rio de Janeiro',
    'Rio Grande do Norte',
    'Rio Grande do Sul',
    'Rondônia',
    'Roraima',
    'Santa Catarina',
    'São Paulo',
    'Sergipe',
    'Tocantins'
  ];
  String capitalSelected = brazilStates.first;

  @override
  Widget build(BuildContext context) {
    final l10n = ServiceLocator.get<LocalizeProtocol>().l10n;

    return Container(
      color: AppColors.red,
      height: 248,
      child: FilterMotels(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.menu,
                          color: AppColors.white,
                        )),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SvgViewer(
                              asset: AppAssets.icLightning,
                              height: 32,
                              color: AppColors.red,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              l10n.goNowInputTitle,
                              style: AppFonts.bold(24, AppColors.darkGray),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Row(
                        children: [
                          const SvgViewer(
                            color: AppColors.white,
                            asset: AppAssets.icCalendarCheck,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.goLaterInputTitle,
                            style: AppFonts.bold(24, AppColors.white),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: AppColors.white,
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 40),
                    child: DropdownButton<String>(
                      iconEnabledColor: Colors.transparent,
                      iconSize: 0,
                      isExpanded: true,
                      style: AppFonts.medium(14, AppColors.white),
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      items: brazilStates.map(
                        (capital) {
                          return DropdownMenuItem(
                            value: capital,
                            child: Text(
                              capital,
                              style: AppFonts.bold(
                                15,
                                AppColors.darkGray,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      selectedItemBuilder: (context) {
                        return brazilStates.map(
                          (capital) {
                            return DropdownMenuItem(
                              value: capital,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    capital,
                                    style: AppFonts.bold(
                                      15,
                                      AppColors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: AppColors.white,
                                  )
                                ],
                              ),
                            );
                          },
                        ).toList();
                      },
                      value: capitalSelected,
                      onChanged: (value) {
                        setState(() {
                          capitalSelected = value ?? '';
                        });
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
