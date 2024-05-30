import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_pos/Screens/Products/Model/product_model.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;
import 'package:nb_utils/nb_utils.dart';

import '../../Provider/product_provider.dart';
import '../../constant.dart';
import '../../currency.dart';

class StockList extends StatefulWidget {
  const StockList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  String productSearch = '';
  @override
  Widget build(BuildContext context) {
    num totalStock = 0;
    double totalSalePrice = 0;
    double totalParPrice = 0;
    return Consumer(builder: (context, ref, __) {
      final providerData = ref.watch(productProvider);
      return providerData.when(data: (product) {
        List<ProductModel> showableProducts = [];
        for (var element in product) {
          if (element.productName!.toLowerCase().contains(productSearch.toLowerCase().trim())) {
            showableProducts.add(element);
            totalStock += (element.productStock ?? 0);
            totalSalePrice += (element.productSalePrice ?? 0) * (element.productStock ?? 0);
            totalParPrice += (element.productPurchasePrice ?? 0) * (element.productStock ?? 0);
          }
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              lang.S.of(context).stockList,
              style: GoogleFonts.poppins(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.w500),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: product.isNotEmpty
                  ? Column(
                      children: [
                        AppTextField(
                          textFieldType: TextFieldType.NAME,
                          onChanged: (value) {
                            setState(() {
                              productSearch = value;
                            });
                          },
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Search',
                            hintText: 'Enter product name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
                          color: kMainColor.withOpacity(0.2),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  lang.S.of(context).product,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'Qty',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  'Cost',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  lang.S.of(context).sale,
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                            itemCount: showableProducts.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          showableProducts[index].productName.toString(),
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.poppins(
                                            color: (showableProducts[index].productStock ?? 0) < 20 ? Colors.red : Colors.black,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        Text(
                                          showableProducts[index].brand?.brandName ?? '',
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.poppins(
                                            color: (showableProducts[index].productStock ?? 0) < 20 ? Colors.red : kGreyTextColor,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      showableProducts[index].productStock.toString(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        color: (showableProducts[index].productStock ?? 0) < 20 ? Colors.red : Colors.black,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        '${showableProducts[index].productPurchasePrice}',
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.poppins(
                                          color: (showableProducts[index].productStock ?? 0) < 20 ? Colors.red : Colors.black,
                                        ),
                                      )),
                                  Expanded(
                                    child: Text(
                                      '${showableProducts[index].productSalePrice}',
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.poppins(
                                        color: (showableProducts[index].productStock ?? 0) < 20 ? Colors.red : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ],
                    )
                  : const Center(child: Text('No Product Found')),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(10),
            color: kMainColor.withOpacity(0.2),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total Qty',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '$totalStock',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Total Cost',
                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '$currency${totalParPrice.toInt().toString()}',
                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                )),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total Sale',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '$currency${totalSalePrice.toInt().toString()}',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w500),
                      ),
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
    });
  }
}
