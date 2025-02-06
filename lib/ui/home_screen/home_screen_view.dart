import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/motels/motel_entity.dart';
import '../../utils/service_locator/service_locator.dart';
import '../core/components/error_placeholder.dart';
import '../core/components/loading_placeholder.dart';
import 'bloc/home_bloc.dart';
import 'components/home_app_bar/home_app_bar.dart';
import 'components/motel_item/motel_item.dart';

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
            HomeError(error: final error) => ErrorPlaceholder(
                errorMessage: error.message,
                onTryAgain: () {
                  homeBloc.add(GetHomeMotelsEvent());
                },
              ),
            HomeLoading() => const LoadingPlaceholder(),
            HomeSuccess(motels: final motels) => buildSuccessWidget(motels),
            HomeInitial() => const SizedBox.shrink(),
          };
        },
      ),
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
        ...motels.map((motel) {
          return MotelItem(
            motel: motel,
          );
        }),
      ],
    );
  }
}
