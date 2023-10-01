// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:syriagames/shared/components/constants.dart';
import 'package:syriagames/shared/network/local/cache_helper.dart';
import 'package:syriagames/shared/styles/colors.dart';
import 'package:toast/toast.dart';

Widget defaultButtonLoginAndRegister({
  Color background = Colors.blue,
  double width = double.infinity,
  double height = 40.0,
  double? radius = 10.0,
  @required String? text,
  required double textSize,
  @required Function? function,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.pink,
            blurRadius: 25,
          ),
        ],
      ),
      child: MaterialButton(
        // height: 40.0,
        onPressed: () {
          function!();
        },
        child: Text(
          text!,
          style: TextStyle(
            color: Colors.white,
            fontSize: textSize,
          ),
        ),
      ),

    );

//--------------------defaultButton----------------------------
Widget defaultButton({
  Color background = Colors.blue,
  double width = double.infinity,
  double height = 40.0,
  double? radius = 10.0,
  @required String? text,
  required double textSize,
  @required Function? function,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        color: background,
      ),
      child: MaterialButton(
        // height: 40.0,
        onPressed: () {
          function!();
        },
        child: Text(
          text!,
          style: TextStyle(
            color: Colors.white,
            fontSize: textSize,
          ),
        ),
      ),
    );

//--------------------defaultTextButton----------------------------
Widget defaultTextButton({
  @required Function()? function,
  @required String? text,
  @required double? size,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text!,
        style: TextStyle(
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dashed,

          fontSize: size,
        ),
        // letterSpacing: 4
      ),
    );

//--------------------defaultTextButton----------------------------
Widget defaultFormField({

  @required TextEditingController? controller,
  @required TextInputType? type,
  String? Function(String?)? onSubmitted,
  // @required String? labelText,
  @required String? hintText,
  IconData? prefixIcon,
  IconData? suffixIcon,
  Function? suffixPress,
  bool onPassword = false,
  Function(String)? onChange,
  @required String? Function(String?)? validate,
   // String? Function(String?)? onSave,
  var maxLines = 1,
}) =>
    Directionality (
      textDirection: TextDirection.rtl,
      child: TextFormField(
        // textDirection: TextDirection.rtl,

        style: TextStyle(color: white),
        controller: controller,
        keyboardType: type,
        maxLines: maxLines,
        obscureText: onPassword,
        onChanged: onChange,
        // onSaved: onSave,
        validator: validate,
        onFieldSubmitted: onSubmitted,

        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white30),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          // labelText: labelText,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: grey,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              suffixIcon,
              color: grey,
            ),
            onPressed: (){
              suffixPress!();
            },
          ),

          // border: OutlineInputBorder(),
        ),
      ),
    );

//--------------------myDivider----------------------------
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

//--------------------navigateTo----------------------------
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

//--------------------navigateAndFinish----------------------------
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

//--------------------Toast----------------------------
void showToast({
  required String text,
  required ToastStates state,
}) =>
    Toast.show(
      text,
      duration: Toast.lengthLong,
      gravity: Toast.bottom,
      backgroundColor: chooseToastColor(state),
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;

    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

//--------------Sing Up----------
void signOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      token = '';
      CacheHelper.removeData(
        key: 'role',
      ).then((value) {
        if (value) {
          // role='';
        }
      });
      // navigateAndFinish(context, LoginScreen(),);
    }
  });
}
