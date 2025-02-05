import '../suite/suite_entity.dart';

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

  // factory MotelEntity.fromJson(Map<String, dynamic> json) {
  //   final suitesList = (json['suites']).map((suite) {
  //     return SuiteEntity.fromJson(suite);
  //   }).toList();

  //   return MotelEntity(
  //     fantasia: json['fantasia'],
  //     logo: json['logo'],
  //     bairro: json['bairro'],
  //     distancia: json['distancia'],
  //     qtdFavoritos: json['qtdFavoritos'],
  //     suites: suitesList,
  //   );
  // }
}
