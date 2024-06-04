import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:iconly/iconly.dart';
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

  int _tabIndex = 0;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
  }

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
        // body: Center(
        //   child: _widgetOptions.elementAt(_selectedIndex),
        // ),
        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   elevation: 6.0,
        //   backgroundColor: kWhite,
        //   selectedItemColor: kMainColor,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: const Icon(FeatherIcons.home),
        //       label: lang.S.of(context).home,
        //     ),
        //     BottomNavigationBarItem(
        //       icon: const Icon(FeatherIcons.shoppingCart),
        //       label: lang.S.of(context).sales,
        //     ),
        //     BottomNavigationBarItem(
        //       icon: const Icon(FeatherIcons.fileText),
        //       label: lang.S.of(context).reports,
        //     ),
        //     BottomNavigationBarItem(icon: const Icon(FeatherIcons.settings), label: lang.S.of(context).setting),
        //   ],
        //   currentIndex: _selectedIndex,
        //   onTap: _onItemTapped,
        // ),
        body: PageView(
          controller: pageController,
          onPageChanged: (v) {
            tabIndex = v;
          },
          children: const [
            HomeScreen(), SalesContact(), Reports(), SettingScreen()
          ],
        ),

        bottomNavigationBar: CircleNavBar(
          activeIcons:  const [
            Icon(IconlyBold.home, color: kMainColor),
            Icon(FeatherIcons.shoppingCart, color: kMainColor),
            Icon(FeatherIcons.fileText, color: kMainColor),
            Icon(FeatherIcons.settings, color: kMainColor),
          ],
          inactiveIcons: const [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(IconlyLight.home, color: kGreyTextColor),
                Text("Home",style: TextStyle(color: kGreyTextColor),),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FeatherIcons.shoppingCart, color: kGreyTextColor),
                Text("Sales",style: TextStyle(color: kGreyTextColor),),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FeatherIcons.fileText, color: kGreyTextColor),
                Text("Reports",style: TextStyle(color: kGreyTextColor),),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FeatherIcons.settings, color: kGreyTextColor),
                Text("Setting",style: TextStyle(color: kGreyTextColor),),
              ],
            ),
          ],
          color: Colors.white,
          height: 65,
          circleWidth: 60,
          activeIndex: tabIndex,
          onTap: (index) {
            tabIndex = index;
            pageController.jumpToPage(tabIndex);
          },
          padding:  EdgeInsets.zero,
          cornerRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),

          ),
          shadowColor: kBorderColorTextField,
          elevation: 2,
        ),

      ),
    );
  }
}

