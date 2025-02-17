import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

import '../../../../domain/motels/motel_entity.dart';
import '../../../core/components/svg_viewer.dart';
import '../../../core/styles/app_assets.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/app_fonts.dart';
import '../suite_item/suite_item.dart';

class MotelItem extends StatelessWidget {
  final MotelEntity motel;
  const MotelItem({required this.motel, super.key});

  @override
  Widget build(BuildContext context) {
    final pageViewController = PageController(
      viewportFraction: 0.85,
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            children: [
              Image.network(
                motel.logo,
                height: 52,
              ),
              const Spacer(),
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      motel.fantasia,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      maxLines: 1,
                      style: AppFonts.bold(28, AppColors.gray),
                    ),
                    Text(
                      motel.bairro,
                      maxLines: 1,
                      style: AppFonts.bold(16, AppColors.gray),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const SvgViewer(
                asset: AppAssets.icHeart,
                height: 32,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ExpandablePageView.builder(
          controller: pageViewController,
          physics: const BouncingScrollPhysics(),
          itemCount: motel.suites.length,
          itemBuilder: (context, index) => SuiteItem(suite: motel.suites[index]),
        ),
      ],
    );
  }
}
