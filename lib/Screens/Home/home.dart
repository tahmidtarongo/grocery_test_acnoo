import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobile_pos/Screens/Home/home_screen.dart';
import 'package:mobile_pos/Screens/Report/reports.dart';
import 'package:mobile_pos/Screens/Settings/settings_screen.dart';
import 'package:mobile_pos/constant.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;
import '../Sales/sales_contact.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  bool isNoInternet = false;

  static const List<Widget> _widgetOptions = <Widget>[HomeScreen(), SalesContact(), Reports(), SettingScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // void signOutAutoLogin() async {
  //   CurrentUserData currentUserData = CurrentUserData();
  //   if (await currentUserData.isSubUserEmailNotFound() && isSubUser) {
  //     await FirebaseAuth.instance.signOut();
  //     Future.delayed(const Duration(milliseconds: 5000), () async {
  //       EasyLoading.showError('User is deleted');
  //     });
  //     Future.delayed(const Duration(milliseconds: 1000), () async {
  //       Restart.restartApp();
  //     });
  //   }
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   isSubUser ? signOutAutoLogin() : null;
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
        return shouldPop ?? false; // Allow default back button behavior if dialog is dismissed
      },
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 6.0,
          backgroundColor: kWhite,
          selectedItemColor: kMainColor,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(FeatherIcons.home),
              label: lang.S.of(context).home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(FeatherIcons.shoppingCart),
              label: lang.S.of(context).sales,
            ),
            BottomNavigationBarItem(
              icon: const Icon(FeatherIcons.fileText),
              label: lang.S.of(context).reports,
            ),
            BottomNavigationBarItem(icon: const Icon(FeatherIcons.settings), label: lang.S.of(context).setting),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}


// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   /// Controller to handle PageView and also handles initial page
//   final _pageController = PageController(initialPage: 0);
//
//   /// Controller to handle bottom nav bar and also handles initial page
//   final NotchBottomBarController _controller = NotchBottomBarController(index: 0);
//
//   int maxCount = 4;
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//
//     super.dispose();
//   }
//
//   int currentIndex=0;
//
//   @override
//   Widget build(BuildContext context) {
//     /// widget list
//     final List<Widget> bottomBarPages = [
//       HomeScreen(), SalesContact(), Reports(), SettingScreen()
//     ];
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),
//       ),
//       extendBody: true,
//       bottomNavigationBar: (bottomBarPages.length <= maxCount)
//           ? Container(
//         width: double.infinity,
//         color: kWhite,
//             child: AnimatedNotchBottomBar(
//                     /// Provide NotchBottomBarController
//                     notchBottomBarController: _controller,
//                     // circleMargin: 0,
//                     color: kWhite,
//                     showLabel: true,
//                     textOverflow: TextOverflow.visible,
//                     // showTopRadius: true,
//                     // maxLine: 1,
//                     // shadowElevation: 1,
//                     kBottomRadius: 0.0, // Set top radius to 30
//                     // notchColor: kWhite,
//                     /// restart app if you change removeMargins
//                     removeMargins: false,
//                     bottomBarWidth: double.infinity,
//                     bottomBarHeight: 50,
//                     showShadow: true,
//                     durationInMilliSeconds: 300,
//                     itemLabelStyle: const TextStyle(fontSize: 14,color: kGreyTextColor),
//                     elevation: 2,
//                     bottomBarItems: const [
//             BottomBarItem(
//               inActiveItem: Icon(
//                 FeatherIcons.home,
//                 color: kGreyTextColor,
//               ),
//               activeItem: Icon(
//                 FeatherIcons.home,
//                 color: kMainColor,
//               ),
//               itemLabel: 'Home',
//             ),
//             BottomBarItem(
//               inActiveItem: Icon(
//                 FeatherIcons.shoppingCart,
//                 color: kGreyTextColor,
//               ),
//               activeItem: Icon(
//                 FeatherIcons.shoppingCart,
//                 color: kMainColor,
//               ),
//               itemLabel: 'Sales',
//             ),
//             BottomBarItem(
//               inActiveItem: Icon(
//                 FeatherIcons.fileText,
//                 color: kGreyTextColor,
//               ),
//               activeItem: Icon(
//                 FeatherIcons.fileText,
//                 color: kMainColor,
//               ),
//               itemLabel: 'Reports',
//             ),
//             BottomBarItem(
//               inActiveItem: Icon(
//                 FeatherIcons.settings,
//                 color: kGreyTextColor,
//               ),
//               activeItem: Icon(
//                 FeatherIcons.settings,
//                 color: kMainColor,
//               ),
//               itemLabel: 'Setting',
//             ),
//                     ],
//                     onTap: (index) {
//             _pageController.jumpToPage(index);
//                     },
//                     kIconSize: 24.0,
//                   ),
//           )
//           : null,
//       // bottomNavigationBar: Stack(
//       //   children: [
//       //     Container(
//       //       height: 71,
//       //       width: double.infinity,
//       //       decoration: const BoxDecoration(
//       //         borderRadius: BorderRadius.only(
//       //           topLeft: Radius.circular(24),
//       //           topRight: Radius.circular(24)
//       //         ),
//       //         color: kWhite
//       //       ),
//       //       child: Padding(
//       //         padding: const EdgeInsets.symmetric(horizontal: 16),
//       //         child: Row(
//       //           crossAxisAlignment: CrossAxisAlignment.center,
//       //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //           children: [
//       //             GestureDetector(
//       //               onTap: (){
//       //                 setState(() {
//       //                   currentIndex=0;
//       //                 });
//       //               },
//       //               child: Column(
//       //                 mainAxisAlignment: MainAxisAlignment.center,
//       //                 children: [
//       //                   Icon(FeatherIcons.home,color: kGreyTextColor,),
//       //                   Text('Home'),
//       //                 ],
//       //               ),
//       //             ),
//       //             Column(
//       //               mainAxisAlignment: MainAxisAlignment.center,
//       //               children: [
//       //                 Icon(FeatherIcons.shoppingCart,color: kGreyTextColor,),
//       //                 Text('Sales'),
//       //               ],
//       //             ),
//       //             Column(
//       //               mainAxisAlignment: MainAxisAlignment.center,
//       //               children: [
//       //                 Icon(FeatherIcons.fileText,color: kGreyTextColor,),
//       //                 Text('Reports'),
//       //               ],
//       //             ),
//       //             Column(
//       //               mainAxisAlignment: MainAxisAlignment.center,
//       //               children: [
//       //                 Icon(FeatherIcons.settings,color: kGreyTextColor,),
//       //                 Text('Setting'),
//       //               ],
//       //             ),
//       //
//       //           ],
//       //         ),
//       //       ),
//       //     ),
//       //   ],
//       // ),
//
//     );
//   }
// }
