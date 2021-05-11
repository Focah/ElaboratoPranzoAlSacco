import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Services {
  static const ROOT = 'https://www.bushido-team.com/Elaborato/service.php';

  static const _NUOVO_UTENTE = 'NUOVO_UTENTE';

  /*
  static List<Progetto> parseResponseProgetto(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Progetto>((json) => Progetto.fromJson(json)).toList();
  }
  */

  static Future<String> nuovoUtente(String nome, String cognome, String username, String email, String password, String numero_cell) async{
    try {
      var map = Map<String, dynamic>();
      map['action'] = _NUOVO_UTENTE;
      map['nome'] = nome;
      map['cognome'] = cognome;
      map['username'] = username;
      map['email'] = email;
      map['password'] = password;
      map['numero_cell'] = numero_cell;
      var url = Uri.parse(ROOT);
      final response = await http.post(url, body: map);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.body;
    } catch (e) {
      return "error"; // Return an empty list on exception
    }
  }
}