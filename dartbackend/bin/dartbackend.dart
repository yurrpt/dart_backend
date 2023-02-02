import 'dart:convert';

import 'package:dartbackend/db/connect_settings.dart';
import 'package:galileo_mysql/galileo_mysql.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

void main(List<String> arguments) {
  final app = Router();

  // get request
  app.get('/', (Request request) async {
    var conn = await MySqlConnection.connect(settings);

    var results = await conn.query('select * from users where iduser = ?;'[2]);
    print(results.first.fields);
    var userdata = results.first.fields;
    userdata.remove("created_at");
    final map = {
      "user": {
        "name": "John",
        "age": 30,
      },
    };
    return Response.ok(jsonEncode(userdata));
  });

  // post request
  /*  app.post('/', (Request request) {
    return Response.ok("selam");
  }); */

  serve(app, "localhost", 8080);
}
