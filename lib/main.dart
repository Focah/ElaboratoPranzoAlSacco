import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
import 'consts.dart';
import 'services/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: colorBtn),
      home: HomePage(),
    );
  }
}

//Pagina principale login/registrazione
class HomeAuth extends StatelessWidget {
  const HomeAuth({Key key}) : super(key: key);

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
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              //LogoImg
              Positioned(
                  top: size.height * 0.2,
                  child: Image(
                    image: ResizeImage(AssetImage('images/Logo.png'),
                        width: (size.width * 0.85).toInt(),
                        height: (size.height * 0.16).toInt()),
                  )),

              //BottomContainer
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: containerGradient,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  //color: Color(0xFF4058DB),
                  width: size.width,
                  height: size.height * 0.25,
                ),
              ),

              //AccediBtn
              Positioned(
                bottom: size.height * 0.21,
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeSignIn()));
                  },
                  child: Text(
                    "ACCEDI",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Itim',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              //RegistratiBtn
              Visibility(
                visible: true,
                child: Positioned(
                  bottom: size.height * 0.08,
                  width: size.width * 0.75,
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(colorBtn2),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: colorBtn2, width: 2),
                        ))),
                    onPressed: () {
                      print("Pressed Register");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeSignUpFirst()));
                    },
                    child: Text(
                      "REGISTRATI",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: 'Itim',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Pagina Login
class HomeSignIn extends StatefulWidget {
  final email;
  const HomeSignIn({Key key, this.email}) : super(key: key);

  @override
  _HomeSignInState createState() => _HomeSignInState();
}

class _HomeSignInState extends State<HomeSignIn> {
  final _formKey = GlobalKey<FormState>();

  final emailTfController = TextEditingController();
  final pass1TfController = TextEditingController();

  bool _obscurePass = true;

  @override
  void initState() {
    if (widget.email != null) {
      emailTfController.text = widget.email;
    }
    super.initState();
  }

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
                //BackBtn
                Positioned(
                  top: size.height * 0.05,
                  left: size.width * 0.02,
                  child: IconButton(
                    icon: Icon(Icons.navigate_before),
                    color: colorBtn,
                    iconSize: 35,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeAuth()));
                    },
                  ),
                ),

                //LogoImg
                Positioned(
                    top: size.height * 0.15,
                    child: Image(
                      image: ResizeImage(AssetImage('images/Logo.png'),
                          width: (size.width * 0.75).toInt(),
                          height: (size.height * 0.16).toInt()),
                    )),

                //BottomBtn
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeSignUpFirst()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: containerGradient,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      //color: Color(0xFF4058DB),
                      width: size.width,
                      height: size.height * 0.08,
                      child: Center(
                          child: Text(
                        "Non hai un account? Registrati qui",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Itim',
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),

                //AccediBtn
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
                      print("Pressed ACCEDI");
                      if (_formKey.currentState.validate()) {
                        print("Validato");
                        var email = emailTfController.text;
                        var password = pass1TfController.text;
                        Services.accesso(email, password).then((value) {
                          if (value.contains("Login effettuato")) {
                            print("Loggato");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(
                                          email: email,
                                        )));
                          }
                        });
                      }
                    },
                    child: Text(
                      "ACCEDI",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: 'Itim',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                //PassDimenticata
                Positioned(
                  bottom: size.height * 0.22,
                  child: Text(
                    "Password dimenticata?",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),

                //EmailTF
                Positioned(
                  top: size.height * 0.47,
                  child: Container(
                    width: size.width * 0.75,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Inserisci l\'email';
                        }
                        return null;
                      },
                      controller: emailTfController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Email",
                        hintStyle: TextStyle(fontFamily: 'Itim', fontSize: 18),
                      ),
                    ),
                  ),
                ),

                //PassTF
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
                              return null;
                            },
                            controller: pass1TfController,
                            keyboardType: TextInputType.text,
                            enableSuggestions: false,
                            autocorrect: false,
                            obscureText: _obscurePass,
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
                              _obscurePass = !_obscurePass;
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
                        var numero_cell = numeroCellTfController.text;
                        Services.nuovoUtente(nome, cognome, widget.user,
                                widget.email, widget.pass, numero_cell)
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

//Pagina Registrazione completa
class HomeSignUpCompleted extends StatelessWidget {
  final email;
  const HomeSignUpCompleted({Key key, this.email}) : super(key: key);

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
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              //LogoImg
              Positioned(
                  top: size.height * 0.15,
                  child: Image(
                    image: ResizeImage(AssetImage('images/Logo.png'),
                        width: (size.width * 0.85).toInt(),
                        height: (size.height * 0.16).toInt()),
                  )),

