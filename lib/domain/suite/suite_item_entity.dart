class SuiteItemEntity {
  final String nome;

  SuiteItemEntity({required this.nome});

  factory SuiteItemEntity.fromJson(Map<String, dynamic> json) {
    return SuiteItemEntity(nome: json['nome']);
  }
}
