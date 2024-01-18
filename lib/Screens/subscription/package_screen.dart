import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_pos/Provider/profile_provider.dart';
import 'package:mobile_pos/Screens/subscription/purchase_premium_plan_screen.dart';
import 'package:mobile_pos/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;

class PackageScreen extends StatefulWidget {
  const PackageScreen({Key? key}) : super(key: key);

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  Duration? remainTime;
  List<String>? initialPackageService;
  List<int>? mainPackageService;
  List<String> nameList = ['Sales', 'Purchase', 'Due collection', 'Parties', 'Products'];
  List<String> imageList = [
    'images/sales_2.png',
    'images/purchase_2.png',
    'images/due_collection_2.png',
    'images/parties_2.png',
    'images/product1.png',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, __) {
      final profileInfo = ref.watch(businessInfoProvider);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            lang.S.of(context).yourPack,
            style: GoogleFonts.poppins(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0.0,
        ),
        body: profileInfo.when(
          data: (info) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(color: kPremiumPlanColor.withOpacity(0.2), borderRadius: const BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (info.enrolledPlan?.price ?? 0) > 0 ? lang.S.of(context).premiumPlan : lang.S.of(context).freePlan,
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    lang.S.of(context).youRUsing,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    '${info.enrolledPlan?.plan?.subscriptionName} Package',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: kMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            height: 63,
                            width: 63,
                            decoration: const BoxDecoration(
                              color: kMainColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: Center(
                                child: Text(
                              '${(DateTime.parse(info.subscriptionDate ?? '').difference(DateTime.now()).inDays.abs() - (info.enrolledPlan?.duration ?? 0)).abs()} \nDays Left',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12, color: Colors.white),
                            )),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                    // Container(
                    //   height: 80,
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(color: kPremiumPlanColor.withOpacity(0.2), borderRadius: const BorderRadius.all(Radius.circular(10))),
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       const SizedBox(width: 20),
                    //       Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             lang.S.of(context).premiumPlan,
                    //             style: const TextStyle(fontSize: 18),
                    //           ),
                    //           const SizedBox(height: 8),
                    //           Row(
                    //             children: [
                    //               Text(
                    //                 lang.S.of(context).youRUsing,
                    //                 style: const TextStyle(fontSize: 14),
                    //               ),
                    //               Text(
                    //                 '${info.enrolledPlan?.plan?.subscriptionName} Package',
                    //                 style: const TextStyle(fontSize: 14, color: kMainColor, fontWeight: FontWeight.bold),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //       const Spacer(),
                    //       Container(
                    //         height: 63,
                    //         width: 63,
                    //         decoration: const BoxDecoration(
                    //           color: kMainColor,
                    //           borderRadius: BorderRadius.all(
                    //             Radius.circular(50),
                    //           ),
                    //         ),
                    //         child: Center(
                    //             child: Text(
                    //           '${(DateTime.parse(info.subscriptionDate).difference(DateTime.now()).inDays.abs() - (info.enrolledPlan?.duration ?? 0)).abs()} \nDays Left',
                    //           textAlign: TextAlign.center,
                    //           style: const TextStyle(fontSize: 12, color: Colors.white),
                    //         )),
                    //       ),
                    //       // .visible(info.duration != -202),
                    //       const SizedBox(width: 20),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    Text(
                      lang.S.of(context).packFeatures,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                        itemCount: nameList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, i) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: GestureDetector(
                              onTap: () {},
                              child: Card(
                                elevation: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ListTile(
                                    leading: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Image(
                                        image: AssetImage(imageList[i]),
                                      ),
                                    ),
                                    title: Text(
                                      nameList[i],
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    trailing: Text(
                                      lang.S.of(context).unlimited,
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    const SizedBox(height: 20),
                    // const Text(
                    //   'For Unlimited Usages',
                    //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    // ).visible(initialSelectedPackage != 'Lifetime'),
                    // const SizedBox(height: 20).visible(initialSelectedPackage != 'Lifetime'),
                    Visibility(
                      visible: info.user?.role !='staff',
                      child: GestureDetector(
                        onTap: () {
                          const PurchasePremiumPlanScreen(
                            isCameBack: true,
                          ).launch(context);
                        },
                        child: Container(
                          height: 60,
                          decoration: const BoxDecoration(
                            color: kMainColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                            child: Text(
                              lang.S.of(context).updateNow,
                              style: const TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return Text(error.toString());
          },
          loading: () {
            return const CircularProgressIndicator();
          },
        ),
      );
    });
  }
}
