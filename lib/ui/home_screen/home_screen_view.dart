import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/motels/motel_entity.dart';
import '../../domain/suite/suite_entity.dart';
import '../../utils/service_locator/service_locator.dart';
import '../core/extensions/numbers_extensions.dart';
import '../core/styles/app_colors.dart';
import '../core/styles/app_fonts.dart';
import 'bloc/home_bloc.dart';
import 'components/home_app_bar/home_app_bar.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  late HomeBloc homeBloc;
  @override
  void initState() {
    super.initState();
    homeBloc = ServiceLocator.get<HomeBloc>();

    homeBloc.add(GetHomeMotelsEvent());
  }

  @override
  Widget build(BuildContext context) {
    // final l10n = Localize.instance.l10n;
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          return switch (state) {
            HomeError(error: final error) => Text(
                error.message,
                style: AppFonts.bold(16, AppColors.red),
              ),
            HomeLoading() => const CircularProgressIndicator(color: AppColors.red),
            HomeSuccess(motels: final motels) => buildSuccessWidget(motels),
            HomeInitial() => const SizedBox.shrink(),
          };
        },
      ),
    );
  }

  Widget motelWidget(MotelEntity motel) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      sliver: SliverList.list(
        children: [
          Row(
            children: [
              Image.network(
                motel.logo,
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    motel.fantasia,
                    // strutStyle: StrutStyle.disabled,
                    style: AppFonts.bold(30, AppColors.gray),
                  ),
                  Text(
                    motel.bairro,
                    // strutStyle: StrutStyle.disabled,
                    style: AppFonts.bold(16, AppColors.gray),
                  ),
                ],
              ),
              const Spacer(
                flex: 3,
              ),
              const Icon(Icons.heart_broken)
            ],
          ),
          const SizedBox(height: 16),
          // ListView.builder(itemBuilder: itemBuilder)
          buildSuiteWidget(motel.suites.first),

          // SizedBox(
          //   height: 400,
          //   child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       itemCount: motel.suites.length,
          //       itemBuilder: (_, index) {
          //         return buildSuiteWidget(motel.suites[index]);
          //       }),
          // )
          // ...motel.suites.map((suite) => buildSuiteWidget(suite)),
        ],
      ),
    );
  }

  Widget buildSuiteWidget(SuiteEntity suite) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...suite.categoriaItens.map((categoria) {
                return Image.network(
                  categoria.icone,
                  height: 52,
                );
              }),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'ver',
                    style: AppFonts.medium(15, AppColors.gray),
                  ),
                  Text(
                    'todos',
                    style: AppFonts.medium(15, AppColors.gray),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_drop_down_sharp,
                color: AppColors.gray,
                size: 20,
              )
            ],
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
    );
  }

  Widget buildSuccessWidget(List<MotelEntity> motels) {
    return CustomScrollView(
      slivers: [
        const HomeAppBar(),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            child: Divider(),
          ),
        ),
        ...motels.map((motel) => motelWidget(motel)),

        // SliverList.builder(
        //     itemCount: motels.length,
        //     itemBuilder: (context, index) {
        //       return motelWidget(motels[index]);
        //     })
      ],
    );
  }
}
