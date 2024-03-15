import 'package:lista_tarefas_banco_local/repositories/sqflite.dart';
import 'package:lista_tarefas_banco_local/models/tarefa.dart';

class Repositorio2 {
  Repositorio2();

  /* Por enquanto não precisa, mas pode ser útil
  Future<void> salvarLista(List<Tarefa> tarefas) async {
    for (Tarefa tarefa in tarefas) {
      await salvarTarefa(tarefa);
    }
  }*/

  Future<void> salvarTarefa(Tarefa tarefa) async {
    var db = await SQLiteDataBase().obterDataBase();

    if (tarefa.id == null) {
      await db.rawInsert('INSERT INTO tarefas (titulo, realizado) VALUES (?,?)',
          [tarefa.titulo, tarefa.realizado]);
    } else {
      await db.rawUpdate(
          'UPDATE tarefas set titulo = ?, realizado = ? WHERE id = ?',
          [tarefa.titulo, tarefa.realizado, tarefa.id]);
    }
  }

  Future<void> excluirTarefa(Tarefa tarefa) async {
    var db = await SQLiteDataBase().obterDataBase();

    if (tarefa.id != null) {
      await db.rawDelete('DELETE FROM tarefas WHERE id = ?', [tarefa.id]);
    }
  }

  Future<List<Tarefa>> recuperarLista() async {
    List<Tarefa> tarefas = [];
    var db = await SQLiteDataBase().obterDataBase();
    var result = await db.rawQuery('SELECT * FROM tarefas');
    for (var element in result) {
      tarefas.add(Tarefa(
        id: int.parse(element["id"].toString()),
        titulo: element["titulo"].toString(),
        realizado: int.parse(element["realizado"].toString()) == 1,
      ));
    }
    return tarefas;
  }
}
