import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mobile_pos/Provider/product_provider.dart';
import 'package:mobile_pos/Screens/Home/components/grid_items.dart';
import 'package:mobile_pos/Screens/Products/Providers/category,brans,units_provide.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;
import '../../Const/api_config.dart';
import '../../Provider/add_to_cart.dart';
import '../../Provider/profile_provider.dart';
import '../../constant.dart';
import '../../model/add_to_cart_model.dart';
import '../../model/business_info_model.dart' as business;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DrawerManuTile> drawerMenuList = [
    DrawerManuTile(title: 'Home', image: 'assets/grocery/home.svg', route: 'Home'),
    DrawerManuTile(title: 'Sales List', image: 'assets/grocery/sales_list.svg', route: 'Sales List'),
    DrawerManuTile(title: 'Parties', image: 'assets/grocery/parties.svg', route: 'Parties'),
    DrawerManuTile(title: 'Items', image: 'assets/grocery/items.svg', route: 'Products'),
    DrawerManuTile(title: 'Purchase', image: 'assets/grocery/purchase.svg', route: 'Purchase'),
    DrawerManuTile(title: 'Purchase List', image: 'assets/grocery/sales_list.svg', route: 'Purchase List'), // Assuming you intended to use 'sales_list.svg' here
    DrawerManuTile(title: 'Due List', image: 'assets/grocery/due_list.svg', route: 'Due List'),
    DrawerManuTile(title: 'Loss/Profit', image: 'assets/grocery/loss_profit.svg', route: 'Loss/Profit'),
    DrawerManuTile(title: 'Stocks', image: 'assets/grocery/stock.svg', route: "Stock"),
    // DrawerManuTile(title: 'Ledger', image: 'assets/grocery/ledger.svg',route: ''),
    DrawerManuTile(title: 'Expense', image: 'assets/grocery/expense.svg', route: 'Expense'),
    DrawerManuTile(title: 'Reports', image: 'assets/grocery/reports.svg', route: 'Reports'),
  ];
  bool checkPermission({required String item, required business.Visibility? visibility}) {
    if (item == 'Sales' && (visibility?.salePermission ?? true)) {
      return true;
    } else if (item == 'Parties' && (visibility?.partiesPermission ?? true)) {
      return true;
    } else if (item == 'Purchase' && (visibility?.purchasePermission ?? true)) {
      return true;
    } else if (item == 'Products' && (visibility?.productPermission ?? true)) {
      return true;
    } else if (item == 'Due List' && (visibility?.dueListPermission ?? true)) {
      return true;
    } else if (item == 'Stock' && (visibility?.stockPermission ?? true)) {
      return true;
    } else if (item == 'Reports' && (visibility?.reportsPermission ?? true)) {
      return true;
    } else if (item == 'Sales List' && (visibility?.salesListPermission ?? true)) {
      return true;
    } else if (item == 'Purchase List' && (visibility?.purchaseListPermission ?? true)) {
      return true;
    } else if (item == 'Loss/Profit' && (visibility?.lossProfitPermission ?? true)) {
      return true;
    } else if (item == 'Expense' && (visibility?.addExpensePermission ?? true)) {
      return true;
    }
    return false;
  }

  TextEditingController productSearchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productSearchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    freeIcons = getFreeIcons(context: context);
    return SafeArea(
      child: Consumer(builder: (_, ref, __) {
        final businessInfo = ref.watch(businessInfoProvider);
        final category = ref.watch(categoryProvider);
        final product = ref.watch(productProvider);
        final cartData = ref.watch(cartNotifier);
        return businessInfo.when(data: (details) {
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: kBackgroundColor,

            ///______Drawer__________________________
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: List.generate(
                  drawerMenuList.length,
                  (index) {
                    return ListTile(
                      onTap: () {
                        if (checkPermission(item: drawerMenuList[index].route, visibility: details.user?.visibility)) {
                          Navigator.of(context).pushNamed('/${drawerMenuList[index].route}');
                        } else {
                          EasyLoading.showError(
                            lang.S.of(context).permissionNotGranted,
                            // 'Permission not granted!'
                          );
                        }
                      },
                      leading: SvgPicture.asset(
                        drawerMenuList[index].image,
                        height: 25,
                        width: 25,
                      ),
                      title: Text(drawerMenuList[index].title),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    );
                  },
                ),
                // children: <Widget>[

                // ],
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
                          Visibility(

                            visible: cartData.cartItemList.isNotEmpty,

                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
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
                                              child: Center(
                                                  child: Text(
                                                '${cartData.cartItemList.length}',
                                                style: const TextStyle(fontSize: 20, color: Colors.black),
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
                            ),
                          ),

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
                      data: (products) {
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
                            itemCount: products.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    if ((products[index].productStock ?? 0) <= 0) {
                                      EasyLoading.showError('Out of stock');
                                    } else {
                                      // if (widget.customerModel == null) {
                                      //   sentProductPrice = products[i].productSalePrice.toString();
                                      // } else {
                                      //   if (widget.customerModel!.type!.contains('Retailer')) {
                                      //     sentProductPrice = products[i].productSalePrice.toString();
                                      //   } else if (widget.customerModel!.type!.contains('Dealer')) {
                                      //     sentProductPrice = products[i].productDealerPrice.toString();
                                      //   } else if (widget.customerModel!.type!.contains('Wholesaler')) {
                                      //     sentProductPrice = products[i].productWholeSalePrice.toString();
                                      //   } else if (widget.customerModel!.type!.contains('Supplier')) {
                                      //     sentProductPrice = products[i].productPurchasePrice.toString();
                                      //   }
                                      // }

                                      AddToCartModel cartItem = AddToCartModel(
                                        productName: products[index].productName,
                                        subTotal: products[index].productSalePrice,
                                        productId: products[index].productCode,
                                        productBrandName: products[index].brand?.brandName ?? '',
                                        productPurchasePrice: products[index].productPurchasePrice,
                                        stock: (products[index].productStock ?? 0).round(),
                                        uuid: products[index].id ?? 0,
                                      );
                                      cartData.addToCartRiverPod(cartItem);
                                      cartData.addProductsInSales(products[index]);
                                      // Navigator.pop(context);
                                    }
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: products[index].productPicture == null
                                            ? Image.asset(
                                                noProductImageUrl,
                                                fit: BoxFit.fill,
                                              )
                                            : Image.network(
                                                '${APIConfig.domain}${products[index].productPicture!}',
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        products[index].productName ?? '',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text("${products[index].productStock} ${products[index].unit?.unitName ?? ''}"),
                                      const SizedBox(height: 4.0),
                                      Text('\$${products[index].productSalePrice?.toStringAsFixed(2)}'),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      error: (error, stackTrace) => const Text('Could not fetch products'),
                      loading: () => const CircularProgressIndicator(),
                    ),
                  ),

                  const SizedBox(height: 50,),
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

class DrawerManuTile {
  late String title;
  late String image;
  late String route;
  DrawerManuTile({required this.title, required this.image, required this.route});
}
