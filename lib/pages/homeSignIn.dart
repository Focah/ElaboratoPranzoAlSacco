import 'package:elaborato_delivery_app/pages/homeAuth.dart';
import 'package:elaborato_delivery_app/pages/homePage.dart';
import 'package:elaborato_delivery_app/pages/homeSignUpFirst.dart';
import 'package:elaborato_delivery_app/services/consts.dart';
import 'package:elaborato_delivery_app/services/services.dart';
import 'package:flutter/material.dart';

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

  _showDialog(BuildContext context) {
    VoidCallback continueCallBack = () {
      Navigator.of(context).pop();
        //TODO andare alla pagina di "Attendere"
      };

      BlurryDialog alert = BlurryDialog("Cambio password",
          "Ti abbiamo inviato una email all'indirizzo di posta elettronica, continua la procedura di cambio password al link nella email.", continueCallBack, 1);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );

  }

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
                  child: GestureDetector(
                    onTap: (){
                      if(emailTfController.text.isNotEmpty){
                        Services.passwordReset(emailTfController.text).then((value){
                          _showDialog(context);
                        });
                      }
                    },
                    child: Text(
                      "Password dimenticata?",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
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
