import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:keep_notes/model/MyNotesModel.dart';
class NotesDatabase{
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;
  NotesDatabase._init();
  Future<Database?> get database async{
    if(_database!= null) return _database;
    _database = await _initializeDB('NewNotes.db');
    return _database;
  }

  Future<Database> _initializeDB(String filepath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath,filepath);
    return await openDatabase(path,version: 1,onCreate: _createDB);
  }
  Future _createDB(Database db,int version) async {
    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    final boolType = "BOOLEAN NOT NULL";
    final textType = "TEXT NOT NULL";
     await db.execute('''
        CREATE TABLE Notes (
       ${NotesImpNames.id} $idType,
        ${NotesImpNames.pin} $boolType,
        ${NotesImpNames.isArchived} $boolType,
       ${NotesImpNames.title} $textType,
       ${NotesImpNames.content} $textType,
       ${NotesImpNames.createdTime} $textType
    )
    ''');
   }
    Future<Note?> InsertEntry(Note note) async {
      final db = await instance.database;
      final id = await db!.insert(NotesImpNames.TableName, note.toJson());
      return note.copy(id:id);
   }
   Future<List<Note>> readAllnopinNotes() async{
    final db = await instance.database;
    final orderBy = "${NotesImpNames.createdTime} DESC";
    final Query_result = await db!.query(NotesImpNames.TableName,orderBy: orderBy,where: '${NotesImpNames.isArchived} = 0 AND ${NotesImpNames.pin} = 0');
    return Query_result.map((json) => Note.fromJson(json)).toList();
   }
  Future<List<Note>> readAllpinNotes() async{
    final db = await instance.database;
    final orderBy = "${NotesImpNames.createdTime} DESC";
    final Query_result = await db!.query(NotesImpNames.TableName,orderBy: orderBy,where: '${NotesImpNames.isArchived} = 0 AND ${NotesImpNames.pin} = 1');
    return Query_result.map((json) => Note.fromJson(json)).toList();
  }
  Future<List<Note>> readAllarchiveNotpinNotes() async{
    final db = await instance.database;
    final orderBy = "${NotesImpNames.createdTime} DESC";
    final Query_result = await db!.query(NotesImpNames.TableName,orderBy: orderBy,where: '${NotesImpNames.isArchived} = 1 AND ${NotesImpNames.pin} = 0');
    return Query_result.map((json) => Note.fromJson(json)).toList();
  }
  Future<List<Note>> readAllarchivepinNotes() async{
    final db = await instance.database;
    final orderBy = "${NotesImpNames.createdTime} DESC";
    final Query_result = await db!.query(NotesImpNames.TableName,orderBy: orderBy,where: '${NotesImpNames.isArchived} = 1 AND ${NotesImpNames.pin} = 1');
    return Query_result.map((json) => Note.fromJson(json)).toList();
  }
  Future<Note?> readOneNote(int id) async{
    final db = await instance.database;
    final map = await db!.query(NotesImpNames.TableName,
        columns: NotesImpNames.values,
        where:  "${NotesImpNames.id}= ?",
        whereArgs: [id]);
        if (map.isNotEmpty){
          return Note.fromJson(map.first);
        }
        else{
          return null;
        }
  }
  Future updateNote(Note note) async{
    final db = await instance.database;
    return await db!.update(NotesImpNames.TableName, note.toJson(),where: "${NotesImpNames.id} = ?",whereArgs: [note.id]);
  }
  Future deleteNote(Note note)async{
    final db = await instance.database;
    await db!.delete(NotesImpNames.TableName,where: '${NotesImpNames.id} = ?',whereArgs: [note.id]);
  }
  Future closeDB() async{
    final db = await instance.database;
    db!.close();
  }
  Future pinNote(Note? note) async{
    final db = await instance.database;
    return await db!.update(NotesImpNames.TableName,{NotesImpNames.pin : !note!.pin ? 1 : 0},where: "${NotesImpNames.id} = ?",whereArgs: [note.id]);
  }
  Future archNote(Note? note) async{
    final db = await instance.database;
    return await db!.update(NotesImpNames.TableName,{NotesImpNames.isArchived : !note!.isArchived ? 1 : 0},where: "${NotesImpNames.id} = ?",whereArgs: [note.id]);
  }
  Future<List<int>> getNoteString(String query) async{
    final db = await instance.database;
    final result = await db!.query(NotesImpNames.TableName);
    List<int> resultIds = [];
    result.forEach((element){
      if(element["title"].toString().toLowerCase().contains(query)|| element["content"].toString().toLowerCase().contains(query)){
        resultIds.add(element["id"] as int);
      }

    });
    return resultIds;
  }


}