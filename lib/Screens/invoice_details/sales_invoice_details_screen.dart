import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Const/api_config.dart';
import '../../Provider/print_sales_invoice_provider.dart';
import '../../currency.dart';
import '../../invoice_constant.dart';
// ignore: library_prefixes
import '../../constant.dart' as mainConstant;
import 'package:mobile_pos/generated/l10n.dart' as lang;
import '../../model/business_info_model.dart';
import '../../model/print_transaction_model.dart';
import '../../model/sale_transaction_model.dart';

class SalesInvoiceDetails extends StatefulWidget {
  const SalesInvoiceDetails({Key? key, required this.saleTransaction, required this.businessInfo, this.fromSale}) : super(key: key);

  final SalesTransaction saleTransaction;
  final BusinessInformation businessInfo;
  final bool? fromSale;

  @override
  State<SalesInvoiceDetails> createState() => _SalesInvoiceDetailsState();
}

class _SalesInvoiceDetailsState extends State<SalesInvoiceDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, __) {
      final printerData = ref.watch(salesPrinterProvider);
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: widget.businessInfo.pictureUrl.isEmptyOrNull
                          ? const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/no_shop_image.png'),
                              ),
                            )
                          : BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('${APIConfig.domain}${widget.businessInfo.pictureUrl ?? ''}'),
                              ),
                            ),
                    ),
                    title: Text(
                      '${widget.businessInfo.companyName}',
                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.businessInfo.address.toString(),
                          style: kTextStyle.copyWith(
                            color: kGreyTextColor,
                          ),
                        ),
                        Text(
                          widget.businessInfo.phoneNumber.toString(),
                          style: kTextStyle.copyWith(
                            color: kGreyTextColor,
                          ),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                  Divider(
                    thickness: 1.0,
                    color: kGreyTextColor.withOpacity(0.1),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text(
                        lang.S.of(context).billTO,
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${lang.S.of(context).invoice}# ${widget.saleTransaction.invoiceNumber}',
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'Name: ${widget.saleTransaction.party?.name ?? ''}',
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                      const Spacer(),
                      Text(
                        DateFormat.yMMMd().format(DateTime.parse(widget.saleTransaction.saleDate ?? DateTime.now().toString())),
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'Phone: ${widget.saleTransaction.party?.phone ?? ''}',
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                      const Spacer(),
                      Text(
                        widget.saleTransaction.saleDate?.substring(10, 16) ?? '',
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    'Sales By: ${widget.saleTransaction.user?.name ?? ''}',
                    style: kTextStyle.copyWith(color: kGreyTextColor),
                  ),
                  const SizedBox(height: 10.0),
                  Divider(
                    thickness: 1.0,
                    color: kGreyTextColor.withOpacity(0.1),
                  ),
                  // SizedBox(
                  //   width: context.width(),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         lang.S.of(context).product,
                  //         maxLines: 2,
                  //         style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                  //       ),
                  //       const Spacer(),
                  //       Text(
                  //         lang.S.of(context).unitPirce,
                  //         maxLines: 2,
                  //         style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                  //       ),
                  //       const Spacer(),
                  //       Text(
                  //         lang.S.of(context).quantity,
                  //         maxLines: 1,
                  //         style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                  //       ),
                  //       const Spacer(),
                  //       Text(
                  //         lang.S.of(context).totalPrice,
                  //         maxLines: 2,
                  //         style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 10.0),
                  // ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     itemCount: widget.saleTransaction.details!.length,
                  //     itemBuilder: (_, i) {
                  //       return Padding(
                  //         padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  //         child: SizedBox(
                  //           width: context.width(),
                  //           child: Row(
                  //             children: [
                  //               Text(
                  //                 widget.saleTransaction.details![i].product?.productName.toString() ?? '',
                  //                 maxLines: 2,
                  //                 style: kTextStyle.copyWith(color: kGreyTextColor),
                  //               ),
                  //               SizedBox(width: MediaQuery.of(context).size.width / 12),
                  //               Text(
                  //                 '$currency ${widget.saleTransaction.details![i].price}',
                  //                 maxLines: 2,
                  //                 style: kTextStyle.copyWith(color: kGreyTextColor),
                  //               ),
                  //               const Spacer(),
                  //               Text(
                  //                 widget.saleTransaction.details![i].quantities.toString(),
                  //                 maxLines: 1,
                  //                 style: kTextStyle.copyWith(color: kGreyTextColor),
                  //               ),
                  //               const Spacer(),
                  //               Text(
                  //                 '$currency ${(widget.saleTransaction.details![i].price ?? 0) * (widget.saleTransaction.details![i].quantities ?? 0)}',
                  //                 maxLines: 2,
                  //                 style: kTextStyle.copyWith(color: kTitleColor),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     }),
                  // Divider(
                  //   thickness: 1.0,
                  //   color: kGreyTextColor.withOpacity(0.1),
                  // ),

                  ///_________________________________________
                  SizedBox(
                    width: context.width(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: context.width() / 2.4,
                          child: Text(
                            lang.S.of(context).product,
                            maxLines: 2,
                            style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: (context.width() - (context.width() / 2.4 + 20)) / 3,
                          child: Text(
                            lang.S.of(context).quantity,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: (context.width() - (context.width() / 2.4 + 20)) / 3,
                          child: Text(
                            lang.S.of(context).unitPirce,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: (context.width() - (context.width() / 2.4 + 20)) / 3,
                          child: Text(
                            lang.S.of(context).totalPrice,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: kGreyTextColor.withOpacity(0.1),
                  ),
                  const SizedBox(height: 10.0),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.saleTransaction.details!.length,
                      itemBuilder: (_, i) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: SizedBox(
                            width: context.width(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: context.width() / 2.4,
                                  child: Text(
                                    widget.saleTransaction.details![i].product?.productName.toString() ?? '',
                                    maxLines: 2,
                                    style: kTextStyle.copyWith(color: kGreyTextColor),
                                  ),
                                ),
                                // const Spacer(),
                                SizedBox(
                                  width: (context.width() - (context.width() / 2.4 + 20)) / 3,
                                  child: Text(
                                    '$currency ${widget.saleTransaction.details![i].price}',
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: kTextStyle.copyWith(color: kGreyTextColor),
                                  ),
                                ),
                                SizedBox(
                                  width: (context.width() - (context.width() / 2.4 + 20)) / 3,
                                  child: Text(
                                    widget.saleTransaction.details![i].quantities.toString(),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: kTextStyle.copyWith(color: kGreyTextColor),
                                  ),
                                ),
                                SizedBox(
                                  width: (context.width() - (context.width() / 2.4 + 20)) / 3,
                                  child: Text(
                                    '$currency ${(widget.saleTransaction.details![i].price ?? 0) * (widget.saleTransaction.details![i].quantities ?? 0)}',
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: kTextStyle.copyWith(color: kTitleColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  Divider(
                    thickness: 1.0,
                    color: kGreyTextColor.withOpacity(0.1),
                  ),

                  ///__________________________________________
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        lang.S.of(context).subTotal,
                        maxLines: 1,
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                      const SizedBox(width: 20.0),
                      SizedBox(
                        width: 120,
                        child: Text(
                          '$currency ${widget.saleTransaction.totalAmount!.toDouble() + widget.saleTransaction.discountAmount!.toDouble()}',
                          maxLines: 2,
                          style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        lang.S.of(context).totalVat,
                        maxLines: 1,
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                      const SizedBox(width: 20.0),
                      SizedBox(
                        width: 120,
                        child: Text(
                          '$currency ${widget.saleTransaction.vatAmount}',
                          maxLines: 2,
                          style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        lang.S.of(context).discount,
                        maxLines: 1,
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                      const SizedBox(width: 20.0),
                      SizedBox(
                        width: 120,
                        child: Text(
                          '$currency ${widget.saleTransaction.discountAmount}',
                          maxLines: 2,
                          style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        lang.S.of(context).totalPayable,
                        maxLines: 1,
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 20.0),
                      SizedBox(
                        width: 120,
                        child: Text(
                          '$currency ${widget.saleTransaction.totalAmount}',
                          maxLines: 2,
                          style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        lang.S.of(context).paid,
                        maxLines: 1,
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                      const SizedBox(width: 20.0),
                      SizedBox(
                        width: 120,
                        child: Text(
                          '$currency ${widget.saleTransaction.totalAmount! - widget.saleTransaction.dueAmount!.toDouble()}',
                          maxLines: 2,
                          style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        lang.S.of(context).due,
                        maxLines: 1,
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                      const SizedBox(width: 20.0),
                      SizedBox(
                        width: 120,
                        child: Text(
                          '$currency ${widget.saleTransaction.dueAmount}',
                          maxLines: 2,
                          style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.0,
                    color: kGreyTextColor.withOpacity(0.1),
                  ),
                  const SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      lang.S.of(context).thakYouForYourPurchase,
                      maxLines: 1,
                      style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () async {
                    if (widget.fromSale ?? false) {
                      int count = 0;
                      Navigator.popUntil(context, (route) {
                        return count++ == 2;
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: 60,
                    width: context.width() / 3,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () async {
                    await printerData.getBluetooth();
                    PrintTransactionModel model = PrintTransactionModel(transitionModel: widget.saleTransaction, personalInformationModel: widget.businessInfo);
                    mainConstant.connected
                        ? printerData.printSalesTicket(
                            printTransactionModel: model,
                            productList: model.transitionModel!.details,
                          )
                        // ignore: use_build_context_synchronously
                        : showDialog(
                            context: context,
                            builder: (_) {
                              return WillPopScope(
                                onWillPop: () async => false,
                                child: Dialog(
                                  child: SizedBox(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: printerData.availableBluetoothDevices.isNotEmpty ? printerData.availableBluetoothDevices.length : 0,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              onTap: () async {
                                                String select = printerData.availableBluetoothDevices[index];
                                                List list = select.split("#");
                                                // String name = list[0];
                                                String mac = list[1];
                                                bool isConnect = await printerData.setConnect(mac);
                                                // ignore: use_build_context_synchronously
                                                isConnect ? finish(context) : toast('Try Again');
                                              },
                                              title: Text('${printerData.availableBluetoothDevices[index]}'),
                                              subtitle: Text(lang.S.of(context).clickToConnect),
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        Text(lang.S.of(context).connectPrinter),
                                        const SizedBox(height: 10),
                                        Container(height: 1, width: double.infinity, color: Colors.grey),
                                        const SizedBox(height: 15),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Center(
                                            child: Text(
                                              lang.S.of(context).cancel,
                                              style: const TextStyle(color: mainConstant.kMainColor),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                  },
                  child: Container(
                    height: 60,
                    width: context.width() / 3,
                    decoration: const BoxDecoration(
                      color: mainConstant.kMainColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        lang.S.of(context).print,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ),
      );
    });
  }
}
