import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syriagames/modules/register_screen/register_screen.dart';
import 'package:syriagames/shared/components/components.dart';
import 'login_screen/login_screen.dart';

class LoginAndRegister extends StatelessWidget {
  const LoginAndRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final double halfScreen = screenHeight / 2;
    final double finalHeight = halfScreen / screenHeight;

    debugPrint(MediaQuery.of(context).size.height.toString());


    return Scaffold(
      backgroundColor: Colors.black12,
      body: Stack(
        children: [
          Image(
            width: screenWidth,
            height: screenHeight,
            fit: BoxFit.cover,
            image: const AssetImage('assets/images/game.jpg'),
          ),
          const Padding(
            padding: EdgeInsets.all(50.0),
            child: Image(
              image: AssetImage('assets/images/syriagames.png'),
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.,
                children: [
                  defaultButtonLoginAndRegister(
                      text: 'إنشاء حساب',
                      textSize: screenWidth/18,
                      background: Colors.black,
                      width: screenWidth/1.7,
                      height: screenHeight/10,
                      radius: 20.0,
                      function: () {
                        if (kDebugMode) {
                          print('create acount');
                        }
                        navigateTo(context, RegisterScreen());
                        // showRecaptcha(context, screenWidth,'0994031193');

                        // navigateTo(context, RegisterScreen());
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButtonLoginAndRegister(
                      text: 'تسجيل الدخول',
                      textSize:screenWidth/18 ,
                      background: Colors.black,
                      width: screenWidth/1.7,
                      height: screenHeight/10,
                      radius: 20.0,
                      function: () {
                        if (kDebugMode) {
                          print('login');
                        }
                        navigateTo(context, LoginScreen());
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
