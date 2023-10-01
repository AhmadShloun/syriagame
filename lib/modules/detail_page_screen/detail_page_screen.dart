// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:hexcolor/hexcolor.dart';

Map<int, String> data = {
  1: 'assets/images/pricePubg/1.webp',
  2: 'assets/images/pricePubg/2.webp',
  3: 'assets/images/pricePubg/3.webp',
  4: 'assets/images/pricePubg/4.webp',
  5: 'assets/images/pricePubg/5.webp',
  6: 'assets/images/pricePubg/6.webp',
  7: 'assets/images/pricePubg/7.webp',
  8: 'assets/images/pricePubg/8.webp',
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

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final double screenHeight = MediaQuery.of(context).size.height;
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
        drawer: buildDrawer(context, screenWidth),
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
              childAspectRatio: 1 / 1.3,
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
          print(image.keys.elementAt(index));
          print(image.values.elementAt(index));
        }
        showDataAlert(context);
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(
            35.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.cyan.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage(image.values.elementAt(index)),
              ),
            ),
            Expanded(
              child: Container(
                // width: double.infinity,
                alignment: AlignmentDirectional.center,
                color: Colors.green,

                child: const Text(
                  "360000 ل.س",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                // padding: const EdgeInsets.all(12),
              ),
            )
          ],
        ),
      ),
    );

Widget buildDrawer(context, screenWidth) {
  return Container(
    // width: screenWidth * 0.75,
// decoration: BoxDecoration(
    //   gradient: LinearGradient(
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //       colors: [Colors.white, Colors.white24],
    //   ),
    // ),
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
                text: "رصيدي : ${'5000'}ل.س ",
                message: 'price',
                enabled: false),
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
    child: ListTile(
      contentPadding: const EdgeInsets.only(right: 20, left: 20),
      enabled: enabled,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        // side: BorderSide(color: Colors.black),
      ),
      tileColor: HexColor('818181').withOpacity(.5),
      hoverColor: Colors.green.withGreen(1),
      leading: Icon(
        icon,
        color: colorIcon,
      ),
      title: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
      onTap: () {
        if (kDebugMode) {
          print(message);
        }
        // Navigator.pop(context);
      },
    ),
  );
}
//Stack(
//           // alignment: AlignmentDirectional.bottomCenter,
//           children: [
//             Container(
//
//               clipBehavior: Clip.antiAlias,
//               decoration: BoxDecoration(
//                   color: Colors.green,
//                   borderRadius: BorderRadiusDirectional.circular(
//                     35.0,
//                   )),
//               child: Image(
//                 // height: 200,
//                 // width: 200,
//                 fit: BoxFit.cover,
//                 image: AssetImage(image.values.elementAt(index)),
//               ),
//             ),
//             SizedBox(height: 40,),
//             Container(
//               // color: Colors.green,
//               height: 35,
//               width: double.infinity,
//               alignment: AlignmentDirectional.bottomCenter,
//               decoration: BoxDecoration(
//                   color: Colors.green.withOpacity(.8),
//                   borderRadius: BorderRadiusDirectional.only(
//                     bottomEnd: Radius.circular(35),
//                     bottomStart: Radius.circular(35),
//                   )),
//               child: Text(
//                 '36000 ل.س',
//                 textAlign: TextAlign.center,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20
//                 ),
//               ),
//             )
//           ],
//         ),


showDataAlert(context) {
  showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            title: const Text(
              "تأكيد عملية الشراء",
              style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),
            ),
            content: SizedBox(
              height: 400,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Mention Your ID ",
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: const TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Id here',
                            labelText: 'ID'),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          // primary: Colors.black,
                          // fixedSize: Size(250, 50),
                        ),
                        child: const Text(
                          "Submit",
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text('Note'),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt'
                            ' ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud'
                            ' exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                            ' Duis aute irure dolor in reprehenderit in voluptate velit esse cillum '
                            'dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,'
                            ' sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
