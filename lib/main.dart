import 'package:ecommerce_task/helper/base_constants.dart';
import 'package:ecommerce_task/providers/auth_provider.dart';
import 'package:ecommerce_task/providers/products_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/colors.dart';
import 'utils/firebase_options.dart';
import 'view/authentication/signup_view.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<ProductsProvider>(create: (_) => ProductsProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'E-shop',
      theme: ThemeData(

          textSelectionTheme: TextSelectionThemeData(cursorColor: primaryColor),

        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: false,fontFamily: BaseConstants.fontFamily
      ),
      home: SignupView(),
    );
  }
}

