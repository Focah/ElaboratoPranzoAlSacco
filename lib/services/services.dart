import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:elaborato_delivery_app/main.dart';

class Services {
  static const ROOT = 'https://www.bushido-team.com/Elaborato/service.php';

  static const _NUOVO_UTENTE = 'NUOVO_UTENTE';
  static const _ACCESSO = 'ACCESSO';

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
      return "errore"; // Return an empty list on exception
    }
  }

  static Future<String> accesso(String email, String password) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _ACCESSO;
      map['email'] = email;
      map['password'] = password;

      var url = Uri.parse(ROOT);
      final response = await http.post(url, body: map);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.body;
    }catch(e){
      return "errore";
    }
  }

  static Future<List<Cliente>> allClienti() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = "ALL_CLIENTI";

      var url = Uri.parse(ROOT);
      final response = await http.post(url, body: map);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonData = json.decode(response.body);

      List<Cliente> clienti = [];

      for(var c in jsonData){
        Cliente cliente = Cliente(int.parse(c['cliente_id']), c['nome'], c['cognome'], c['username'], c['email'], c['numero_cell'], c['verificato'], int.parse(c['numero_ordini']), int.parse(c['stato']));
        clienti.add(cliente);
      }

      return clienti;
    }catch(e){
      print(e);
      return [];
    }
  }

  static Future<http.Response> fetchAddress(double lat, double lng){
    var apiKey = '9c545acb3ed945c2a26029ce219c0be3';
    return http.get(Uri.parse('https://api.opencagedata.com/geocode/v1/json?q=$lat+$lng&key=$apiKey'));
  }
}

class Cliente{
  final int cliente_id;
  final String nome;
  final String cognome;
  final String username;
  final String email;
  final String numero_cell;
  final String verificato;
  final int numero_ordini;
  final int stato;

  Cliente(this.cliente_id, this.nome, this.cognome, this.username, this.email, this.numero_cell, this.verificato, this.numero_ordini, this.stato);
}