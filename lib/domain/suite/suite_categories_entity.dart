class SuiteCategoriesEntity {
  final String nome;
  final String icone;

  SuiteCategoriesEntity({required this.nome, required this.icone});

  factory SuiteCategoriesEntity.fromJson(Map<String, dynamic> json) {
    return SuiteCategoriesEntity(
      nome: json['nome'],
      icone: json['icone'],
    );
  }
}
