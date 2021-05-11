import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      home: HomeSignUpCompleted(),
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
                      color: colorBg,
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
  const HomeSignIn({Key key}) : super(key: key);

  @override
  _HomeSignInState createState() => _HomeSignInState();
}

class _HomeSignInState extends State<HomeSignIn> {
  final _formKey = GlobalKey<FormState>();

  final emailTfController = TextEditingController();
  final pass1TfController = TextEditingController();

  bool _obscurePass = true;

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
                          color: colorBg,
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

                      //Services.nuovoUtente("Armando", "Sacco", "Focah", "mr.armando.sacco@gmail.com", "Sacchetto", "3914934187");

                      if (_formKey.currentState.validate()) {
                        print("Validato");
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
                          color: colorBg,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      //color: Color(0xFF4058DB),
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
                          color: colorBg,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      //color: Color(0xFF4058DB),
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
                                        user: widget.user)));
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
  final user;
  const HomeSignUpCompleted({Key key, this.user}) : super(key: key);

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
                child: Icon(Icons.done_outline_sharp, color: colorGreen, size: 80,),
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
            ],
          ),
        ),
      ),
    );
  }
}
