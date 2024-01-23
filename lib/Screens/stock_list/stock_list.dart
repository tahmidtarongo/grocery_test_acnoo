import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Provider/product_provider.dart';
import '../../constant.dart';
import '../../currency.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;

class StockList extends StatefulWidget {
  const StockList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  @override
  Widget build(BuildContext context) {
    num totalStock = 0;
    double totalSalePrice = 0;
    double totalParPrice = 0;
    return Consumer(builder: (context, ref, __) {
      final providerData = ref.watch(productProvider);
      return providerData.when(data: (product) {
        for (var element in product) {
          totalStock += (element.productStock ?? 0);
          totalSalePrice += (element.productSalePrice ?? 0) * (element.productStock ?? 0);
          totalParPrice += (element.productPurchasePrice ?? 0) * (element.productStock ?? 0);
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
          body: Consumer(builder: (context, ref, __) {
            final providerData = ref.watch(productProvider);
            return providerData.when(data: (product) {
              for (var element in product) {
                totalStock += (element.productStock ?? 0);
                totalSalePrice += (element.productSalePrice ?? 0);
                totalParPrice += (element.productPurchasePrice ?? 0);
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
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
                          // DataTable(
                          //   horizontalMargin: 40.0,
                          //   columnSpacing: 50.0,
                          //   headingRowColor: MaterialStateColor.resolveWith((states) => kMainColor.withOpacity(0.2)),
                          //   columns: const <DataColumn>[
                          //     DataColumn(
                          //       label: Text(
                          //         'Product',
                          //       ),
                          //     ),
                          //     DataColumn(
                          //       label: Text(
                          //         'QTY',
                          //       ),
                          //     ),
                          //     DataColumn(
                          //       label: Text(
                          //         'Purchase',
                          //         overflow: TextOverflow.ellipsis,
                          //         maxLines: 2,
                          //       ),
                          //     ),
                          //     DataColumn(
                          //       label: Text(
                          //         'Sale',
                          //         overflow: TextOverflow.ellipsis,
                          //         maxLines: 2,
                          //       ),
                          //     ),
                          //   ],
                          //   rows: const [],
                          // ),
                          ListView.builder(
                              itemCount: product.length,
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
                                            product[index].productName.toString(),
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.poppins(
                                              color: (product[index].productStock ?? 0) < 20 ? Colors.red : Colors.black,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                          Text(
                                            product[index].brand?.brandName ?? '',
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.poppins(
                                              color: (product[index].productStock ?? 0) < 20 ? Colors.red : kGreyTextColor,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        product[index].productStock.toString(),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          color: (product[index].productStock ?? 0) < 20 ? Colors.red : Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          '${product[index].productPurchasePrice}',
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.poppins(
                                            color: (product[index].productStock ?? 0) < 20 ? Colors.red : Colors.black,
                                          ),
                                        )),
                                    Expanded(
                                      child: Text(
                                        '${product[index].productSalePrice}',
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.poppins(
                                          color: (product[index].productStock ?? 0) < 20 ? Colors.red : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ],
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
                // Expanded(
                //   flex: 2,
                //   child: Text(
                //     totalStock.toString(),
                //     style: GoogleFonts.poppins(
                //       color: Colors.black,
                //     ),
                //   ),
                // ),
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
