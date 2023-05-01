import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'custom/app_theme.dart';
import 'firebase_options.dart';
import 'ui/views/login_page.dart';
import 'values/strings_translation.dart';


Future<void> main() async {
  // TODO: Check internet connection
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // TODO: poner el tema claro u oscuro en función de la configuración por defecto del dispositivo
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringsTranslation.of(context)?.translate("hueveria_nieto") ?? "Huevería Nieto",
      theme: AppTheme.ligthTheme,

      home: const LoginPage(),
    );
  }
}
