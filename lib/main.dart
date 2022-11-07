
import 'package:caht_app_firebase/modules/home/home_screen.dart';
import 'package:caht_app_firebase/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'helpers/helper_function.dart';
import 'modules/auth/login/login_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId:Constants.messagingSenderId,
            projectId: Constants.projectId
        )
    );
  }else{
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
   bool _isLogin = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInStatus();
  }

   getUserLoggedInStatus(){
    HelperFunctions.getUserLoggedInStatus().then((value) {
      if(value!=null){
        setState((){
          _isLogin = value;
        });
      }
    });
   }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      debugShowCheckedModeBanner: false,
      home: _isLogin?HomeScreen():LoginScreen(),
    );
  }
}

