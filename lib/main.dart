import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseauth/provider/internet_provider.dart';
import 'package:firebaseauth/provider/sign_in_provider.dart';
import 'package:firebaseauth/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'know_text_from_image/text_recognization.dart';

void main() async {
  // initialize the application
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
//import com.facebook.FacebookSdk;
// import com.facebook.appevents.AppEventsLogger;
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => SignInProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => InternetProvider()),
        ),
      ],
      child: const MaterialApp(
        home: TextRecognization(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
