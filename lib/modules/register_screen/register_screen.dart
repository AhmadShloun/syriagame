// ignore_for_file: import_of_legacy_library_into_null_safe, must_be_immutable, avoid_print, non_constant_identifier_names, unnecessary_null_comparison
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syriagames/models/Auth/Register_validation_model.dart';
import 'package:syriagames/modules/recaptcha/recaptcha.dart';
import 'package:syriagames/modules/register_screen/cubit/cubit.dart';
import 'package:syriagames/modules/register_screen/cubit/states.dart';
import 'package:syriagames/shared/components/components.dart';
import 'package:toast/toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  // bool _autoValidate = false;

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var password1Controller = TextEditingController();

  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    ToastContext().init(context);
    RegisterValidationModel? validationModel;

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterValidationErrorState) {
            print("ValidationError");
            validationModel = state.registerValidationModel;
            formKey.currentState!.validate();
          }
          if (state is RegisterValidationSuccessState) {
            print("ValidationSuccess");
            validationModel = state.registerValidationModel;
            formKey.currentState!.validate();
            showRecaptcha(context, screenWidth,phoneController.text);
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.black12,
            body: Stack(
              children: [
                Image(
                  width: screenWidth,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  image: const AssetImage('assets/images/game.jpg'),
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
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    'إنشاء حساب',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                defaultFormField(
                                  controller: nameController,
                                  type: TextInputType.name,
                                  hintText: 'الاسم',
                                  prefixIcon: Icons.drive_file_rename_outline,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return validationModel?.errors?.name
                                          .toString()
                                          .replaceAll('[', '')
                                          .replaceAll(']', '');
                                    } else {
                                      if (validationModel?.errors?.name ==
                                          null) {
                                        return null;
                                      } else {
                                        return validationModel!.errors!.name
                                            .toString()
                                            .replaceAll('[', '')
                                            .replaceAll(']', '');
                                      }
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  hintText: 'البريد الالكتروني',
                                  prefixIcon: Icons.email_outlined,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return validationModel?.errors?.email
                                          .toString()
                                          .replaceAll('[', '')
                                          .replaceAll(']', '');
                                    } else {
                                      if (validationModel?.errors?.email ==
                                          null) {
                                        return null;
                                      } else {
                                        return validationModel!.errors!.email
                                            .toString()
                                            .replaceAll('[', '')
                                            .replaceAll(']', '');
                                      }
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  controller: phoneController,
                                  type: TextInputType.phone,
                                  hintText: 'رقم الموبايل',
                                  prefixIcon: Icons.phone,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return validationModel?.errors?.phone
                                          .toString()
                                          .replaceAll('[', '')
                                          .replaceAll(']', '');
                                    } else {
                                      if (validationModel?.errors?.phone ==
                                          null) {
                                        return null;
                                      } else {
                                        return validationModel!.errors!.phone
                                            .toString()
                                            .replaceAll('[', '')
                                            .replaceAll(']', '');
                                      }
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  controller: password1Controller,
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
                                      return validationModel?.errors?.password
                                          .toString()
                                          .replaceAll('[', '')
                                          .replaceAll(']', '');
                                    } else {
                                      if (validationModel?.errors?.password ==
                                          null) {
                                        return null;
                                      } else {
                                        return validationModel!.errors!.password
                                            .toString()
                                            .replaceAll('[', '')
                                            .replaceAll(']', '');
                                      }
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  controller: confirmPasswordController,
                                  type: TextInputType.visiblePassword,
                                  hintText: 'تأكيد كلمة المرور',
                                  onPassword: cubit.isPasswordShow,
                                  prefixIcon: Icons.lock_outlined,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return validationModel
                                          ?.errors?.confirmPassword
                                          .toString()
                                          .replaceAll('[', '')
                                          .replaceAll(']', '');
                                    } else {
                                      if (validationModel
                                              ?.errors?.confirmPassword ==
                                          null) {
                                        return null;
                                      } else {
                                        return validationModel!
                                            .errors!.confirmPassword
                                            .toString()
                                            .replaceAll('[', '')
                                            .replaceAll(']', '');
                                      }
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 50.0,
                                ),
                                ConditionalBuilder(
                                  condition:
                                      state is! RegisterValidationLoadingState,
                                  builder: (context) => defaultButton(
                                    text: 'تسجيل',
                                    textSize: 18,
                                    background: HexColor('214a80'),
                                    function: () {
                                      formKey.currentState!.validate();
                                      cubit.registerValidation(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        password: password1Controller.text,
                                        confirm_password: confirmPasswordController.text,
                                      );
                                    },
                                  ),
                                  fallback: (context) => const Center(
                                      child: CircularProgressIndicator()),
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

showRecaptcha(context, double screenWidth,String phone) {
  showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            // insetPadding: EdgeInsets.symmetric(),

            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            insetPadding: const EdgeInsets.only(
              top: 175,
            ),
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.all(8.0),
            title: const Text(
              "تأكيد عملية التسجيل",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            content: Container(
              width: MediaQuery.of(context).size.width,
              // height: 550,
              // color: HexColor("0c152a"),
              child: Captcha(phone),
              // Captcha((String code) => print("Code returned ( Token ) : $code")),
            ),
          ),
        );
      });
}
