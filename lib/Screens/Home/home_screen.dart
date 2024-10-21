import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mobile_pos/Provider/product_provider.dart';
import 'package:mobile_pos/Screens/Products/Model/product_model.dart';
import 'package:mobile_pos/Screens/Products/Providers/category,brans,units_provide.dart';
import 'package:mobile_pos/Screens/Sales/add_sales.dart';
import 'package:mobile_pos/currency.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;
import 'package:nb_utils/nb_utils.dart';
import '../../Const/api_config.dart';
import '../../Provider/add_to_cart.dart';
import '../../Provider/profile_provider.dart';
import '../../constant.dart';
import '../../model/add_to_cart_model.dart';
import '../../model/business_info_model.dart' as business;
import '../../GlobalComponents/no_data_found.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DrawerManuTile> get drawerMenuList => [
    DrawerManuTile(title: lang.S.current.home, image: 'assets/grocery/home.svg', route: 'Home'),
    DrawerManuTile(title: lang.S.current.salesList, image: 'assets/grocery/sales_list.svg', route: 'Sales List'),
    DrawerManuTile(title: lang.S.current.parties, image: 'assets/grocery/parties.svg', route: 'Parties'),
    DrawerManuTile(title: lang.S.current.items, image: 'assets/grocery/items.svg', route: 'Products'),
    DrawerManuTile(title: lang.S.current.purchase, image: 'assets/grocery/purchase.svg', route: 'Purchase'),
    DrawerManuTile(title: lang.S.current.purchaseList, image: 'assets/grocery/sales_list.svg', route: 'Purchase List'), // Assuming you intended to use 'sales_list.svg' here
    DrawerManuTile(title: lang.S.current.dueList, image: 'assets/grocery/due_list.svg', route: 'Due List'),
    DrawerManuTile(title: lang.S.current.lossProfit, image: 'assets/grocery/loss_profit.svg', route: 'Loss/Profit'),
    DrawerManuTile(title: lang.S.current.stock, image: 'assets/grocery/stock.svg', route: "Stock"),
    DrawerManuTile(title: lang.S.current.income, image: 'assets/incomeReport.svg', route: 'Income'),
    DrawerManuTile(title: lang.S.current.expense, image: 'assets/grocery/expense.svg', route: 'Expense'),
    DrawerManuTile(title: lang.S.current.reports, image: 'assets/grocery/reports.svg', route: 'Reports'),
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
    } else if (item == 'Income' && (visibility?.addIncomePermission ?? true)) {
      return true;
    } else if (item == 'Expense' && (visibility?.addExpensePermission ?? true)) {
      return true;
    }
    return false;
  }

  num? selectedCategoryId;

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
    return SafeArea(
      child: Consumer(builder: (_, ref, __) {
        final businessInfo = ref.watch(businessInfoProvider);
        final category = ref.watch(categoryProvider);
        final product = ref.watch(productProvider(selectedCategoryId));
        final cartData = ref.watch(cartNotifier);
        return businessInfo.when(data: (details) {
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: kBackgroundColor,

            ///______Drawer__________________________
            drawer: Drawer(
              child: Column(
                children: [
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: kGreyTextColor.withOpacity(0.2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/logo.png',
                                height: 35,
                                width: 35,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                appsName,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              _scaffoldKey.currentState?.closeDrawer();
                            },
                            icon: const Icon(Icons.close))
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - (220),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: List.generate(
                          drawerMenuList.length,
                          (index) {
                            return ListTile(
                              onTap: () {
                                if (drawerMenuList[index].route == 'Home') {
                                  _scaffoldKey.currentState?.closeDrawer();
                                  return;
                                }
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
                  ),
                ],
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
                            "${details.enrolledPlan?.plan?.subscriptionName ?? ''} ${lang.S.of(context).plan}",
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
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddSalesScreen(customerModel: null),
                                      ));
                                },
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
                                                  decoration:
                                                      BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(8)), border: Border.all(color: Colors.white, width: 2)),
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
                                        Text(
                                          '$currency ${cartData.getTotalAmount()}',
                                          style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
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
                          ),

                          ///______category_______________________________
                           Text(
                             lang.S.of(context).categories,
                            //'Categories',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            child: category.when(
                              data: (data) {
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          ref.refresh(productProvider(selectedCategoryId));
                                          selectedCategoryId = null;
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: kMainColor,
                                              border: selectedCategoryId == null ? Border.all(color: kMainColor, width: 2) : null,
                                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                                              image: DecorationImage(fit: BoxFit.cover, image: AssetImage(noProductImageUrl)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 70,
                                            child: Center(
                                              child: Text(
                                                lang.S.of(context).all,
                                               // "All",
                                                style: TextStyle(
                                                  color: selectedCategoryId == null ? kMainColor : null,
                                                  fontWeight: selectedCategoryId == null ? FontWeight.bold : null,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ListView.builder(
                                      itemCount: data.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                ref.refresh(productProvider(selectedCategoryId));
                                                selectedCategoryId = data[index].id;
                                              });
                                            },
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                data[index].icon != null
                                                    ? Container(
                                                        height: 50,
                                                        width: 50,
                                                        decoration: BoxDecoration(
                                                            border: selectedCategoryId == data[index].id ? Border.all(color: kMainColor, width: 2) : null,
                                                            color: kMainColor,
                                                            borderRadius: const BorderRadius.all(Radius.circular(50)),
                                                            image: DecorationImage(image: NetworkImage('${APIConfig.domain}${data[index].icon}'), fit: BoxFit.cover)),
                                                      )
                                                    : Container(
                                                        height: 50,
                                                        width: 50,
                                                        decoration: BoxDecoration(
                                                          border: selectedCategoryId == data[index].id ? Border.all(color: kMainColor, width: 2) : null,
                                                          color: kMainColor,
                                                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                                                          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(noProductImageUrl)),
                                                        ),
                                                      ),
                                                SizedBox(
                                                  width: 70,
                                                  child: Center(
                                                    child: Text(
                                                      data[index].categoryName.toString(),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: selectedCategoryId == data[index].id ? kMainColor : null,
                                                        fontWeight: selectedCategoryId == data[index].id ? FontWeight.bold : null,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                              //error: (error, stackTrace) => const Text('Could not fetch the categories'),
                              error: (error, stackTrace) =>  Text(lang.S.of(context).couldNotFetchTheCategories),
                              loading: () => const CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///________Search_____________________________________
                  product.when(
                    data: (products) {
                      List<ProductModel> productsList =
                      products.where((element) => element.productName!.toLowerCase().contains(productSearchController.text.toLowerCase())).toList();
                      return Column(
                        children: [
                          ///________Search___________________________________
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: productSearchController,
                              decoration:  InputDecoration(border: const OutlineInputBorder(), hintText: '${lang.S.of(context).searchHere}....', suffixIcon: const Icon(IconlyLight.search)),
                              onChanged: (value) {
                                setState(() {

                                });
                              },
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
                                      TextSpan(text: '${productsList.length} ${lang.S.of(context).all}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                                      TextSpan(
                                         // text: ' items For',
                                          text: lang.S.of(context).itemsFor,
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
                          productsList.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: GridView.builder(
                                      // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 3,childAspectRatio: 2,crossAxisSpacing: 0.4,mainAxisExtent: 20,mainAxisSpacing: 30),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.7),
                                      itemCount: productsList.length,
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                AddToCartModel cartItem = AddToCartModel(
                                                  productName: productsList[index].productName,
                                                  price: productsList[index].productSalePrice,
                                                  productId: productsList[index].productCode,
                                                  productBrandName: productsList[index].brand?.brandName,
                                                  productPurchasePrice: productsList[index].productPurchasePrice,
                                                  stock: (productsList[index].productStock ?? 0),
                                                  uuid: productsList[index].id ?? 0,
                                                  unitName: productsList[index].unit?.unitName,
                                                  imageUrl: productsList[index].productPicture,
                                                );
                                                showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.vertical(
                                                      top: Radius.circular(20),
                                                    ),
                                                  ),
                                                  builder: (context) => ItemDetailsModal(
                                                    product: cartItem,
                                                    ref: ref,
                                                  ),
                                                );
                                              },
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  productsList[index].productPicture == null
                                                      ? SizedBox(
                                                          height: 80,
                                                          width: 500,
                                                          child: Image.asset(
                                                            noProductImageUrl,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          height: 80,
                                                          width: 500,
                                                          child: Image.network(
                                                            '${APIConfig.domain}${productsList[index].productPicture!}',
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                  const SizedBox(height: 5.0),
                                                  Text(
                                                    productsList[index].productName ?? '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                  // const SizedBox(height: 2.0),
                                                  Text("${productsList[index].productStock} ${productsList[index].unit?.unitName ?? ''}"),
                                                  // const SizedBox(height: 2.0),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('\$${productsList[index].productSalePrice?.toStringAsFixed(2)}'),
                                                      Visibility(
                                                        visible: cartData.getAProductQuantity(uid: productsList[index].id ?? 0) != null,
                                                        child: CircleAvatar(
                                                          backgroundColor: kMainColor,
                                                          minRadius: 5,
                                                          child: SizedBox(
                                                              height: 24,
                                                              width: 24,
                                                              child: Center(
                                                                  child: Text(
                                                                '${cartData.getAProductQuantity(uid: productsList[index].id ?? 0)}',
                                                                style: const TextStyle(fontSize: 12, color: Colors.white),
                                                              ))),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              :  EmptyListWidget(
                                  //title: 'No Product Found',
                                  title: lang.S.of(context).noProductFound,
                                ),
                        ],
                      );
                    },
                    //error: (error, stackTrace) => const Text('Could not fetch products'),
                    error: (error, stackTrace) =>  Text(lang.S.of(context).couldNotFetchTheCategories),
                    loading: () => const CircularProgressIndicator(),
                  ),

                  const SizedBox(height: 50),
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

class ItemDetailsModal extends StatefulWidget {
  ItemDetailsModal({Key? key, required this.product, required this.ref}) : super(key: key);

  AddToCartModel product;
  final WidgetRef ref;

  @override
  State<ItemDetailsModal> createState() => _ItemDetailsModalState();
}

class _ItemDetailsModalState extends State<ItemDetailsModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  bool isAlreadyInCart = false;

  @override
  void initState() {
    super.initState();
    for (var element in widget.ref.watch(cartNotifier).cartItemList) {
      if (element.uuid == widget.product.uuid) {
        setState(() {
          widget.product = element;
          isAlreadyInCart = true;
        });
      }
    }
    quantityController.text = '${widget.product.quantity}';
    priceController.text = '${widget.product.price}';
  }

  @override
  void dispose() {
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 15,
        right: 15,
        top: 10,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Item Details Header______________________________
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                   lang.S.of(context).itemDetails,
                  //'Item Details',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.clear),
                  ),
                ),
              ],
            ),
            const Divider(),

            ///_________ Item Name and Price_________________________
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.productName ?? '',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                 //Text('Unit price'),
                 Text(lang.S.of(context).unitPirce),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${widget.product.stock} ${widget.product.unitName ?? ''}'),
                Text(
                  '$currency ${widget.product.price}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Unit Input Field
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: quantityController,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                    decoration: InputDecoration(
                      //labelText: 'Quantity',
                      labelText: lang.S.of(context).quantity,
                      //hintText: 'Enter unit quantity',
                      hintText: lang.S.of(context).enterUnitQuantity,
                      border: const OutlineInputBorder(),
                      suffixIcon: (widget.product.unitName.isEmptyOrNull)
                          ? null
                          : Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(color: kBorderColorTextField.withOpacity(.5), borderRadius: const BorderRadius.all(Radius.circular(5))),
                                child: Center(child: Text(widget.product.unitName ?? '')),
                              ),
                            ),
                      suffixIconColor: Colors.red,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      final quantity = num.tryParse(value ?? '') ?? 0;
                      if (quantity <= 0) {
                        //return 'Quantity must be greater than 0';
                        return '${lang.S.of(context).quantityMustBeGreaterThan} 0';
                      }
                      if (quantity > (widget.product.stock ?? 0)) {
                       // return 'Quantity exceeds available stock';
                        return lang.S.of(context).quantityExceedsAvailableStock;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Price Input Field
            TextFormField(
              controller: priceController,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
              decoration:  InputDecoration(
                //labelText: 'Sales Price',
                labelText: lang.S.of(context).salesPrice,
                //hintText: 'Please enter sales price',
                hintText: lang.S.of(context).pleaseEnterSalesPrice,
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                final price = num.tryParse(value ?? '') ?? 0;
                if (price <= 0) {
                 // return 'Price must be greater than 0';
                  return '${lang.S.of(context).priceMustBeGreaterThan} 0';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            // Add to Cart Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kMainColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  '${lang.S.of(context).addToCart} - ${lang.S.of(context).total}: $currency ${(num.tryParse(quantityController.text) ?? 1) * (num.tryParse(priceController.text) ?? 0)}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final quantity = num.tryParse(quantityController.text) ?? 1;
                    final price = num.tryParse(priceController.text) ?? 0;

                    widget.product.quantity = quantity;
                    widget.product.price = price;

                    isAlreadyInCart ? widget.ref.watch(cartNotifier).updateProductInCart(widget.product) : widget.ref.watch(cartNotifier).addToCart(widget.product);

                    Navigator.pop(context);
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
