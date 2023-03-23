import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:easy_localization/easy_localization.dart';

import 'Coinbase/LoginScreen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'DZ'),
        Locale('zh', 'CN'),
        Locale('pt', 'BR'),
        Locale('hi', 'IN'),
        Locale('id', 'ID')
      ],
      startLocale: Locale('en', 'US'),
      path: 'lib/Language_Integration/language',
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// To set orientation always portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    ///Set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));

    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      title: 'Eventzz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          primaryColorLight: Colors.white,
          primaryColorBrightness: Brightness.light,
          primaryColor: Colors.white),
      home: LoginScreen1(),
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      //   EasylocaLizationDelegate(
      //     locale: data.locale!,
      //     path: 'lib/Screen/Integration/Language_Integration/language',
      //   )
      // ],
      // supportedLocales: [
      //   Locale('en', 'US'),
      //   Locale('ar', 'DZ'),
      //   Locale('zh', 'CN'),
      //   Locale('pt', 'BR'),
      //   Locale('hi', 'IN'),
      //   Locale('id', 'ID')
      // ],
      // locale: data.savedLocale,
      // // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
