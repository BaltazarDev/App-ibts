import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurence_ibts/Constants/constant.dart';
import 'package:insurence_ibts/Home/home.dart';
import 'package:insurence_ibts/Home/principal.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    var d = Duration(seconds: 5);
    Future.delayed(d,(){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context){
          return MainPage();
        },
      ),
          (route) => false,
    );
    });
    super.initState();
  }

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
                  //width: 700.0,
                  //height: 500.0,
                ),
                //child: FlutterLogo(size: 400)
              ),
            ),
            //Spacer(),
            CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            Spacer(),
            //Text('Bienvenido')
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insurance Boost Solutions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: nBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  //late SharedPreferences sharedPreferences;
  EncryptedSharedPreferences encryptedSharedPreferences = EncryptedSharedPreferences();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    encryptedSharedPreferences.getString('token').then((String value) {
      print('TOKEN');
      print(value);

      if(encryptedSharedPreferences.getString(value) != null) {
        //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomeScreen()), (Route<dynamic> route) => false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        print('No hay token');
      } else {
        //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Inicio()), (Route<dynamic> route) => false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Inicio()),
        );
        print('Si hay token');
      }
    });

    //sharedPreferences = await SharedPreferences.getInstance();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
