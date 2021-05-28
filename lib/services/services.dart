import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Services {
  static const ROOT = 'https://www.bushido-team.com/Elaborato/service.php';

  static const _NUOVO_UTENTE = 'NUOVO_UTENTE';
  static const _ACCESSO = 'ACCESSO';
  static const _ALL_CLIENTI = 'ALL_CLIENTI';
  static const _PIETANZA_DA_CATEGORIA = 'PIETANZA_DA_CATEGORIA';
  static const _INSERIMENTO_ORDINE = 'INSERIMENTO_ORDINE';
  static const _CLIENTE_FROM_EMAIL = 'CLIENTE_FROM_EMAIL';
  static const _AGGIUNGI_PIETANZA_ORDINE = 'AGGIUNGI_PIETANZA_ORDINE';
  static const _PASSWORD_RESET = 'PASSWORD_RESET';

  /*
  static List<Progetto> parseResponseProgetto(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Progetto>((json) => Progetto.fromJson(json)).toList();
  }
  */

  static Future<String> nuovoUtente(
      String nome, String cognome, String username, String email, String password, String numero_cell) async {
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


  static Future<String> accesso(String email, String password) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = "ACCESSO";
      map['email'] = email;
      map['password'] = password;

      var url = Uri.parse('https://www.bushido-team.com/Elaborato/service.php');
      final response = await http.post(url, body: map);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.body;
    } catch (e) {
      return "errore";
    }
  }

  static Future<String> passwordReset(String email) async{
    try {
      var map = Map<String, dynamic>();
      map['action'] = _PASSWORD_RESET;
      map['email'] = email;

      var url = Uri.parse(ROOT);
      final response = await http.post(url, body: map);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.body;
    } catch (e) {
      return "errore";
    }
  }

  static Future<List<Cliente>> allClienti() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ALL_CLIENTI;

      var url = Uri.parse(ROOT);
      final response = await http.post(url, body: map);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonData = json.decode(response.body);

      List<Cliente> clienti = [];

      for (var c in jsonData) {
        Cliente cliente = Cliente(
            int.parse(c['cliente_id']),
            c['nome'],
            c['cognome'],
            c['username'],
            c['email'],
            c['numero_cell'],
            c['verificato'],
            int.parse(c['numero_ordini']),
            int.parse(c['stato']));
        clienti.add(cliente);
      }

      return clienti;
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<Pietanza>> pietanzaDaCategoria(int categoria) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _PIETANZA_DA_CATEGORIA;
      map['categoria'] = categoria.toString();

      var url = Uri.parse(ROOT);
      final response = await http.post(url, body: map);

      //print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');

      var jsonData = json.decode(response.body);

      List<Pietanza> pietanze = [];

      for (var p in jsonData) {
        Pietanza pietanza = Pietanza(
            int.parse(p['pietanza_id']),
            p['nome'],
            int.parse(p['porzione']),
            int.parse(p['categoria']),
            double.parse(p['prezzo']),
            int.parse(p['sconto']),
            p['intolleranze'],
            p['immagine']);
        pietanze.add(pietanza);
      }

      return pietanze;
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<String> inserimentoOrdine(
      DateTime data, TimeOfDay ora, double importo, int cliente_id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _INSERIMENTO_ORDINE;
      var date = DateFormat('yyyy-MM-dd').format(data) +
          " " +
          "${ora.hour}:${ora.minute}:00";
      map['data_ora'] = date;
      map['importo'] = importo.toString();
      map['stato'] = '0';
      map['cliente_id'] = cliente_id.toString();

      var url = Uri.parse(ROOT);
      final response = await http.post(url, body: map);

      print('Response status inserimentOrdine: ${response.statusCode}');
      print('Response body inserimentOrdine: ${response.body}');
      return response.body;
    } catch (e) {
      print(e);
      return "errore"; // Return an empty list on exception
    }
  }

  static Future<String> aggiungiPietanzaOrdine(
      int qt, int pietanza_id, int ordine_id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _AGGIUNGI_PIETANZA_ORDINE;
      map['quantita'] = qt.toString();
      map['pietanza_id'] = pietanza_id.toString();
      map['ordine_id'] = ordine_id.toString();

      var url = Uri.parse(ROOT);
      final response = await http.post(url, body: map);

      //print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');
      return response.body;
    } catch (e) {
      print(e);
      return "errore"; // Return an empty list on exception
    }
  }

  static Future<Cliente> clienteById(String email) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _CLIENTE_FROM_EMAIL;
      map['email'] = email;

      var url = Uri.parse(ROOT);
      final response = await http.post(url, body: map);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonData = json.decode(response.body);

      List<Cliente> clienti = [];

      for (var c in jsonData) {
        Cliente cliente = Cliente(
            int.parse(c['cliente_id']),
            c['nome'],
            c['cognome'],
            c['username'],
            c['email'],
            c['numero_cell'],
            c['verificato'],
            int.parse(c['numero_ordini']),
            int.parse(c['stato']));
        clienti.add(cliente);
      }

      return clienti[0];
    } catch (e) {
      print(e);
      return null;
    }
  }

}

class Cliente {
  final int cliente_id;
  final String nome;
  final String cognome;
  final String username;
  final String email;
  final String numero_cell;
  final String verificato;
  final int numero_ordini;
  final int stato;

  Cliente(this.cliente_id, this.nome, this.cognome, this.username, this.email,
      this.numero_cell, this.verificato, this.numero_ordini, this.stato);
}

class Pietanza {
  final int pietanza_id;
  final String nome;
  final int porzione;
  final int categoria;
  final double prezzo;
  final int sconto;
  final String intolleranze;
  final String immagine;

  Pietanza(this.pietanza_id, this.nome, this.porzione, this.categoria,
      this.prezzo, this.sconto, this.intolleranze, this.immagine);
}
