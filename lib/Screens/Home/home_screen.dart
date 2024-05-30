import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_pos/Const/api_config.dart';
import 'package:mobile_pos/Screens/Home/components/grid_items.dart';
import 'package:mobile_pos/Screens/Profile%20Screen/profile_details.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;
import 'package:nb_utils/nb_utils.dart';

import '../../Provider/profile_provider.dart';
import '../../model/business_info_model.dart' as business;
import '../Shimmers/home_screen_appbar_shimmer.dart';
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

  @override
  Widget build(BuildContext context) {
    // print('UserId: $constUserId');
    // print('UserId: ${FirebaseAuth.instance.currentUser!.uid}');
    freeIcons = getFreeIcons(context: context);
    return SafeArea(
      child: Consumer(builder: (_, ref, __) {
        final businessInfo = ref.watch(businessInfoProvider);
        final banner = ref.watch(bannerProvider);

        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: businessInfo.when(data: (details) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              const ProfileDetails().launch(context);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: details.pictureUrl == null
                                  ? BoxDecoration(
                                      image: const DecorationImage(image: AssetImage('images/no_shop_image.png'), fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(50),
                                    )
                                  : BoxDecoration(
                                      image: DecorationImage(image: NetworkImage('${APIConfig.domain}${details.pictureUrl}'), fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                details.user?.role == 'staff'? '${details.companyName ?? ''} [${details.user?.name??''}]' : details.companyName ?? '',
                                style: GoogleFonts.poppins(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "${details.enrolledPlan?.plan?.subscriptionName ?? ''} Plan",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          // Container(
                          //   height: 40.0,
                          //   width: 86.0,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(10.0),
                          //     color: Color(0xFFD9DDE3).withOpacity(0.5),
                          //   ),
                          //   child: Center(
                          //     child: Text(
                          //       '$currency 450',
                          //       style: GoogleFonts.poppins(
                          //         fontSize: 20.0,
                          //         color: Colors.black,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 10.0,
                          // ),
                          // Container(
                          //   height: 40.0,
                          //   width: 40.0,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(10.0),
                          //     color: kDarkWhite,
                          //   ),
                          //   child: Center(
                          //     child: GestureDetector(
                          //       onTap: () {
                          //         EasyLoading.showInfo('Coming Soon');
                          //       },
                          //       child: const Icon(
                          //         Icons.notifications_active,
                          //         color: kMainColor,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  }, error: (e, stack) {
                    return Text(e.toString());
                  }, loading: () {
                    return const HomeScreenAppBarShimmer();
                  }),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    children: List.generate(
                      freeIcons.length,
                      (index) => HomeGridCards(
                        gridItems: freeIcons[index],
                        color: color[index],
                        visibility: businessInfo.value?.user?.visibility,
                      ),
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
                                height: 180,
                                width: 310,
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
                                        fit: BoxFit.fill,
                                      ),
                                    );
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
                        height: 180,
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
                      height: 180,
                      width: 320,
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Text('No Data Found'),
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
        );
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
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: 120,
            child: Card(
              elevation: 2,
              color: widget.color,
              child: Column(
                children: [
                  TextButton(
                    onPressed: () async {
                      if (checkPermission(item: widget.gridItems.route)) {
                        Navigator.of(context).pushNamed('/${widget.gridItems.route}');
                      } else {
                        EasyLoading.showError('Permission not granted!');
                      }
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              widget.gridItems.icon.toString(),
                            ),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.gridItems.title.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
              maxLines: 1,
            ),
          ),
        ],
      );
    });
  }
}
