// ignore_for_file: unused_result, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_pos/GlobalComponents/button_global.dart';
import 'package:mobile_pos/Screens/Products/Model/brands_model.dart' as brand;
import 'package:mobile_pos/Screens/Products/Model/unit_model.dart' as unit;
import 'package:mobile_pos/Screens/Products/Repo/product_repo.dart';
import 'package:mobile_pos/Screens/Products/brands_list.dart';
import 'package:mobile_pos/Screens/Products/category_list_screen.dart';
import 'package:mobile_pos/Screens/Products/unit_list.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';
import '../Home/home.dart';
import 'Model/category_model.dart';

// ignore: must_be_immutable
class AddProduct extends StatefulWidget {
  const AddProduct({
    Key? key,
    required this.fromHome,
  }) : super(key: key);

  final bool fromHome;

  @override
  // ignore: library_private_types_in_public_api
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryModel? selectedCategory;
  brand.Brand? selectedBrand;
  unit.Unit? selectedUnit;
  late String productName, productStock, productSalePrice, productPurchasePrice, productCode;

  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController productUnitController = TextEditingController();
  TextEditingController productStockController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();
  TextEditingController purchasePriceController = TextEditingController();
  TextEditingController productCodeController = TextEditingController();
  TextEditingController wholeSalePriceController = TextEditingController();
  TextEditingController dealerPriceController = TextEditingController();
  TextEditingController manufacturerController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController capacityController = TextEditingController();

  @override
  void dispose() {
    // Dispose of each controller to release resources
    nameController.dispose();
    categoryController.dispose();
    brandController.dispose();
    productUnitController.dispose();
    productStockController.dispose();
    salePriceController.dispose();
    discountPriceController.dispose();
    purchasePriceController.dispose();
    productCodeController.dispose();
    wholeSalePriceController.dispose();
    dealerPriceController.dispose();
    manufacturerController.dispose();
    sizeController.dispose();
    colorController.dispose();
    weightController.dispose();
    typeController.dispose();
    capacityController.dispose();

    super.dispose();
  }

  final ImagePicker _picker = ImagePicker();
  XFile? pickedImage;
  List<String> codeList = [];
  String promoCodeHint = 'Enter Product Code';
  GlobalKey<FormState> key = GlobalKey();
  GetCategoryAndVariationModel data = GetCategoryAndVariationModel(variations: [], categoryName: CategoryModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        surfaceTintColor: kWhite,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          lang.S.of(context).addNewProduct,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer(builder: (context, ref, __) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Form(
              key: key,
              child: Column(
                children: [
                  ///___________Name_____________________________
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          // return 'Please enter a valid product Name';
                          return lang.S.of(context).pleaseEnterAValidProductName;
                        }
                        // You can add more validation logic as needed
                        return null;
                      },
                      decoration: kInputDecoration.copyWith(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: lang.S.of(context).productName,
                        //hintText: 'Enter product Name',
                        hintText: lang.S.of(context).enterProductName,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),

                  ///_______Category__________________________________
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      readOnly: true,
                      controller: categoryController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          //return 'Please select a category';
                          return lang.S.of(context).pleaseSelectACategory;
                        }
                        return null;
                      },
                      onTap: () async {
                        data = await const CategoryList(
                          isFromProductList: false,
                        ).launch(context);
                        setState(() {
                          categoryController.text = data.categoryName.categoryName ?? '';
                          selectedCategory = data.categoryName;
                        });
                      },
                      decoration: kInputDecoration.copyWith(
                        suffixIcon: const Icon(Icons.keyboard_arrow_down),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        //labelText: 'Product Category',
                        labelText: lang.S.of(context).productCategory,
                        //hintText: 'Select Product Category',
                        hintText: lang.S.of(context).selectProductCategory,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),

                  ///________Size__Color_________________________
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            validator: (value) => null,
                            controller: sizeController,
                            decoration: kInputDecoration.copyWith(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: lang.S.of(context).size,
                              //hintText: 'Enter Size',
                              hintText: lang.S.of(context).enterSize,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ).visible(data.variations.contains(lang.S.of(context).size)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: colorController,
                            decoration: kInputDecoration.copyWith(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: lang.S.of(context).color,
                              //hintText: 'Enter color',
                              hintText: lang.S.of(context).enterColor,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ).visible(data.variations.contains(lang.S.of(context).color)),
                    ],
                  ),

