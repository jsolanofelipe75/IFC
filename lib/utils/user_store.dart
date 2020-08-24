import 'package:pruebas/models/user.dart';
import 'package:pruebas/utils/db.dart';
import 'package:sembast/sembast.dart';

class UserStore{
UserStore._internal();
static UserStore _instance = UserStore._internal();
static UserStore get instance => _instance;
final Database _database = DB.instance.database;
final StoreRef<String, Map> _store = StoreRef<String, Map>('user');

Future<Usuario> find() async{

  RecordSnapshot<String, Map> snapshot = await this._store.findFirst(this._database);
  return Usuario.fromJson(snapshot as Map);
}

}