import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:mobile_pos/Screens/DashBoard/dashboard.dart';
import 'package:mobile_pos/Screens/Home/home_screen.dart';
import 'package:mobile_pos/Screens/Products/add_product.dart';
import 'package:mobile_pos/Screens/Report/reports_screen.dart';
import 'package:mobile_pos/Screens/Settings/settings_screen.dart';
import 'package:mobile_pos/constant.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;
import 'package:nb_utils/nb_utils.dart';
import '../Sales/customer_screen_for_sales.dart';
import '../internet checker/Internet_check_provider/util/network_observer_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  bool isNoInternet = false;

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
    return ProviderNetworkObserver(
      child: WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                lang.S.of(context).areYouSure,
                //'Are you sure?'
              ),
              content: Text(
                lang.S.of(context).doYouWantToExitTheApp,
                //'Do you want to exit the app?'
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    lang.S.of(context).no,
                    //'No'
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    lang.S.of(context).yes,
                    //  'Yes'
                  ),
                ),
              ],
            ),
          );
          return shouldPop ?? false; // Allow default back button behavior if dialog is dismissed
        },
        child: Scaffold(
          body: PageView(
            controller: pageController,
            onPageChanged: (v) {
              tabIndex = v;
            },
            children: const [
              HomeScreen(),
              DashboardScreen(),
              AddProduct(
                fromHome: true,
              ),
              Reports(),
              SettingScreen()
            ],
          ),
          bottomNavigationBar: CircleNavBar(
            activeIcons: [
              SvgPicture.asset(
                'assets/grocery/home.svg',
                fit: BoxFit.scaleDown,
                height: 28,
                width: 28,
                color: kMainColor,
              ),
              SvgPicture.asset(
                'assets/dashbord1.svg',
                height: 28,
                width: 28,
                fit: BoxFit.scaleDown,
                color: kMainColor,
              ),
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(color: kMainColor, borderRadius: BorderRadius.all(Radius.circular(50))),
                child: const Icon(
                  Icons.add,
                  color: kWhite,
                ),
              ),
              SvgPicture.asset(
                'assets/grocery/reports_grocery.svg',
                height: 28,
                width: 28,
                fit: BoxFit.scaleDown,
                color: kMainColor,
              ),
              SvgPicture.asset(
                'assets/cSetting.svg',
                height: 28,
                width: 28,
                fit: BoxFit.scaleDown,
                color: kMainColor,
              ),
            ],
            inactiveIcons: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/home.svg',
                    height: 24,
                    width: 24,
                    color: kGreyTextColor,
                  ),
                  Text(
                    lang.S.of(context).home,
                    //  "Home",
                    style: const TextStyle(color: kGreyTextColor),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/dashbord.svg',
                    height: 24,
                    width: 24,
                    color: kGreyTextColor,
                  ),
                  Text(
                    lang.S.of(context).dashboard,
                    //"Dashboard",
                    style: const TextStyle(color: kGreyTextColor),
                  ),
                ],
              ),
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(color: kMainColor, borderRadius: BorderRadius.all(Radius.circular(50))),
                child: const Icon(
                  Icons.add,
                  color: kWhite,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/file.svg',
                    height: 24,
                    width: 24,
                    color: kGreyTextColor,
                  ),
                  Text(
                    lang.S.of(context).reports,
                    // "Reports",
                    style: const TextStyle(color: kGreyTextColor),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/setting.svg',
                    height: 24,
                    width: 24,
                    color: kGreyTextColor,
                  ),
                  Text(
                    lang.S.of(context).setting,
                    //"Setting",
                    style: const TextStyle(color: kGreyTextColor),
                  ),
                ],
              ),
            ],
            color: Colors.white,
            height: 85,
            circleWidth: 60,
            activeIndex: tabIndex,
            onTap: (index) {
              tabIndex = index;
              pageController.jumpToPage(tabIndex);
            },
            padding: EdgeInsets.zero,
            cornerRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            shadowColor: kBorderColorTextField,
            elevation: 2,
          ),
        ),
      ),
    );
  }
}
