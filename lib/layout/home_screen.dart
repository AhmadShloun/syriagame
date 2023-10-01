// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syriagames/modules/detail_page_screen/detail_page_screen.dart';
import 'package:syriagames/shared/components/components.dart';
import 'package:toast/toast.dart';
import 'package:hexcolor/hexcolor.dart';
Map<int, String> data = {
  1: 'assets/images/home/freefire.jpg',
  2: 'assets/images/home/pubg.jpg',
  3: 'assets/images/home/jawaker.jpg',
  4: 'assets/images/home/itunes.jpg',
  5: 'assets/images/home/bigolive.jpg',
  6: 'assets/images/home/likee.jpg',
};

PopupMenuItem _buildPopupMenuItem(
    {var value, String? title, IconData? iconData, bool? enabled}) {
  return PopupMenuItem(
    enabled: enabled!,
    value: value,
    child: Row(
      textDirection: TextDirection.rtl,
      children: [
        // Icon(iconData, color: Colors.black,),
        Text(
          title!,
          style: const TextStyle(color: Colors.black),
        ),
      ],
    ),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    // final double halfScreen = screenHeight / 2;
    // final double finalHeight = halfScreen / screenHeight;
    var appBarHeight = AppBar().preferredSize.height;

    ToastContext().init(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('343a40'),
          // titleSpacing: 20.0,
          // backwardsCompatibility: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.black54,
            statusBarIconBrightness: Brightness.light,
          ),
          actions: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: PopupMenuButton(
                padding: const EdgeInsets.all(10.0),
                icon: const Icon(
                  Icons.notifications,
                ),
                offset: Offset(0.0, appBarHeight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                itemBuilder: (context) {
                  return [
                    _buildPopupMenuItem(
                        value: 1, title: 'لايوجد اشعارات', enabled: false),
                    // PopupMenuItem<int>(
                    //   value: 0,
                    //   child: Text("لايوجد اشعارات"),
                    //   // enabled: false,
                    //   textStyle:TextStyle(color: Colors.black) ,
                    // ),
                    // PopupMenuItem<int>(
                    //   value: 1,
                    //   child: Text("لايوجد ",),
                    //   // enabled: false,
                    //   textStyle:TextStyle(color: Colors.black) ,
                    // ),
                  ];
                },
                onSelected: (value) {
                  if (kDebugMode) {
                    print(value);
                  }
                },
              ),
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: buildDrawer(context,screenWidth),
        backgroundColor: Colors.black12,
        body: Stack(
          children: [
            Image(
              width: screenWidth,
              height: double.infinity,
              fit: BoxFit.cover,
              image: const AssetImage('assets/images/home/back.jpg'),
            ),
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 35.0,
              crossAxisSpacing: 35.0,
              padding: const EdgeInsets.all(20),
              //1.58
              // childAspectRatio: 1 / 1.72,
              children: List.generate(
                data.length,
                (index) => buildGrid(data, index, context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildGrid(
  Map image,
  index,
  context,
) =>
    InkWell(
      onTap: () {
        if (kDebugMode) {
          print("ahmad");
          print(image.keys.elementAt(index));
          print(image.values.elementAt(index));

        }
        navigateTo(context, DetailScreen());
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(
          35.0,
        )),
        child: Image(
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
          image: AssetImage(image.values.elementAt(index)),
        ),
      ),
    );

Widget buildDrawer(context,screenWidth) {

  return Container(
    width: 300,
decoration: BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.white24],
      ),
    ),
    child: Drawer(
      elevation: 0.0,
      child: Container(
        color: HexColor('818181').withOpacity(.3),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const Image(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/iconGame.jpg'),
            ),
            const SizedBox(
              height: 10,
            ),
            ItemDrawer(
              context: context,
              icon: Icons.monetization_on_outlined,
              colorIcon: Colors.green,
              text: "رصيدي : ${'10000'}ل.س ",
              message: 'price',
              enabled: false
            ),
            ItemDrawer(
              context: context,
              icon: Icons.home_outlined,
              colorIcon: Colors.black.withOpacity(.6),
              text: 'الصفحة الرئيسية',
              message: 'home',
            ),
            ItemDrawer(
                context: context,
                icon: Icons.restore,
                colorIcon: Colors.black.withOpacity(.6),
                text: 'سجل النشاطات',
                message: 'restore history'),
            ItemDrawer(
              context: context,
              icon: Icons.message_outlined,
              colorIcon: Colors.black.withOpacity(.6),
              text: 'تواصل معنا',
              message: 'connect us',
            ),
            ItemDrawer(
              context: context,
              icon: Icons.person_rounded,
              colorIcon: Colors.black,
              text: 'تحويل الى حساب تجاري',
              message: 'bank Syria',
            ),
            ItemDrawer(
              context: context,
              icon: Icons.exit_to_app,
              colorIcon: Colors.black.withOpacity(.6),
              text: 'تسجيل الخروج',
              message: 'Logout',
            ),
          ],
        ),
      ),
    ),
  );
}

Widget ItemDrawer({
  required BuildContext context,
  required IconData icon,
  required Color colorIcon,
  required String text,
  required String message,
   bool enabled = true,
}) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(
          35.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(

        minLeadingWidth:0.0,
        // minVerticalPadding: 0.0,
        // contentPadding: const EdgeInsets.all(15),
        enabled:enabled ,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          // side: const BorderSide(color: Colors.black),
        ),
        tileColor: HexColor('818181').withOpacity(.5),
        hoverColor: Colors.green,
        leading: Icon(
          icon,
          color: colorIcon,
        ),
        title: Text(
          text,
          style: const TextStyle(color: Colors.black,),
        ),
        onTap: () {
          if (kDebugMode) {
            print('Ahmad');
          }
          // Navigator.pop(context);
        },
      ),
    ),
  );
}
