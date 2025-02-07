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
}
