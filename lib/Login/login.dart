import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insurence_ibts/Constants/constant.dart';
import 'package:insurence_ibts/Home/principal.dart';
import 'package:insurence_ibts/Register/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('email');
  runApp(MaterialApp(home: email == null ? LoginF() : Inicio(),));
}

class LoginF extends StatefulWidget {
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginF> {
  bool isHiddenPassword = true;
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  EncryptedSharedPreferences encryptedSharedPreferences = EncryptedSharedPreferences();

  Future login() async {
    //var uri = Uri.parse("http://192.168.1.88/RestJWT/public/api/login");
    var uri = Uri.parse("http://192.168.1.88/CIApiRestJWT_IBS/public/auth/login");
    var response = await http.post(uri, body: {
      "email": user.text,
      "password": pass.text,
    });
    //var data = json.decode(response.body);
    if (response.statusCode == 200) {
      //print('Response body: ${response.body}');
      var jsonResponse = json.decode(response.body);
      //print('jsonResponse: ${jsonResponse}');
      //Guardar Token
      encryptedSharedPreferences.setString('token', jsonResponse['access_token']).then((bool success) {
        if (success) {
          //Mostrar token guardado
          encryptedSharedPreferences.getString('token').then((String value) {
            print(value);
          });
          //**********
          print('Token guardado');
        } else {
          print('Guardado de token fallido');
        }
      });
      //Guardar Token
      Fluttertoast.showToast(
          msg: "¡Bienvenid@!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: nEnfasis,
          textColor: nSecondTextColor,
          fontSize: 16.0
      );
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>Inicio(),),);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Inicio()),
      );

    }else{
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
              'Bienvenido',
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
                  Icons.email,
                  color: Colors.black,
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
              controller: user,
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
            SizedBox(height: 15.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.centerRight,
              //child: Text(
              //'¿Olvidaste la contraseña?',
              //style: TextStyle(color: nPrimaryColor),
              //),
            ),
            SizedBox(height: 60,),
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
                      TextSpan(text: '¿No cuentas con una cuenta? '),
                      TextSpan(
                        text: 'Registrar',
                        style: TextStyle(color: nPrimaryColor,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context){
                                return RegisterF();
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
                  login();
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: Text(
                    'Iniciar Sesión',
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
        'Iniciar Sesión',
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