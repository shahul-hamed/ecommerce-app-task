import 'package:ecommerce_task/helper/base_constants.dart';
import 'package:ecommerce_task/providers/auth_provider.dart';
import 'package:ecommerce_task/providers/products_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'theme/colors.dart';
import 'utils/firebase_options.dart';
import 'view/authentication/signup_view.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  bool isFromRefresh= GetStorage().read('isFromRefresh')??false;
  if(!isFromRefresh) {
    GetStorage().remove('isLogin');
  }
  bool isLogin =(GetStorage().read("isLogin")?? false);
  debugPrint("login$isLogin");
  SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
    statusBarColor: isLogin?primaryColor:white,
    systemNavigationBarColor: Colors.white,
    statusBarIconBrightness: !isLogin?Brightness.dark:Brightness.light,
    statusBarBrightness: Brightness.dark, //<-- For iOS SEE HERE (dark icons)
    systemNavigationBarDividerColor:
    lightGrey, // navigation bar color/ status bar color
  ));
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
      title: 'E-Shop',
      theme: ThemeData(

          textSelectionTheme: const TextSelectionThemeData(cursorColor: primaryColor),

        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: false,fontFamily: BaseConstants.fontFamily
      ),
      home: const SignupView(),
    );
  }
}

