import 'package:dson_adapter/dson_adapter.dart';
import 'package:flutter/material.dart';

import '../../data/repositorys/motels_repository.dart';
import '../../domain/motels/motel_entity.dart';
import '../../domain/suite/suite_categories_entity.dart';
import '../../domain/suite/suite_entity.dart';
import '../../domain/suite/suite_item_entity.dart';
import '../../domain/suite/suite_period_entity.dart';
import 'components/home_app_bar/home_app_bar.dart';

abstract class InitialScreenProtocol {}

class InitialScreenView extends StatefulWidget {
  const InitialScreenView({super.key});

  @override
  State<InitialScreenView> createState() => _InitialScreenViewState();
}

class _InitialScreenViewState extends State<InitialScreenView> {
  @override
  void initState() {
    super.initState();
    MotelsRepository().getMotels(success: (response) {
      try {
        const dson = DSON();
        final moteis = List<MotelEntity>.from(response['data']['moteis'].map((motelJson) {
          return dson.fromJson(
            motelJson,
            MotelEntity.new,
            resolvers: [
              (key, value) {
                return (key == 'fotos')
                    ? (value as List<dynamic>).map((foto) {
                        return foto.toString();
                      }).toList()
                    : value;
              },
            ],
            inner: {
              'suites': ListParam<SuiteEntity>(SuiteEntity.new),
              'itens': ListParam<SuiteItemEntity>(SuiteItemEntity.new),
              'categoriaItens': ListParam<SuiteCategoriesEntity>(SuiteCategoriesEntity.new),
              'periodos': ListParam<SuitePeriodEntity>(SuitePeriodEntity.new),
            },
          );
        }));
        for (final motel in moteis) {
          for (final suite in motel.suites) {
            print(suite.nome);
          }
        }
      } catch (error) {
        print(error);
        print('erro no tratamento de dados');
      }
    }, failure: (error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final l10n = Localize.instance.l10n;
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          HomeAppBar(),
          SliverFillRemaining(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Divider(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
