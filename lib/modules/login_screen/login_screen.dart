// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syriagames/layout/home_screen.dart';
import 'package:syriagames/modules/login_screen/cubit/cubit.dart';
import 'package:syriagames/modules/login_screen/cubit/states.dart';
import 'package:syriagames/modules/recaptcha/recaptcha.dart';
import 'package:syriagames/modules/register_screen/register_screen.dart';
import 'package:syriagames/shared/components/components.dart';
import 'package:toast/toast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:conditional_builder/conditional_builder.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final double halfScreen = screenHeight / 2;
    final double finalHeight = halfScreen / screenHeight;

    ToastContext().init(context);
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.black12,
            body: Stack(
              alignment: AlignmentDirectional.centerEnd,
              // textDirection: TextDirection.rtl,
              children: [
                Image(
                  width: screenWidth,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/game.jpg'),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 20,
                    end: 20,
                    top: 60,
                    bottom: 20,
                  ),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: HexColor('0c152a').withOpacity(.8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'تسجيل دخول',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                defaultFormField(
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  hintText: 'البريد الالكتروني',
                                  prefixIcon: Icons.email_outlined,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'الرجاء ادخال البريد الالكتروني';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 50.0,
                                ),
                                defaultFormField(
                                  controller: passwordController,
                                  type: TextInputType.visiblePassword,
                                  hintText: 'كلمة المرور',
                                  prefixIcon: Icons.lock_outlined,
                                  onPassword: cubit.isPasswordShow,
                                  suffixIcon: cubit.suffix,
                                  suffixPress: () {
                                    cubit.changePasswordVisibility();
                                  },
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'الرجاء ادخال كلمة المرور';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 50.0,
                                ),
                                ConditionalBuilder(
                                  condition: state is! LoginLoadingState,
                                  builder: (context) => defaultButton(
                                    text: 'تسجيل دخول',
                                    textSize: 18,
                                    background: HexColor('214a80'),
                                    width: 180,
                                    height: 50,
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        navigateTo(context, const HomeScreen());
                                        // LoginCubit.get(context).userLogin(
                                        //   email: emailController.text,
                                        //   password: passwordController.text,
                                        // );
                                      }
                                    },
                                  ),
                                  fallback: (context) => const Center(
                                      child: CircularProgressIndicator()),
                                ),
                                const SizedBox(
                                  height: 50.0,
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    defaultTextButton(
                                      text: 'إنشاء حساب جديد',
                                      size: 18,
                                      function: () {
                                        if (kDebugMode) {
                                          print('create acaount');
                                        }
                                        navigateTo(context, RegisterScreen());
                                      },
                                    ),
                                    const Spacer(),
                                    defaultTextButton(
                                      text: 'نسيت كلمة السر؟',
                                      size: 18,
                                      function: () {
                                        if (kDebugMode) {
                                          print('password forget');
                                        }
                                      },
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
