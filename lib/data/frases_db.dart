import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FrasesDb {
  FrasesDb._();
  static final FrasesDb instancia = FrasesDb._();
  static const _nombreArchivo = 'misfrases.db';
  static const _tabla = 'frases';
  Database? _db;

  // Devuelve la BD abierta; la abre solo la primera vez (Singleton).
  Future<Database> get _database async {
    _db ??= await _abrir();
    return _db!;
  }

  Future<Database> _abrir() async {
    final ruta = join(await getDatabasesPath(), _nombreArchivo);
    return openDatabase(
      ruta,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
CREATE TABLE $_tabla (
id INTEGER PRIMARY KEY AUTOINCREMENT,
frase TEXT NOT NULL,
autor TEXT NOT NULL
)
''');
      },
    );
  }
}
