import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:insurence_ibts/Constants/constant.dart';
import 'package:insurence_ibts/Home/principal.dart';
import 'package:insurence_ibts/Login/login.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterF extends StatefulWidget {
  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterF> {
  bool isHiddenPassword = true;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future register() async {
    //var url = "http://192.168.1.72/flutter_mysql/flutter_mysql/register.php";
    var uri = Uri.parse("http://192.168.1.88/CIApiRestJWT_IBS/public/auth/register");
    var response = await http.post(uri, body: {
      "name": name.text,
      "email": email.text,
      "password": pass.text,
    });
    if (response.statusCode == 200) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Inicio(),),);
      Fluttertoast.showToast(
          msg: "¡Registro correcto!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: nEnfasis,
          textColor: nSecondTextColor,
          fontSize: 16.0
      );
    } else {
      Fluttertoast.showToast(
          msg: "Correo y/o contraseña incorrectos",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: nResalt,
          textColor: nSecondTextColor,
          fontSize: 16.0
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: nBackgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Crear Cuenta',
              style: TextStyle(
                color: nPrimaryTextColor,
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 25.0),
            TextField(
              cursorColor: nEnfasis,
              style: TextStyle(color: nSecondTextColor),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: nSecondTextColor,
                ),
                labelText: 'Nombre',
                labelStyle: TextStyle(color: nSecondTextColor),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: nPrimaryColor,
                      width: 2,
                    )
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: nPrimaryColor,
                      width: 2,
                    )
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: nSecondTextColor,
                      width: 0.5,
                    )
                ),
              ),
              controller: name,
            ),
            TextField(
              cursorColor: nEnfasis,
              style: TextStyle(color: nSecondTextColor),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: nSecondTextColor,
                ),
                labelText: 'Correo electrónico',
                labelStyle: TextStyle(color: nSecondTextColor),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: nPrimaryColor,
                      width: 2,
                    )
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: nPrimaryColor,
                      width: 2,
                    )
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: nSecondTextColor,
                      width: 0.5,
                    )
                ),
              ),
              controller: email,
            ),
            SizedBox(height: 15.0),
            TextField(
              cursorColor: nEnfasis,
              style: TextStyle(color: nSecondTextColor),
              obscureText: isHiddenPassword,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: nSecondTextColor,
                ),
                labelText: 'Contraseña',
                labelStyle: TextStyle(color: nSecondTextColor),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: nPrimaryColor,
                      width: 2,
                    )
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: nPrimaryColor,
                      width: 2,
                    )
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: nSecondTextColor,
                      width: 0.5,
                    )
                ),
                suffixIcon: InkWell(
                  onTap: _togglePasswordView,
                  child: Icon(
                    Icons.visibility,
                    color: nSecondTextColor,
                  ),
                ),
              ),
              controller: pass,
            ),
            SizedBox(height: 30,),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 16,
              ),
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                    style: TextStyle(color: nPasives),
                    children: [
                      TextSpan(text: '¿Ya cuentas con una cuenta? '),
                      TextSpan(
                        text: 'Iniciar Sesión',
                        style: TextStyle(color: nPrimaryColor,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context){
                                return LoginF();
                              },
                            ),
                          );
                        },
                      ),
                    ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                ),
                color: nPrimaryColor,
                onPressed: () {
                  register();
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: Text(
                    'Registrar',
                    style: TextStyle(
                      color: nThirdTextColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePasswordView() {
    isHiddenPassword = !isHiddenPassword;
    setState(() {});
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: nBackgroundColor,
      elevation: 8,
      centerTitle: true,
      title: Text(
        'Registrar',
        style: TextStyle(
          color: nPrimaryTextColor,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: nPrimaryTextColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class FlutterToast {
  FlutterToast(BuildContext context);

  void showToast({required Text child}) {}
}