              //CenterTxt
              Positioned(
                top: size.height * 0.50,
                child: Text(
                  "Grazie per esserti registrato!",
                  style: TextStyle(
                    fontFamily: 'Itim',
                    fontSize: 26,
                    color: colorBtnDark,
                  ),
                ),
              ),

              //CenterTxt2
              Positioned(
                top: size.height * 0.60,
                child: Container(
                  width: size.width * 0.75,
                  child: Text(
                    "Controlla la casella di posta elettronica per completare la registrazione.",
                    style: TextStyle(
                      fontFamily: 'Itim',
                      fontSize: 24,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              //GreenIcon
              Positioned(
                top: size.height * 0.35,
                child: Icon(
                  Icons.done_outline_sharp,
                  color: colorGreen,
                  size: 80,
                ),
              ),

              //BtnToLogin
              //AccediBtn
              Positioned(
                bottom: size.height * 0.16,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeSignIn(
                                  email: email,
                                )));
                  },
                  child: Text(
                    "ACCEDI",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Itim',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//HomePage dopo login
class HomePage extends StatefulWidget {
  final email;
  const HomePage({Key key, this.email}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final posRistorante = LatLng(45.537918, 9.423339);
  static final double raggioConsegna = 1000;
  BitmapDescriptor mapMarker;
  Timer timer;
  String testo = "";
  bool show = false;

  Set<Marker> _markers = {
    Marker(
        markerId: MarkerId('0'),
        position: posRistorante,
        //icon: mapMarker,
        infoWindow: InfoWindow(
            title: "Pranzo al Sacco", snippet: "Posizione del ristorante"))
  };

  Set<Circle> _circles = {
    Circle(
        circleId: CircleId("0"),
        center: posRistorante,
        radius: raggioConsegna,
        fillColor: colorBtn.withOpacity(.1),
        strokeColor: colorBtn.withOpacity(.8),
        strokeWidth: 2)
  };

  //Icona personalizzata per un marker
  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/Logo.png');
  }

  void _onMapCreated(GoogleMapController controller) {
    print("Mappa creata");
  }

  //Aggiunge un marker sulla mappa
  void _addMarker(LatLng pos, String id, String title, String snippet) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(id),
          position: pos,
          //icon: mapMarker,
          infoWindow: InfoWindow(title: title, snippet: snippet)));
    });
  }

  //Prende la posizione del telefono
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  //Calcola la distanza tra due posizioni
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  void initState() {
    //setCustomMarker();

    timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
      _markers.removeWhere((element) => element.markerId == MarkerId("user"));

      _determinePosition().then((value) {
        _addMarker(LatLng(value.latitude, value.longitude), "user",
            "Posizione utente", "Marker per la posizione dell'utente");
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
        onWillPop: () {
          return null;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          //appBar: AppBar(),
          body: Container(
            width: size.width,
            height: size.height,
            color: colorBgApp,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                //Mappa
                Positioned(
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    markers: _markers,
                    circles: _circles,
                    initialCameraPosition:
                        CameraPosition(target: posRistorante, zoom: 14),
                  ),
                ),

                //OrdinaBtn
                Positioned(
                  bottom: size.height * 0.05,
                  child: Container(
                    height: 50.0,
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        //Al click del bottone calcola la distanza tra il ristorante e la posizione dell'utente
                        _determinePosition().then((value) {
                          var distance = (1000 *
                              calculateDistance(
                                  value.latitude,
                                  value.longitude,
                                  posRistorante.latitude,
                                  posRistorante.longitude));
                          print("Distance: $distance m");
                          setState(() {
                            if (distance <= raggioConsegna) {
                              show = true;
                              testo = "Puoi ordinare!";
                            } else {
                              show = true;
                              testo = "Non puoi ordinare! Sei fuori dal raggio di consegna del ristorante";
                            }
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff751815), colorBtn],
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        constraints:
                            BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Ordina",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'Itim'),
                        ),
                      ),
                    ),
                  ),
                ),

                //Testo in sovraimpressione
                Visibility(
                  visible: show,
                  child: Positioned(
                    top: size.height * 0.18,
                    child: Container(
                        width: size.width * 0.75,
                        child: Text(
                          testo,
                          style: TextStyle(
                            fontFamily: 'Itim',
                            fontSize: 30,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
