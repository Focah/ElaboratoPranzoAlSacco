import 'package:elaborato_delivery_app/pages/homeAuth.dart';
import 'package:elaborato_delivery_app/pages/homeSignIn.dart';
import 'package:elaborato_delivery_app/pages/homeSignUpSecond.dart';
import 'package:elaborato_delivery_app/services/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Pagina Registrazione 1
class HomeSignUpFirst extends StatefulWidget {
  const HomeSignUpFirst({Key key}) : super(key: key);

  @override
  _HomeSignUpFirstState createState() => _HomeSignUpFirstState();
}

class _HomeSignUpFirstState extends State<HomeSignUpFirst> {
  final _formKey = GlobalKey<FormState>();

  final userTfController = TextEditingController();
  final emailTfController = TextEditingController();
  final pass1TfController = TextEditingController();
  final pass2TfController = TextEditingController();

  bool _obscurePass1 = true;
  bool _obscurePass2 = true;

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
                //Back button
                Positioned(
                  top: size.height * 0.05,
                  left: size.width * 0.02,
                  child: IconButton(
                    icon: Icon(Icons.navigate_before),
                    color: colorBtn,
                    iconSize: 35,
                    onPressed: () {
                      //Go back to HomeAuth()
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeAuth()));
                    },
                  ),
                ),

                //Top text
                Positioned(
                  top: size.height * 0.15,
                  child: Text(
                    "Crea un nuovo account",
                    style: TextStyle(
                        fontSize: 25, fontFamily: 'Itim', color: Colors.grey),
                  ),
                ),

                //Bottom text
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

                //Next button
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
                      print("Pressed Sign In");
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeSignUpSecond()));
                      if (_formKey.currentState.validate()) {
                        print("Validato");
                        var user = userTfController.text;
                        var email = emailTfController.text;
                        var pass = pass1TfController.text;
                        print(user);
                        print(email);
                        print(pass);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeSignUpSecond(
                                  user: user,
                                  email: email,
                                  pass: pass,
                                )));
                      }
                    },
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Text(
                            "AVANTI",
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

                //Username textfield
                Positioned(
                  top: size.height * 0.27,
                  child: Container(
                    width: size.width * 0.75,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Inserisci il tuo username';
                        }
                        return null;
                      },
                      controller: userTfController,
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]'))
                      ],
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Inserisci Username",
                        hintStyle: TextStyle(fontFamily: 'Itim', fontSize: 18),
                      ),
                    ),
                  ),
                ),

                //Email textfield
                Positioned(
                  top: size.height * 0.37,
                  child: Container(
                    width: size.width * 0.75,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Inserisci la tua email';
                        }
                        return null;
                      },
                      controller: emailTfController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Inserisci Email",
                        hintStyle: TextStyle(fontFamily: 'Itim', fontSize: 18),
                      ),
                    ),
                  ),
                ),

                //Password textfield
                Positioned(
                  top: size.height * 0.47,
                  child: Container(
                    width: size.width * 0.75,
                    child: Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Inserisci la tua password';
                              }
                              return null;
                            },
                            controller: pass1TfController,
                            keyboardType: TextInputType.text,
                            enableSuggestions: false,
                            autocorrect: false,
                            obscureText: _obscurePass1,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: "Inserisci Password",
                              hintStyle:
                              TextStyle(fontFamily: 'Itim', fontSize: 18),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscurePass1 = !_obscurePass1;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),

                //Password2 textfield
                Positioned(
                  top: size.height * 0.57,
                  child: Container(
                    width: size.width * 0.75,
                    child: Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Inserisci la tua password';
                              }
                              if (pass1TfController.text !=
                                  pass2TfController.text) {
                                return 'Le password sono differenti';
                              }
                              return null;
                            },
                            controller: pass2TfController,
                            keyboardType: TextInputType.text,
                            enableSuggestions: false,
                            autocorrect: false,
                            obscureText: _obscurePass2,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: "Reinserisci Password",
                              hintStyle:
                              TextStyle(fontFamily: 'Itim', fontSize: 18),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.visibility),
                          onPressed: () {
                            print("Cliccato");
                            setState(() {
                              _obscurePass2 = !_obscurePass2;
                            });
                          },
                        )
                      ],
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