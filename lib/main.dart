// ignore_for_file: library_private_types_in_public_api
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syriagames/layout/home_screen.dart';
import 'package:syriagames/modules/login_and_register.dart';
import 'package:syriagames/shared/bloc_observer.dart';
import 'package:syriagames/shared/components/constants.dart';
import 'package:syriagames/shared/network/local/cache_helper.dart';
import 'package:syriagames/shared/styles/themes.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  // ignore: deprecated_member_use
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      //await
      // DioHelper.init();
      await CacheHelper.init();
      Widget widget;

      token = CacheHelper.getData(key: 'token') ?? '';
      if (kDebugMode) {
        print(token);
      }
      widget =const HomeScreen();

      HttpOverrides.global = MyHttpOverrides();
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({super.key,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode:ThemeMode.light,
      home: Builder(
        builder: (context) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                // textScaleFactor: 1.15,
              ),
              child: startWidget
          );
        },
        // child: Directionality(
        //   textDirection: TextDirection.rtl,
        //     child: startWidget
        // ),
      ),

    );
  }
}
