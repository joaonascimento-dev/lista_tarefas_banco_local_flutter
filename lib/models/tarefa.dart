class Tarefa {
  Tarefa({required this.titulo, required this.realizado, this.id});

  int? id;
  String titulo;
  bool realizado;

  Map<String, dynamic> toJson() {
    return {
      "titulo": titulo,
      "realizado": realizado,
    };
  }
}
