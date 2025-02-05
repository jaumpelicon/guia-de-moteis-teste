import 'suite_categories_entity.dart';
import 'suite_item_entity.dart';
import 'suite_period_entity.dart';

class SuiteEntity {
  final String nome;
  final int qtd;
  final bool exibirQtdDisponiveis;
  final List<String> fotos;
  final List<SuiteItemEntity> itens;
  final List<SuiteCategoriesEntity> categoriaItens;
  final List<SuitePeriodEntity> periodos;

  SuiteEntity({
    required this.nome,
    required this.qtd,
    required this.exibirQtdDisponiveis,
    required this.fotos,
    required this.itens,
    required this.categoriaItens,
    required this.periodos,
  });

  // factory SuiteEntity.fromJson(Map<String, dynamic> json) {
  //   final itensList = (json['itens'] as List).map((item) => SuiteItemEntity.fromJson(item)).toList();

  //   final categoriaItensList =
  //       (json['categoriaItens'] as List).map((item) => SuiteCategoriesEntity.fromJson(item)).toList();

  //   final periodosList = (json['periodos'] as List).map((item) => SuitePeriodEntity.fromJson(item)).toList();

  //   return SuiteEntity(
  //     nome: json['nome'],
  //     qtd: json['qtd'],
  //     exibirQtdDisponiveis: json['exibirQtdDisponiveis'],
  //     fotos: List<String>.from(json['fotos']),
  //     itens: itensList,
  //     categoriaItens: categoriaItensList,
  //     periodos: periodosList,
  //   );
  // }
}
