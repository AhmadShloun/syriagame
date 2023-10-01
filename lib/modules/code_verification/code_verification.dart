
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

class CodeVerificationScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var codeController = TextEditingController();

  CodeVerificationScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    ToastContext().init(context);
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
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
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'تأكيد ملكية الرقم',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                defaultFormField(
                                  controller: codeController,
                                  type: TextInputType.number,
                                  hintText: 'الكود',
                                  prefixIcon: Icons.verified_outlined,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'الرجاء ادخال كود التحقق';
                                    }
                                    return null;
                                  },
                                ),

                                ConditionalBuilder(
                                  condition: state is! LoginLoadingState,
                                  builder: (context) => Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: defaultButton(
                                        text: 'تحقق',
                                        textSize: 18,
                                        background: HexColor('214a80'),
                                        width: 180,
                                        height: 50,
                                        function: () {
                                          if (formKey.currentState!.validate()) {
                                            // navigateTo(context, const HomeScreen());
                                            // LoginCubit.get(context).userLogin(
                                            //   email: emailController.text,
                                            //   password: passwordController.text,
                                            // );
                                          }
                                        },
                                      ),
                                    ),
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
