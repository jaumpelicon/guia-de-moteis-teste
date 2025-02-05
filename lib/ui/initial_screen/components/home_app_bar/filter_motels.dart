import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/components/svg_viewer.dart';
import '../../../core/styles/app_assets.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/app_fonts.dart';

class FilterMotels extends StatelessWidget {
  const FilterMotels({super.key});

  @override
  Widget build(BuildContext context) {
    const filters = ['filtros', 'com desconto', 'disponíveis', 'hidro', 'piscina'];

    return FlexibleSpaceBar(
      background: Stack(
        children: [
          Container(
            color: AppColors.red,
            height: 240,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 80,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: ListView.builder(
                itemCount: filters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 16, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.4, color: AppColors.gray),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: index == 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform.rotate(
                                angle: math.pi / 2,
                                child: const SvgViewer(
                                  asset: AppAssets.icSliders,
                                  height: 16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                filters[index],
                                style: AppFonts.medium(14, AppColors.gray),
                              ),
                            ],
                          )
                        : Text(
                            filters[index],
                            textAlign: TextAlign.center,
                            style: AppFonts.medium(14, AppColors.gray),
                          ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
