import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mobile_pos/Const/api_config.dart';
import 'package:mobile_pos/GlobalComponents/button_global.dart';
import 'package:mobile_pos/Provider/product_provider.dart';
import 'package:mobile_pos/Screens/DashBoard/dashboard.dart';
import 'package:mobile_pos/Screens/Home/components/grid_items.dart';
import 'package:mobile_pos/Screens/Products/Model/product_model.dart';
import 'package:mobile_pos/Screens/Products/Providers/category,brans,units_provide.dart';
import 'package:mobile_pos/Screens/Profile%20Screen/profile_details.dart';
import 'package:mobile_pos/currency.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;
import 'package:nb_utils/nb_utils.dart';
import '../../Provider/profile_provider.dart';
import '../../constant.dart';
import '../../model/business_info_model.dart' as business;
import '../subscription/package_screen.dart';
import 'Provider/banner_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Color> color = [
    const Color(0xffEDFAFF),
    const Color(0xffFFF6ED),
    const Color(0xffEAFFEA),
    const Color(0xffEAFFEA),
    const Color(0xffEDFAFF),
    const Color(0xffFFF6ED),
    const Color(0xffFFF6ED),
    const Color(0xffEAFFEA),
    const Color(0xffEDFAFF),
    const Color(0xffEAFFEA),
    const Color(0xffFFF6ED),
  ];

  String customerPackage = '';
  PageController pageController = PageController(initialPage: 0);
  TextEditingController productSearchController = TextEditingController();

  void getUpgradeDilog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: kWhite,
            surfaceTintColor: kWhite,
            elevation: 0.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            contentPadding: const EdgeInsets.all(20),
            titlePadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: kGreyTextColor,
                        )),
                  ],
                ),
                SvgPicture.asset(
                  'assets/upgradePlan.svg',
                  height: 198,
                  width: 238,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  lang.S.of(context).endYourFreePlan,
                  // 'End your Free plan',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: kTitleColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  lang.S.of(context).yourFree,
                  // 'Your Free Package is almost done, buy your next plan Thanks.',
                  style: gTextStyle.copyWith(color: kGreyTextColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                UpdateButton(
                    text: lang.S.of(context).upgradeNow,
                    //'Upgrade Now',
                    onpressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PackageScreen()));
                    }),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          );
        });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
    productSearchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    freeIcons = getFreeIcons(context: context);
    return SafeArea(
      child: Consumer(builder: (_, ref, __) {
        final businessInfo = ref.watch(businessInfoProvider);
        final summaryInfo = ref.watch(summaryInfoProvider);
        final banner = ref.watch(bannerProvider);
        final category = ref.watch(categoryProvider);
        final product = ref.watch(productProvider);
        return businessInfo.when(data: (details) {
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: kBackgroundColor,

            ///______Drawer__________________________
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[],
              ),
            ),

            ///______App_Bar__________________________
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: kMainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                ),
                child: AppBar(
                  toolbarHeight: 100,
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  leading: IconButton(
                    splashColor: Colors.white,
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    icon: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        // border: Border.all(width: 1, color: Colors.white.withOpacity(0.5)),
                      ),
                      child: const Icon(Icons.menu),
                    ),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        details.user?.role == 'staff' ? '${details.companyName ?? ''} [${details.user?.name ?? ''}]' : details.companyName ?? '',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(Radius.circular(50)),
                            border: Border.all(width: 1, color: Colors.white.withOpacity(0.5))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                          child: Text(
                            "${details.enrolledPlan?.plan?.subscriptionName ?? ''} Plan",
                            style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // actions: const [
                  //   Padding(
                  //     padding: EdgeInsets.all(15.0),
                  //     child: Badge(
                  //         child: Icon(
                  //       FeatherIcons.bell,
                  //       color: Colors.white,
                  //     )),
                  //   )
                  // ],
                ),
              ),
            ),
            resizeToAvoidBottomInset: true,

            ///______Body________________________________
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///_______Cart_________________________________
                          Container(
                            decoration: const BoxDecoration(color: kMainColor, borderRadius: BorderRadius.all(Radius.circular(15))),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 47,
                                    width: 62,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            height: 40,
                                            width: 55,
                                            decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(8)), border: Border.all(color: Colors.white, width: 2)),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          width: 55,
                                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: Colors.white),
                                          child: const Center(
                                              child: Text(
                                            '2',
                                            style: TextStyle(fontSize: 20, color: Colors.black),
                                          )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    '\$500.00',
                                    style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 22,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          ///______category_______________________________
                          const Text(
                            'Categories',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            child: category.when(
                              data: (data) {
                                return ListView.builder(
                                  itemCount: data.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        children: [
                                          const CircleAvatar(
                                            minRadius: 30,
                                            foregroundColor: Colors.red,
                                          ),
                                          Text(data[index].categoryName.toString()),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              error: (error, stackTrace) => const Text('Could not fetch the categories'),
                              loading: () => const CircularProgressIndicator(),
                            ),
                          ),

                          ///________Search_______________________________
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: productSearchController,
                              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Search here....', suffixIcon: Icon(IconlyLight.search)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              const TextSpan(text: '25 All', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                              TextSpan(
                                  text: ' items For',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                  )),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.grid_view_rounded,
                                  color: Colors.grey.shade600,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.grey.shade600,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: product.when(
                      data: (data) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 500,
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: 2 / 2.5,
                            ),
                            itemCount: data.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: data[index].productPicture == null ? Image.asset(noProductImageUrl) : Image.network(data[index].productPicture ?? ''),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    data[index].productName ?? '',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text('1 Kg'),
                                  SizedBox(height: 4.0),
                                  Text('\$${data[index].productSalePrice?.toStringAsFixed(2)}'),
                                ],
                              );
                            },
                          ),
                        );
                      },
                      error: (error, stackTrace) => const Text('Could not fetch products'),
                      loading: () => const CircularProgressIndicator(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: businessInfo.when(data: (details) {
                        //     return Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Row(
                        //         children: [
                        //           // GestureDetector(
                        //           //   onTap: () {
                        //           //     const ProfileDetails().launch(context);
                        //           //   },
                        //           //   child: Container(
                        //           //     height: 50,
                        //           //     width: 50,
                        //           //     decoration: details.pictureUrl == null
                        //           //         ? BoxDecoration(
                        //           //             image: const DecorationImage(image: AssetImage('images/no_shop_image.png'), fit: BoxFit.cover),
                        //           //             borderRadius: BorderRadius.circular(50),
                        //           //           )
                        //           //         : BoxDecoration(
                        //           //             image: DecorationImage(image: NetworkImage('${APIConfig.domain}${details.pictureUrl}'), fit: BoxFit.cover),
                        //           //             borderRadius: BorderRadius.circular(50),
                        //           //           ),
                        //           //   ),
                        //           // ),
                        //           // const SizedBox(
                        //           //   width: 15.0,
                        //           // ),
                        //           // Column(
                        //           //   mainAxisAlignment: MainAxisAlignment.start,
                        //           //   crossAxisAlignment: CrossAxisAlignment.start,
                        //           //   children: [
                        //           //     Text(
                        //           //       details.user?.role == 'staff'? '${details.companyName ?? ''} [${details.user?.name??''}]' : details.companyName ?? '',
                        //           //       style: GoogleFonts.poppins(
                        //           //         fontSize: 20.0,
                        //           //         fontWeight: FontWeight.w600,
                        //           //         color: Colors.black,
                        //           //       ),
                        //           //     ),
                        //           //     Text(
                        //           //       "${details.enrolledPlan?.plan?.subscriptionName ?? ''} Plan",
                        //           //       style: GoogleFonts.poppins(
                        //           //         color: Colors.black,
                        //           //       ),
                        //           //     ),
                        //           //   ],
                        //           // ),
                        //           // const Spacer(),
                        //           // Container(
                        //           //   height: 40.0,
                        //           //   width: 86.0,
                        //           //   decoration: BoxDecoration(
                        //           //     borderRadius: BorderRadius.circular(10.0),
                        //           //     color: Color(0xFFD9DDE3).withOpacity(0.5),
                        //           //   ),
                        //           //   child: Center(
                        //           //     child: Text(
                        //           //       '$currency 450',
                        //           //       style: GoogleFonts.poppins(
                        //           //         fontSize: 20.0,
                        //           //         color: Colors.black,
                        //           //       ),
                        //           //     ),
                        //           //   ),
                        //           // ),
                        //           // SizedBox(
                        //           //   width: 10.0,
                        //           // ),
                        //           Container(
                        //             height: 40.0,
                        //             width: 40.0,
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(10.0),
                        //               color: kDarkWhite,
                        //             ),
                        //             child: Center(
                        //               child: GestureDetector(
                        //                 onTap: () {
                        //                   EasyLoading.showInfo('Coming Soon');
                        //                 },
                        //                 child: const Icon(
                        //                   Icons.notifications_active,
                        //                   color: kMainColor,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     );
                        //   }, error: (e, stack) {
                        //     return Text(e.toString());
                        //   }, loading: () {
                        //     return const HomeScreenAppBarShimmer();
                        //   }),
                        // ),
                        summaryInfo.when(data: (summary) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: kMainColor),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Row(
                                //   children: [
                                //     Text(
                                //      lang.S.of(context).todaySummary,
                                //       //'Today’s Summary',
                                //       style: gTextStyle.copyWith(fontWeight: FontWeight.bold, color: kWhite, fontSize: 18),
                                //     ),
                                //     const Spacer(),
                                //     GestureDetector(
                                //         onTap: () {
                                //           Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
                                //         },
                                //         child: Text(
                                //           lang.S.of(context).sellAll,
                                //
                                //           //'Sell All >',
                                //           style: const TextStyle(color: kWhite, fontWeight: FontWeight.w500),
                                //         )),
                                //   ],
                                // ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        lang.S.of(context).todaySummary,
                                        //'Today’s Summary',
                                        style: gTextStyle.copyWith(fontWeight: FontWeight.bold, color: kWhite, fontSize: 18),
                                        maxLines: 1, overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Spacer(),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
                                          },
                                          child: Text(
                                            lang.S.of(context).sellAll,

                                            //'Sell All >',
                                            style: const TextStyle(color: kWhite, fontWeight: FontWeight.w500),
                                            maxLines: 1,
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang.S.of(context).sales,
                                          //'Sales',
                                          style: gTextStyle.copyWith(color: kWhite),
                                        ),
                                        Text(
                                          '$currency ${summary.data?.sales ?? 0}',
                                          style: gTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          lang.S.of(context).income,
                                          //'Income',
                                          style: gTextStyle.copyWith(color: kWhite),
                                        ),
                                        Text(
                                          '$currency ${summary.data?.income ?? 0}',
                                          style: gTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang.S.of(context).purchased,
                                          // 'Purchased',
                                          style: gTextStyle.copyWith(color: kWhite),
                                        ),
                                        Text(
                                          '$currency ${summary.data?.purchase ?? 0}',
                                          style: gTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          //'Expense',
                                          lang.S.of(context).expense,
                                          style: gTextStyle.copyWith(color: kWhite),
                                        ),
                                        Text(
                                          '$currency ${summary.data?.expense ?? 0}',
                                          style: gTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 30),
                                  ],
                                )
                              ],
                            ),
                          );
                        }, error: (e, stack) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: kMainColor),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      lang.S.of(context).todaySummary,
                                      //'Today’s Summary',
                                      style: gTextStyle.copyWith(fontWeight: FontWeight.bold, color: kWhite, fontSize: 18),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
                                        },
                                        child: Text(
                                          lang.S.of(context).sellAll,
                                          //'Sell All >',
                                          style: const TextStyle(color: kWhite, fontWeight: FontWeight.w500),
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang.S.of(context).sales,
                                          //'Sales',
                                          style: gTextStyle.copyWith(color: kWhite),
                                        ),
                                        Text(
                                          lang.S.of(context).notFound,
                                          // 'Not Found',
                                          style: gTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          lang.S.of(context).income,
                                          // 'Income',
                                          style: gTextStyle.copyWith(color: kWhite),
                                        ),
                                        Text(
                                          lang.S.of(context).notFound,
                                          //'Not Found',
                                          style: gTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang.S.of(context).purchased,
                                          // 'Purchased',
                                          style: gTextStyle.copyWith(color: kWhite),
                                        ),
                                        Text(
                                          lang.S.of(context).notFound,
                                          //'Not Found',
                                          style: gTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          lang.S.of(context).expense,
                                          //'Expense',
                                          style: gTextStyle.copyWith(color: kWhite),
                                        ),
                                        Text(
                                          lang.S.of(context).notFound,
                                          //'Not Found',
                                          style: gTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }, loading: () {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: kMainColor),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      lang.S.of(context).todaySummary,
                                      // 'Today’s Summary',
                                      style: gTextStyle.copyWith(fontWeight: FontWeight.bold, color: kWhite, fontSize: 18),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
                                        },
                                        child: Text(
                                          lang.S.of(context).sellAll,
                                          //'Sell All >',
                                          style: const TextStyle(color: kWhite, fontWeight: FontWeight.w500),
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang.S.of(context).sales,
                                          // 'Sales',
                                          style: gTextStyle.copyWith(color: kWhite),
                                        ),
                                        Text(
                                          lang.S.of(context).loading,
                                          // 'Loading',
                                          style: gTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          lang.S.of(context).income,
                                          //'Income',
                                          style: gTextStyle.copyWith(color: kWhite),
                                        ),
                                        Text(
                                          lang.S.of(context).loading,
                                          //'Loading',
                                          style: gTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang.S.of(context).purchased,
                                          //'Purchased',
                                          style: gTextStyle.copyWith(color: kWhite),
                                        ),
                                        Text(
                                          lang.S.of(context).loading,
                                          //'Loading',
                                          style: gTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          lang.S.of(context).expense,
                                          //'Expense',
                                          style: gTextStyle.copyWith(color: kWhite),
                                        ),
                                        Text(
                                          lang.S.of(context).loading,
                                          //'Loading',
                                          style: gTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),

                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            getUpgradeDilog();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: kWhite,
                                boxShadow: [BoxShadow(color: const Color(0xffC52127).withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 10))]),
                            child: ListTile(
                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                              horizontalTitleGap: 20,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                              leading: SvgPicture.asset(
                                'assets/plan.svg',
                                height: 38,
                                width: 38,
                              ),
                              title: RichText(
                                  text: TextSpan(
                                      text: '${details.enrolledPlan?.plan?.subscriptionName} ${lang.S.of(context).package} ',
                                      style: gTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold, fontSize: 16),
                                      children: [
                                    TextSpan(
                                        text:
                                            '(${(DateTime.parse(details.subscriptionDate ?? '').difference(DateTime.now()).inDays.abs() - (details.enrolledPlan?.duration ?? 0)).abs()} Days Left)',
                                        style: gTextStyle.copyWith(color: kGreyTextColor, fontWeight: FontWeight.w400))
                                  ])),
                              subtitle: Text(
                                lang.S.of(context).updateYourSubscription,
                                //'Update your subscription',
                                style: gTextStyle.copyWith(color: kGreyTextColor, fontSize: 14),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                color: kGreyTextColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          childAspectRatio: 3.0,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: List.generate(
                            freeIcons.length,
                            (index) => HomeGridCards(
                              gridItems: freeIcons[index],
                              color: color[index],
                              visibility: businessInfo.value?.user?.visibility,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 10),

                        ///________________Banner_______________________________________
                        banner.when(data: (images) {
                          if (images.isNotEmpty) {
                            return SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    lang.S.of(context).whatNew,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        child: const Icon(Icons.keyboard_arrow_left),
                                        onTap: () {
                                          pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.linear);
                                        },
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        height: 150,
                                        width: MediaQuery.of(context).size.width - 80,
                                        child: PageView.builder(
                                          pageSnapping: true,
                                          itemCount: images.length,
                                          controller: pageController,
                                          itemBuilder: (_, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                const PackageScreen().launch(context);
                                              },
                                              child: Image(
                                                image: NetworkImage(
                                                  "${APIConfig.domain}${images[index].imageUrl}",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            );

                                            ///_________Youtube_video_player___________________________________________________
                                            // if (images[index].imageUrl.contains('https://firebasestorage.googleapis.com')) {
                                            //   return GestureDetector(
                                            //     onTap: () {
                                            //       const PackageScreen().launch(context);
                                            //     },
                                            //     child: Image(
                                            //       image: NetworkImage(
                                            //         "${APIConfig.domain}${images[index].imageUrl}",
                                            //       ),
                                            //       fit: BoxFit.cover,
                                            //     ),
                                            //   );
                                            // } else {
                                            //   YoutubePlayerController videoController = YoutubePlayerController(
                                            //     flags: const YoutubePlayerFlags(
                                            //       autoPlay: false,
                                            //       mute: false,
                                            //     ),
                                            //     initialVideoId: images[index].imageUrl,
                                            //   );
                                            //   return YoutubePlayer(
                                            //     controller: videoController,
                                            //     showVideoProgressIndicator: true,
                                            //     onReady: () {},
                                            //   );
                                            // }
                                          },
                                        ),
                                      ),
                                      GestureDetector(
                                        child: const Icon(Icons.keyboard_arrow_right),
                                        onTap: () {
                                          pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.linear);
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            );
                          } else {
                            return Center(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: 150,
                                width: 320,
                                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('images/banner1.png'))),
                              ),
                            );
                          }
                        }, error: (e, stack) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 150,
                              width: 320,
                              color: Colors.grey.shade200,
                              child: Center(
                                child: Text(
                                  lang.S.of(context).noDataFound,
                                  //'No Data Found'
                                ),
                              ),
                              // decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('images/banner1.png'))),
                            ),
                          );
                        }, loading: () {
                          return const CircularProgressIndicator();
                        }),

                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Row(
                        //     children: [
                        //       SizedBox(
                        //         width: 10.0,
                        //       ),
                        //       Text(
                        //         'Business',
                        //         style: GoogleFonts.poppins(
                        //           color: Colors.black,
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 20.0,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   padding: EdgeInsets.all(10.0),
                        //   child: GridView.count(
                        //     physics: NeverScrollableScrollPhysics(),
                        //     shrinkWrap: true,
                        //     childAspectRatio: 1,
                        //     crossAxisCount: 4,
                        //     children: List.generate(
                        //       businessIcons.length,
                        //       (index) => HomeGridCards(
                        //         gridItems: businessIcons[index],
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Row(
                        //     children: [
                        //       SizedBox(
                        //         width: 10.0,
                        //       ),
                        //       Text(
                        //         'Enterprise',
                        //         style: GoogleFonts.poppins(
                        //           color: Colors.black,
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 20.0,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   padding: EdgeInsets.all(10.0),
                        //   child: GridView.count(
                        //     physics: NeverScrollableScrollPhysics(),
                        //     shrinkWrap: true,
                        //     childAspectRatio: 1,
                        //     crossAxisCount: 4,
                        //     children: List.generate(
                        //       enterpriseIcons.length,
                        //       (index) => HomeGridCards(
                        //         gridItems: enterpriseIcons[index],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }, error: (e, stack) {
          return Text(e.toString());
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        });
      }),
    );
  }
}