                  ///________Capacity_and_weight_____________________________
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: weightController,
                            decoration: kInputDecoration.copyWith(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: lang.S.of(context).weight,
                              //hintText: 'Enter weight',
                              hintText: lang.S.of(context).enterWeight,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ).visible(data.variations.contains(lang.S.of(context).weight)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: capacityController,
                            decoration: kInputDecoration.copyWith(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: lang.S.of(context).capacity,
                              //hintText: 'Enter Capacity',
                              hintText: lang.S.of(context).enterCapacity,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ).visible(data.variations.contains(lang.S.of(context).capacity)),
                    ],
                  ),

                  ///___________Type______________________________________
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: typeController,
                      decoration: kInputDecoration.copyWith(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: lang.S.of(context).type,
                        // hintText: 'Enter Type',
                        hintText: lang.S.of(context).enterType,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ).visible(data.variations.contains(lang.S.of(context).type)),

                  ///_______Brand__________________________________
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      readOnly: true,
                      controller: brandController,
                      validator: (value) {
                        return null;
                      },
                      onTap: () async {
                        selectedBrand = await const BrandsList(
                          isFromProductList: false,
                        ).launch(context);
                        setState(() {
                          brandController.text = selectedBrand?.brandName ?? '';
                        });
                      },
                      decoration: kInputDecoration.copyWith(
                        suffixIcon: const Icon(Icons.keyboard_arrow_down),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        // labelText: 'Product Brand',
                        labelText: lang.S.of(context).productBrand,
                        // hintText: 'Select a brand',
                        hintText: lang.S.of(context).selectABrand,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),

                  ///__________Code__________________________
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: productCodeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                //return 'product code is required';
                                return lang.S.of(context).productCodeIsRequired;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                productCode = value;
                                promoCodeHint = value;
                              });
                            },
                            onFieldSubmitted: (value) {
                              if (codeList.contains(value)) {
                                EasyLoading.showError(
                                  lang.S.of(context).thisProductAlreadyAdded,
                                  // 'This Product Already added!'
                                );
                                productCodeController.clear();
                              } else {
                                setState(() {
                                  productCode = value;
                                  promoCodeHint = value;
                                });
                              }
                            },
                            decoration: kInputDecoration.copyWith(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: lang.S.of(context).productCode,
                              hintText: promoCodeHint,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () async {
                              await showDialog(
                                context: context,
                                useSafeArea: true,
                                builder: (context1) {
                                  MobileScannerController controller = MobileScannerController(
                                    torchEnabled: false,
                                    returnImage: false,
                                  );
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadiusDirectional.circular(6.0),
                                    ),
                                    child: Column(
                                      children: [
                                        AppBar(
                                          backgroundColor: Colors.transparent,
                                          iconTheme: const IconThemeData(color: Colors.white),
                                          leading: IconButton(
                                            icon: const Icon(Icons.arrow_back),
                                            onPressed: () {
                                              Navigator.pop(context1);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: MobileScanner(
                                            fit: BoxFit.contain,
                                            controller: controller,
                                            onDetect: (capture) {
                                              final List<Barcode> barcodes = capture.barcodes;

                                              if (barcodes.isNotEmpty) {
                                                final Barcode barcode = barcodes.first;
                                                debugPrint('Barcode found! ${barcode.rawValue}');
                                                // productCode = barcode.rawValue!;
                                                productCodeController.text = barcode.rawValue!;
                                                // globalKey.currentState!.save();
                                                Navigator.pop(context1);
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: 60.0,
                              width: 100.0,
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: kGreyTextColor),
                              ),
                              child: const Image(
                                image: AssetImage('images/barcode.png'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///_____________Stock__&_Unit__________________________
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: productStockController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                //return 'Enter a valid stock';
                                return lang.S.of(context).enterAValidStock;
                              }
                              return null;
                            },
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                            keyboardType: TextInputType.number,
                            decoration: kInputDecoration.copyWith(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: lang.S.of(context).stock,
                              // hintText: 'Enter stock',
                              hintText: lang.S.of(context).enterStock,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            readOnly: true,
                            controller: productUnitController,
                            validator: (value) {
                              return null;
                            },
                            onTap: () async {
                              selectedUnit = await const UnitList(
                                isFromProductList: false,
                              ).launch(context);
                              setState(() {
                                productUnitController.text = selectedUnit?.unitName ?? '';
                              });
                            },
                            decoration: kInputDecoration.copyWith(
                              suffixIcon: const Icon(Icons.keyboard_arrow_down),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              //labelText: 'Product Unit',
                              labelText: lang.S.of(context).productUnit,
                              // hintText: 'Select Product Unit',
                              hintText: lang.S.of(context).selectProductUnit,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///_________Purchase_price__&&______mrp_____________________
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: purchasePriceController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                //return 'Please enter a valid purchase price';
                                return lang.S.of(context).pleaseEnterAValidProductName;
                              }
                              // You can add more validation logic as needed
                              return null;
                            },
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                            keyboardType: TextInputType.number,
                            decoration: kInputDecoration.copyWith(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: lang.S.of(context).purchasePrice,
                              // hintText: 'Enter Purchase price',
                              hintText: lang.S.of(context).enterPurchasePrice,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: salePriceController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                //return 'Please enter a valid Sale price';
                                return lang.S.of(context).pleaseEnterAValidSalePrice;
                              }
                              // You can add more validation logic as needed
                              return null;
                            },
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                            keyboardType: TextInputType.number,
                            decoration: kInputDecoration.copyWith(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: lang.S.of(context).mrp,
                              //hintText: 'Enter Salting price',
                              hintText: lang.S.of(context).enterSaltingPrice,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///_______-wholesalePrice_dealerprice_________________
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: wholeSalePriceController,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                            keyboardType: TextInputType.number,
                            decoration: kInputDecoration.copyWith(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: lang.S.of(context).wholeSalePrice,
                              //hintText: 'Enter wholesale price',
                              hintText: lang.S.of(context).enterWholesalePrice,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: dealerPriceController,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                            keyboardType: TextInputType.number,
                            decoration: kInputDecoration.copyWith(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: lang.S.of(context).dealerPrice,
                              //hintText: 'Enter dealer price',
                              hintText: lang.S.of(context).enterDealerPrice,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: discountPriceController,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                          keyboardType: TextInputType.number,
                          decoration: kInputDecoration.copyWith(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: lang.S.of(context).discount,
                            //hintText: 'Enter discount',
                            hintText: lang.S.of(context).enterDiscount,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      )).visible(false),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: manufacturerController,
                            decoration: kInputDecoration.copyWith(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: lang.S.of(context).manufacturer,
                              //hintText: 'Enter manufacturer name',
                              hintText: lang.S.of(context).enterManufacturerName,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  // ignore: sized_box_for_whitespace
                                  child: Container(
                                    height: 200.0,
                                    width: MediaQuery.of(context).size.width - 80,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              pickedImage = await _picker.pickImage(source: ImageSource.gallery);

                                              setState(() {});

                                              Future.delayed(const Duration(milliseconds: 100), () {
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.photo_library_rounded,
                                                  size: 60.0,
                                                  color: kMainColor,
                                                ),
                                                Text(
                                                  lang.S.of(context).gallery,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 20.0,
                                                    color: kMainColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 40.0),
                                          GestureDetector(
                                            onTap: () async {
                                              pickedImage = await _picker.pickImage(source: ImageSource.camera);
                                              setState(() {});
                                              Future.delayed(const Duration(milliseconds: 100), () {
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.camera,
                                                  size: 60.0,
                                                  color: kGreyTextColor,
                                                ),
                                                Text(
                                                  lang.S.of(context).camera,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 20.0,
                                                    color: kGreyTextColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54, width: 1),
                                borderRadius: const BorderRadius.all(Radius.circular(120)),
                                image: pickedImage == null
                                    ? DecorationImage(
                                        image: AssetImage(noProductImageUrl),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: FileImage(File(pickedImage!.path)),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54, width: 1),
                                borderRadius: const BorderRadius.all(Radius.circular(120)),
                                // image: DecorationImage(
                                //   image: FileImage(File(pickedImage!.path)),
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              // child: imageFile.path == 'No File' ? null : Image.file(imageFile),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white, width: 2),
                                  borderRadius: const BorderRadius.all(Radius.circular(120)),
                                  color: kMainColor,
                                ),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  ButtonGlobalWithoutIcon(
                    buttontext: lang.S.of(context).saveNPublish,
                    buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                    onPressed: () async {
                      if (key.currentState!.validate()) {

                          ProductRepo product = ProductRepo();
                          EasyLoading.show(
                            status: lang.S.of(context).adding,
                            //'Adding..'
                          );
                          await product.addProduct(
                            fromHome: widget.fromHome,
                            ref: ref,
                            context: context,
                            productName: nameController.text,
                            categoryId: selectedCategory!.id.toString(),
                            brandId: selectedBrand?.id.toString(),
                            unitId: selectedUnit?.id.toString(),
                            productCode: productCodeController.text,
                            productStock: productStockController.text,
                            productSalePrice: salePriceController.text,
                            productPurchasePrice: purchasePriceController.text,
                            color: colorController.text.isEmptyOrNull ? null : colorController.text,
                            size: sizeController.text.isEmptyOrNull ? null : sizeController.text,
                            type: typeController.text.isEmptyOrNull ? null : typeController.text,
                            weight: weightController.text.isEmptyOrNull ? null : weightController.text,
                            capacity: capacityController.text.isEmptyOrNull ? null : capacityController.text,
                            productDealerPrice: dealerPriceController.text.isEmptyOrNull ? null : dealerPriceController.text,
                            productDiscount: discountPriceController.text.isEmptyOrNull ? null : discountPriceController.text,
                            productManufacturer: manufacturerController.text.isEmptyOrNull ? null : manufacturerController.text,
                            productWholeSalePrice: wholeSalePriceController.text.isEmptyOrNull ? null : wholeSalePriceController.text,
                            image: pickedImage == null ? null : File(pickedImage!.path),
                          );

                          if (widget.fromHome) {
                            setState(() {
                              nameController.clear();
                              productCodeController.clear();
                              productStockController.clear();
                              salePriceController.clear();
                              purchasePriceController.clear();
                              colorController.clear();
                              sizeController.clear();
                              typeController.clear();
                              weightController.clear();
                              capacityController.clear();
                              dealerPriceController.clear();
                              discountPriceController.clear();
                              manufacturerController.clear();
                              wholeSalePriceController.clear();
                              selectedCategory = null;
                              selectedBrand = null;
                              selectedUnit = null;
                              pickedImage = null;
                            });
                          }
                      }
                    },
                    buttonTextColor: Colors.white,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
