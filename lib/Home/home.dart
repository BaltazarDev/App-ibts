import 'package:flutter/material.dart';
import 'package:insurence_ibts/Constants/constant.dart';
import 'package:insurence_ibts/Login/login.dart';
import 'package:insurence_ibts/Register/register.dart';
import 'login_and_register.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: nBackgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget> [
            Spacer(),
            Center(
              child: FractionallySizedBox(
                widthFactor: .9,
                child: Image.asset(
                  "assets/images/LogoIBTTS.png",
                  /*width: 700.0,
                  height: 500.0,*/
                ),
              ),
            ),
            Spacer(),
            /*SizedBox(
              height: 20,
            ),*/
            /*Text(
              'Building Trust',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: nPrimaryTextColor,
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),*/
            // Spacer(),
            /*SizedBox(height: 60,),*/
            LoginAndRegister(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class LoginAndRegister extends StatelessWidget {
  const LoginAndRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
              color: nSecondColor,
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context){
                    return RegisterF();
                  },
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  'Registrar',
                  style: TextStyle(
                    color: nThirdTextColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 40,
          ),
          Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                  side: BorderSide(color: nPrimaryColor)),
              color: nPrimaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return LoginF();
                    },
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                width: double.infinity,
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
    );
  }
}

