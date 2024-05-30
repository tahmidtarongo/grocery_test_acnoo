
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_pos/Const/api_config.dart';
import 'package:mobile_pos/Screens/Profile%20Screen/profile_details.dart';
import 'package:mobile_pos/Screens/User%20Roles/user_role_screen.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;
import 'package:nb_utils/nb_utils.dart';

import '../../Provider/profile_provider.dart';
import '../../constant.dart';
import '../../currency.dart';
import '../../model/business_info_model.dart';
import '../Authentication/Repo/logout_repo.dart';
import '../Currency/currency_screen.dart';
import '../Shimmers/home_screen_appbar_shimmer.dart';
import '../language/language.dart';
import '../subscription/package_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String? dropdownValue = '\$ (US Dollar)';
  bool expanded = false;
  bool expandedHelp = false;
  bool expandedAbout = false;
  bool selected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    printerIsEnable();
    getCurrency();
  }

  getCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('currency');

    if (!data.isEmptyOrNull) {
      for (var element in items) {
        if (element.substring(0, 2).contains(data!)) {
          setState(() {
            dropdownValue = element;
          });
          break;
        }
      }
    } else {
      setState(() {
        dropdownValue = items[0];
      });
    }
  }

  void printerIsEnable() async {
    final prefs = await SharedPreferences.getInstance();

    isPrintEnable = prefs.getBool('isPrintEnable') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer(builder: (context, ref, _) {
        AsyncValue<BusinessInformation> businessInfo = ref.watch(businessInfoProvider);

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: businessInfo.when(data: (details) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              const ProfileDetails().launch(context);
                            },
                            child: Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                image: details.pictureUrl == null
                                    ? const DecorationImage(image: AssetImage('images/no_shop_image.png'), fit: BoxFit.cover)
                                    : DecorationImage(image: NetworkImage(APIConfig.domain + details.pictureUrl.toString()), fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                details.user?.role == 'staff' ? '${details.companyName ?? ''} [${details.user?.name ?? ''}]' : details.companyName ?? '',
                                style: GoogleFonts.poppins(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                details.category?.name ?? '',
                                style: GoogleFonts.poppins(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  color: kGreyTextColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }, error: (e, stack) {
                      return Text(e.toString());
                    }, loading: () {
                      return const HomeScreenAppBarShimmer();
                    }),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ListTile(
                  title: Text(
                    lang.S.of(context).profile,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  onTap: () {
                    const ProfileDetails().launch(context);
                  },
                  leading: const Icon(
                    Icons.person_outline_rounded,
                    color: kMainColor,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: kGreyTextColor,
                  ),
                ),
                ListTile(
                  title: Text(
                    lang.S.of(context).printing,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  leading: const Icon(
                    Icons.print,
                    color: kMainColor,
                  ),
                  trailing: Switch.adaptive(
                    value: isPrintEnable,
                    onChanged: (bool value) async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isPrintEnable', value);
                      setState(() {
                        isPrintEnable = value;
                      });
                    },
                  ),
                ),

                ///_________subscription_____________________________________________________
                ListTile(
                  title: Text(
                    lang.S.of(context).subscription,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  onTap: () {
                    const PackageScreen().launch(context);
                  },
                  leading: const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: kMainColor,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: kGreyTextColor,
                  ),
                ),

                ///___________user_role___________________________________________________________
                ListTile(
                  title: Text(
                    lang.S.of(context).userRole,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  onTap: () {
                    const UserRoleScreen().launch(context);
                  },
                  leading: const Icon(
                    Icons.supervised_user_circle_sharp,
                    color: kMainColor,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: kGreyTextColor,
                  ),
                ).visible(businessInfo.value?.user?.role != 'staff'),

                ///____________Currency________________________________________________
                ListTile(
                  onTap: () async {
                    await const CurrencyScreen().launch(context);

                    setState(() {});
                  },
                  title: Text(
                    lang.S.of(context).currency,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  leading: const Icon(
                    Icons.currency_exchange,
                    color: kMainColor,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '($currency)',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),

                ///_____________________________________________________________________________language
                ListTile(
                  title: Text(
                    lang.S.of(context).selectLang,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectLanguage(),
                    ),
                  ),
                  leading: Image.asset('images/en.png'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: kGreyTextColor,
                  ),
                ),

                ///__________log_Out_______________________________________________________________
                ListTile(
                  title: Text(
                    lang.S.of(context).logOut,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  onTap: () async {
                    ref.invalidate(businessInfoProvider);
                    EasyLoading.show(status: 'Log out');
                    LogOutRepo repo = LogOutRepo();
                    await repo.signOutApi(context: context, ref: ref);
                  },
                  leading: const Icon(
                    Icons.logout,
                    color: kMainColor,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: kGreyTextColor,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'DoSofto V-$appVersion',
                        style: GoogleFonts.poppins(
                          color: kGreyTextColor,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class NoticationSettings extends StatefulWidget {
  const NoticationSettings({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NoticationSettingsState createState() => _NoticationSettingsState();
}

class _NoticationSettingsState extends State<NoticationSettings> {
  bool notify = false;
  String notificationText = 'Off';

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 350.0,
      width: MediaQuery.of(context).size.width - 80,
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              IconButton(
                color: kGreyTextColor,
                icon: const Icon(Icons.cancel_outlined),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Container(
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              color: kDarkWhite,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Center(
              child: Icon(
                Icons.notifications_none_outlined,
                size: 50.0,
                color: kMainColor,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text(
              'Do Not Disturb',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur elit. Interdum cons.',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: kGreyTextColor,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                notificationText,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
              Switch(
                value: notify,
                onChanged: (val) {
                  setState(() {
                    notify = val;
                    val ? notificationText = 'On' : notificationText = 'Off';
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
