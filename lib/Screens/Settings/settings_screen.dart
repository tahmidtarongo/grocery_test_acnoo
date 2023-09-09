import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_pos/Screens/Profile%20Screen/profile_details.dart';
import 'package:mobile_pos/Screens/SplashScreen/splash_screen.dart';
import 'package:mobile_pos/Screens/User%20Roles/user_role_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:restart_app/restart_app.dart';
import '../../Provider/profile_provider.dart';
import '../../constant.dart';
import '../../currency.dart';
import '../../model/personal_information_model.dart';
import '../Currency/currency_screen.dart';
import '../Shimmers/home_screen_appbar_shimmer.dart';
import '../language/language.dart';
import '../subscription/package_screen.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;

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

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    EasyLoading.showSuccess('Successfully Logged Out');
  }

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
        AsyncValue<PersonalInformationModel> userProfileDetails = ref.watch(profileDetailsProvider);

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: userProfileDetails.when(data: (details) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              isSubUser ? null : const ProfileDetails().launch(context);
                            },
                            child: Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage(details.pictureUrl ?? ''), fit: BoxFit.cover),
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
                                isSubUser ? '${details.companyName ?? ''} [$subUserTitle]' : details.companyName ?? '',
                                style: GoogleFonts.poppins(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                details.businessCategory ?? '',
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
                ).visible(!isSubUser),
                // ListTile(
                //   onTap: () => EasyLoading.showError('Coming Soon'),
                //   title: Text(
                //     'Create Online Store',
                //     style: GoogleFonts.poppins(
                //       color: Colors.black,
                //       fontSize: 18.0,
                //     ),
                //   ),
                //   leading: const Icon(
                //     Icons.shopping_bag_outlined,
                //     color: kMainColor,
                //   ),
                //   trailing: const Icon(
                //     Icons.arrow_forward_ios,
                //     color: kGreyTextColor,
                //   ),
                // ),
                // ExpansionPanelList(
                //   expandedHeaderPadding: EdgeInsets.zero,
                //   expansionCallback: (int index, bool isExpanded) {},
                //   animationDuration: const Duration(seconds: 1),
                //   elevation: 0,
                //   dividerColor: Colors.white,
                //   children: [
                //     ExpansionPanel(
                //       headerBuilder: (BuildContext context, bool isExpanded) {
                //         return Row(
                //           children: [
                //             const Padding(
                //               padding: EdgeInsets.only(left: 16.0),
                //               child: Icon(
                //                 Icons.handyman_outlined,
                //                 color: kMainColor,
                //               ),
                //             ),
                //             TextButton(
                //               child: Padding(
                //                 padding: const EdgeInsets.only(left: 24.0),
                //                 child: Text(
                //                   'Settings',
                //                   style: GoogleFonts.poppins(
                //                     fontSize: 18.0,
                //                     color: expanded == false ? Colors.black : kMainColor,
                //                   ),
                //                 ),
                //               ),
                //               onPressed: () {
                //                 EasyLoading.showError('Coming Soon');
                //                 // setState(() {
                //                 //   expanded == false ? expanded = true : expanded = false;
                //                 // });
                //               },
                //             ),
                //           ],
                //         );
                //       },
                //       body: Column(
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(left: 55.0),
                //             child: ListTile(
                //               title: Text(
                //                 'Notification Setting',
                //                 style: GoogleFonts.poppins(
                //                   color: Colors.black,
                //                   fontSize: 16.0,
                //                 ),
                //               ),
                //               trailing: const Icon(
                //                 Icons.arrow_forward_ios,
                //                 color: kGreyTextColor,
                //                 size: 16.0,
                //               ),
                //               onTap: () => showDialog(
                //                 context: context,
                //                 builder: (BuildContext context) => Dialog(
                //                   shape: RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.circular(12.0),
                //                   ),
                //                   child: const NoticationSettings(),
                //                 ),
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(left: 55.0),
                //             child: ListTile(
                //               title: Text(
                //                 'Language Setting',
                //                 style: GoogleFonts.poppins(
                //                   color: Colors.black,
                //                   fontSize: 16.0,
                //                 ),
                //               ),
                //               onTap: () => showDialog(
                //                 context: context,
                //                 builder: (BuildContext context) => Dialog(
                //                   shape: RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.circular(12.0),
                //                   ),
                //                   // ignore: sized_box_for_whitespace
                //                   child: Container(
                //                     height: 400.0,
                //                     width: MediaQuery.of(context).size.width - 80,
                //                     child: Column(
                //                       children: [
                //                         const SizedBox(
                //                           height: 20.0,
                //                         ),
                //                         Text(
                //                           'Select Language',
                //                           style: GoogleFonts.poppins(
                //                             color: Colors.black,
                //                             fontSize: 20.0,
                //                             fontWeight: FontWeight.bold,
                //                           ),
                //                         ),
                //                         ...List.generate(
                //                           language.length,
                //                           (index) => ListTile(
                //                             title: Text(language[index]),
                //                             trailing: const Icon(
                //                               Icons.check_circle_outline,
                //                               color: kGreyTextColor,
                //                             ),
                //                             onTap: () {
                //                               setState(() {
                //                                 selected == false ? selected = true : selected = false;
                //                               });
                //                               Navigator.pop(context);
                //                             },
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               trailing: const Icon(
                //                 Icons.arrow_forward_ios,
                //                 color: kGreyTextColor,
                //                 size: 16.0,
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(left: 55.0),
                //             child: ListTile(
                //               title: Text(
                //                 'Online Store Setting',
                //                 style: GoogleFonts.poppins(
                //                   color: Colors.black,
                //                   fontSize: 16.0,
                //                 ),
                //               ),
                //               trailing: const Icon(
                //                 Icons.arrow_forward_ios,
                //                 color: kGreyTextColor,
                //                 size: 16.0,
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(left: 55.0),
                //             child: ListTile(
                //               title: Text(
                //                 'App Update',
                //                 style: GoogleFonts.poppins(
                //                   color: Colors.black,
                //                   fontSize: 16.0,
                //                 ),
                //               ),
                //               trailing: const Icon(
                //                 Icons.arrow_forward_ios,
                //                 color: kGreyTextColor,
                //                 size: 16.0,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       isExpanded: expanded,
                //     ),
                //   ],
                // ),
                // ExpansionPanelList(
                //   expandedHeaderPadding: EdgeInsets.zero,
                //   expansionCallback: (int index, bool isExpanded) {},
                //   animationDuration: const Duration(seconds: 1),
                //   elevation: 0,
                //   dividerColor: Colors.white,
                //   children: [
                //     ExpansionPanel(
                //       headerBuilder: (BuildContext context, bool isExpanded) {
                //         return Row(
                //           children: [
                //             const Padding(
                //               padding: EdgeInsets.only(left: 16.0),
                //               child: Icon(
                //                 Icons.help_outline_rounded,
                //                 color: kMainColor,
                //               ),
                //             ),
                //             TextButton(
                //               child: Padding(
                //                 padding: const EdgeInsets.only(left: 24.0),
                //                 child: Text(
                //                   'Help & Support',
                //                   style: GoogleFonts.poppins(
                //                     fontSize: 18.0,
                //                     color: expandedHelp == false ? Colors.black : kMainColor,
                //                   ),
                //                 ),
                //               ),
                //               onPressed: () {
                //                 EasyLoading.showError('Coming Soon');
                //                 // setState(() {
                //                 //   expandedHelp == false ? expandedHelp = true : expandedHelp = false;
                //                 // });
                //               },
                //             ),
                //           ],
                //         );
                //       },
                //       body: Column(
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(left: 55.0),
                //             child: ListTile(
                //               title: Text(
                //                 'FAQs',
                //                 style: GoogleFonts.poppins(
                //                   color: Colors.black,
                //                   fontSize: 16.0,
                //                 ),
                //               ),
                //               trailing: const Icon(
                //                 Icons.arrow_forward_ios,
                //                 color: kGreyTextColor,
                //                 size: 16.0,
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(left: 55.0),
                //             child: ListTile(
                //               onTap: () {
                //                 const ContactUs().launch(context);
                //               },
                //               title: Text(
                //                 'Contact Us',
                //                 style: GoogleFonts.poppins(
                //                   color: Colors.black,
                //                   fontSize: 16.0,
                //                 ),
                //               ),
                //               trailing: const Icon(
                //                 Icons.arrow_forward_ios,
                //                 color: kGreyTextColor,
                //                 size: 16.0,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       isExpanded: expandedHelp,
                //     ),
                //   ],
                // ),
                // ExpansionPanelList(
                //   expandedHeaderPadding: EdgeInsets.zero,
                //   expansionCallback: (int index, bool isExpanded) {},
                //   animationDuration: const Duration(seconds: 1),
                //   elevation: 0,
                //   dividerColor: Colors.white,
                //   children: [
                //     ExpansionPanel(
                //       headerBuilder: (BuildContext context, bool isExpanded) {
                //         return Row(
                //           children: [
                //             const Padding(
                //               padding: EdgeInsets.only(left: 16.0),
                //               child: Icon(
                //                 Icons.text_snippet_outlined,
                //                 color: kMainColor,
                //               ),
                //             ),
                //             TextButton(
                //               child: Padding(
                //                 padding: const EdgeInsets.only(left: 24.0),
                //                 child: Text(
                //                   'About Us',
                //                   style: GoogleFonts.poppins(
                //                     fontSize: 18.0,
                //                     color: expandedAbout == false ? Colors.black : kMainColor,
                //                   ),
                //                 ),
                //               ),
                //               onPressed: () {
                //                 EasyLoading.showError('Coming Soon');
                //                 // setState(() {
                //                 //   expandedAbout == false ? expandedAbout = true : expandedAbout = false;
                //                 // });
                //               },
                //             ),
                //           ],
                //         );
                //       },
                //       body: Column(
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(left: 55.0),
                //             child: ListTile(
                //               title: Text(
                //                 'About Sales Pro',
                //                 style: GoogleFonts.poppins(
                //                   color: Colors.black,
                //                   fontSize: 16.0,
                //                 ),
                //               ),
                //               trailing: const Icon(
                //                 Icons.arrow_forward_ios,
                //                 color: kGreyTextColor,
                //                 size: 16.0,
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(left: 55.0),
                //             child: ListTile(
                //               title: Text(
                //                 'Privacy Policy',
                //                 style: GoogleFonts.poppins(
                //                   color: Colors.black,
                //                   fontSize: 16.0,
                //                 ),
                //               ),
                //               trailing: const Icon(
                //                 Icons.arrow_forward_ios,
                //                 color: kGreyTextColor,
                //                 size: 16.0,
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(left: 55.0),
                //             child: ListTile(
                //               title: Text(
                //                 'Terms & Conditions',
                //                 style: GoogleFonts.poppins(
                //                   color: Colors.black,
                //                   fontSize: 16.0,
                //                 ),
                //               ),
                //               trailing: const Icon(
                //                 Icons.arrow_forward_ios,
                //                 color: kGreyTextColor,
                //                 size: 16.0,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       isExpanded: expandedAbout,
                //     ),
                //   ],
                // ),
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
                    // const SubscriptionScreen().launch(context);
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
                ).visible(!isSubUser),

                ///____________Currency________________________________________________
                ListTile(
                  onTap: () async {
                    await const CurrencyScreen().launch(context);

                    setState(() {});

                    // showCurrencyPicker(
                    //   context: context,
                    //   showFlag: true,
                    //   showCurrencyName: true,
                    //   showCurrencyCode: true,
                    //   onSelect: (Currency c) async {
                    //     final prefs = await SharedPreferences.getInstance();
                    //     await prefs.setString('currency', c.symbol);
                    //     await prefs.setString('currencyName', c.name);
                    //     setState(() {
                    //       currency = c.symbol;
                    //       currencyName = c.name;
                    //     });
                    //   },
                    // );
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
                    EasyLoading.show(status: 'Log out');
                    await _signOut();
                    Future.delayed(const Duration(milliseconds: 1000), () async {
                      ///________subUser_logout___________________________________________________
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isSubUser', false);
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        if ((Theme.of(context).platform == TargetPlatform.android)) {
                          Restart.restartApp();
                        } else {
                          const SplashScreen().launch(context, isNewTask: true);
                        }

                        // const SignInScreen().launch(context);
                      });
                      // Phoenix.rebirth(context);
                    });
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
                        'Salespro V-$appVersion',
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
