import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_helper.dart';
import 'pessoa_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

const BASE_URL = "http://paulodir.site/rest/";

class Api {
  String token;

//  Api(this.token);
  Api({this.token});

//  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//
//  Future<String> _getToken() async {
//    final SharedPreferences prefs = await _prefs;
//    return prefs.getString(token) ?? '';
//  }
//
//  Future<bool> _setToken(String tokens) async {
//    final SharedPreferences prefs = await _prefs;
//    return prefs.setString(token, tokens);
//  }

  Future<Login> login(String email, String senha) async {
    http.Response response = await http.post(BASE_URL + "login",
        body: jsonEncode({"senha": senha, "email": email}),
        headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      print(response.body);
      Login dadosJson = new Login.fromMap(json.decode(response.body));

      return dadosJson;
    } else {
      return null;
    }
  }

  Future<Login> cadastro(String nome, String email, String senha) async {
    http.Response response = await http.post(BASE_URL + "login/cadastro",
        body: jsonEncode({"senha": senha, "email": email, "nome": nome}),
        headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      print(response.body);
      Login dadosJson = new Login.fromMap(json.decode(response.body));
      return dadosJson;
    } else {
      return null;
    }
  }

//  Future<Person> cadastroPerson(String nome, String telefone) async {
//    http.Response response = await http.post( BASE_URL + "Contato", body: jsonEncode({"telefone": telefone,"nome": nome}),
//        headers: {'token': token, 'Content-Type': 'application/json'});
//    if (response.statusCode == 200) {
//      Person dadosJson = new Person.fromMap(json.decode(response.body));
//      return dadosJson;
//    } else {
//      return null;
//    }
//  }

  Future<Person> cadastroPerson(Person person, int login_id) async {
    http.Response response = await http.post(BASE_URL + "Contato",
        body: jsonEncode({"telefone": person.telefone, "nome": person.nome}),
        headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      Person dadosJson = new Person.fromMap(json.decode(response.body));
      return dadosJson;
    } else {
      return null;
    }
  }

  Future<List<Person>> contatos() async {
    http.Response response = await http.get(BASE_URL + 'Contato',
        headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      List<Person> pessoas = json.decode(response.body).map<Person>((map) {
        return Person.fromMap(map);
      }).toList();
      return pessoas;
    } else {
      return null;
    }
  }

  Future<Person> atualizarContato(String codigoContato) async {
    http.Response response = await http.patch(
        BASE_URL + "contatos/" + codigoContato,
        headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return new Person.fromMap(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<bool> deletarContato(String codigoContato) async {
    http.Response response = await http.delete(
        BASE_URL + "contatos/" + codigoContato,
        headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
