import 'package:dson_adapter/dson_adapter.dart';

import '../suite/suite_categories_entity.dart';
import '../suite/suite_entity.dart';
import '../suite/suite_item_entity.dart';
import '../suite/suite_period_entity.dart';

class MotelEntity {
  final String fantasia;
  final String logo;
  final String bairro;
  final double distancia;
  final int qtdFavoritos;
  final List<SuiteEntity> suites;

  MotelEntity({
    required this.fantasia,
    required this.logo,
    required this.bairro,
    required this.distancia,
    required this.qtdFavoritos,
    required this.suites,
  });

  static List<MotelEntity> fromMap(Map<String, dynamic> response) {
    const dson = DSON();

    return List<MotelEntity>.from(response['data']['moteis'].map((motelJson) {
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
  }
}
