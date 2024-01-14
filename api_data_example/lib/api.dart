import 'dart:convert';

import 'package:api_data_example/models/user.dart';
import 'package:http/http.dart' as http;

Future<List<User>> apiLoadUsers({String? role}) async {
  try {
    final uri = Uri.parse("https://valorant-api.com/v1/agents");
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
          "Failed to load data. Status code: ${response.statusCode}");
    }

    final json = jsonDecode(response.body);
    final jsonUserList = json["data"];
    final List<User> userList = [];

    for (final jsonUser in jsonUserList) {
      final user = User.fromJson(jsonUser);

      // Si el rol es "Todos", simplemente agrega el usuario a la lista
      if (role == null || role == "Todos") {
        userList.add(user);
      } else if (user.rol == role) {
        userList.add(user);
      }
    }

    //print("User List: $userList");

    return userList;
  } catch (e) {
    //print("Error loading data: $e");
    rethrow; // Reenvía la excepción después de imprimir el mensaje
  }
}