class HomeGridCards extends StatefulWidget {
  const HomeGridCards({
    Key? key,
    required this.gridItems,
    required this.color,
    this.visibility,
  }) : super(key: key);
  final GridItems gridItems;
  final Color color;
  final business.Visibility? visibility;

  @override
  State<HomeGridCards> createState() => _HomeGridCardsState();
}

class _HomeGridCardsState extends State<HomeGridCards> {
  bool checkPermission({required String item}) {
    if (item == 'Sales' && (widget.visibility?.salePermission ?? true)) {
      return true;
    } else if (item == 'Parties' && (widget.visibility?.partiesPermission ?? true)) {
      return true;
    } else if (item == 'Purchase' && (widget.visibility?.purchasePermission ?? true)) {
      return true;
    } else if (item == 'Products' && (widget.visibility?.productPermission ?? true)) {
      return true;
    } else if (item == 'Due List' && (widget.visibility?.dueListPermission ?? true)) {
      return true;
    } else if (item == 'Stock' && (widget.visibility?.stockPermission ?? true)) {
      return true;
    } else if (item == 'Reports' && (widget.visibility?.reportsPermission ?? true)) {
      return true;
    } else if (item == 'Sales List' && (widget.visibility?.salesListPermission ?? true)) {
      return true;
    } else if (item == 'Purchase List' && (widget.visibility?.purchaseListPermission ?? true)) {
      return true;
    } else if (item == 'Loss/Profit' && (widget.visibility?.lossProfitPermission ?? true)) {
      return true;
    } else if (item == 'Expense' && (widget.visibility?.addExpensePermission ?? true)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Consumer(builder: (context, ref, __) {
      return GestureDetector(
        onTap: () async {
          if (checkPermission(item: widget.gridItems.route)) {
            Navigator.of(context).pushNamed('/${widget.gridItems.route}');
          } else {
            EasyLoading.showError(
              lang.S.of(context).permissionNotGranted,
              // 'Permission not granted!'
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: kWhite,
              boxShadow: [BoxShadow(color: const Color(0xff171717).withOpacity(0.07), offset: const Offset(0, 3), blurRadius: 50, spreadRadius: -4)]),
          child: Row(
            children: [
              SvgPicture.asset(
                widget.gridItems.icon.toString(),
                height: 40,
                width: 40,
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                  child: Text(
                widget.gridItems.title.toString(),
                style: gTextStyle.copyWith(fontSize: 16, color: const Color(0xff4D4D4D)),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ))
            ],
          ),
        ),
      );
    });
  }
}
