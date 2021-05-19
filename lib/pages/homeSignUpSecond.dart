import 'dart:io';

import 'package:elaborato_delivery_app/pages/homeSignIn.dart';
import 'package:elaborato_delivery_app/pages/homeSignUpCompleted.dart';
import 'package:elaborato_delivery_app/pages/homeSignUpFirst.dart';
import 'package:elaborato_delivery_app/services/consts.dart';
import 'package:elaborato_delivery_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Pagina Registrazione 2
class HomeSignUpSecond extends StatefulWidget {
  final user;
  final email;
  final pass;
  const HomeSignUpSecond({Key key, this.user, this.email, this.pass})
      : super(key: key);

  @override
  _HomeSignUpSecondState createState() => _HomeSignUpSecondState();
}

class _HomeSignUpSecondState extends State<HomeSignUpSecond> {
  final _formKey = GlobalKey<FormState>();

  final nomeTfController = TextEditingController();
  final cognomeTfController = TextEditingController();
  final numeroCellTfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        return null;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: size.width,
          height: size.height,
          color: colorBgApp,
          child: Form(
            key: _formKey,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                //backBtn
                Positioned(
                  top: size.height * 0.05,
                  left: size.width * 0.02,
                  child: IconButton(
                    icon: Icon(Icons.navigate_before),
                    color: colorBtn,
                    iconSize: 35,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeSignUpFirst()));
                    },
                  ),
                ),

                //topTxt
                Positioned(
                  top: size.height * 0.15,
                  child: Text(
                    "Crea un nuovo account",
                    style: TextStyle(
                        fontSize: 25, fontFamily: 'Itim', color: Colors.grey),
                  ),
                ),

                //bottomContainer
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeSignIn()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: containerGradient,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      width: size.width,
                      height: size.height * 0.08,
                      child: Center(
                          child: Text(
                            "Hai gia un account? Accedi qui",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: 'Itim',
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ),

                //RegistratiBtn
                Positioned(
                  bottom: size.height * 0.26,
                  width: size.width * 0.75,
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(colorBtn),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: colorBtnDark),
                        ))),
                    onPressed: () {
                      print("Pressed Registrati");
                      if (_formKey.currentState.validate()) {
                        print("Validato e procedo alla registrazione");
                        var nome = nomeTfController.text;
                        var cognome = cognomeTfController.text;
                        var numeroCell = numeroCellTfController.text;
                        Services.nuovoUtente(nome, cognome, widget.user,
                            widget.email, widget.pass, numeroCell)
                            .then((value) {
                          if (value.contains("Aggiunto utente")) {
                            print("procedo alla prossima pagina");
                            sleep(Duration(seconds: 1));

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeSignUpCompleted(
                                        email: widget.email)));
                          } else {
                            print("Errore in registrazione");
                          }
                        });
                      }
                    },
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Text(
                            "REGISTRATI",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Itim',
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Icon(
                            Icons.navigate_next,
                          )
                        ]),
                  ),
                ),

                //nomeTF
                Positioned(
                  top: size.height * 0.37,
                  child: Container(
                    width: size.width * 0.75,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Inserisci il tuo nome';
                        }
                        return null;
                      },
                      controller: nomeTfController,
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                      ],
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Inserisci il tuo Nome",
                        hintStyle: TextStyle(fontFamily: 'Itim', fontSize: 18),
                      ),
                    ),
                  ),
                ),

                //cognomeTF
                Positioned(
                  top: size.height * 0.47,
                  child: Container(
                    width: size.width * 0.75,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Inserisci il tuo cognome';
                        }
                        return null;
                      },
                      controller: cognomeTfController,
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                      ],
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Inserisci il tuo Cognome",
                        hintStyle: TextStyle(fontFamily: 'Itim', fontSize: 18),
                      ),
                    ),
                  ),
                ),

                //numeroTF
                Positioned(
                  top: size.height * 0.57,
                  child: Container(
                    width: size.width * 0.75,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Inserisci il tuo numero di telefono';
                        }
                        return null;
                      },
                      controller: numeroCellTfController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                      ],
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Inserisci il tuo recapito telefonico",
                        hintStyle: TextStyle(fontFamily: 'Itim', fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}