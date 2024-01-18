// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_pos/Const/api_config.dart';
import 'package:mobile_pos/Provider/print_purchase_invoice_provider.dart';
import 'package:mobile_pos/Provider/transactions_provider.dart';
import 'package:mobile_pos/Screens/Customers/edit_customer.dart';
import 'package:mobile_pos/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../GlobalComponents/button_global.dart';
import '../../Provider/print_sales_invoice_provider.dart';
import '../../Provider/profile_provider.dart';
import '../../Repository/API/create_party_repo.dart';
import '../../currency.dart';
import '../../model/print_transaction_model.dart';
import '../invoice_details/purchase_invoice_details.dart';
import '../invoice_details/sales_invoice_details_screen.dart';
import 'Model/parties_model.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;

// ignore: must_be_immutable
class CustomerDetails extends StatefulWidget {
  CustomerDetails({Key? key, required this.party}) : super(key: key);
  Party party;

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  String buttonsSelected = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> showDeleteConfirmationAlert({
    required BuildContext context,
    required String id,
    required WidgetRef ref,
  }) async {
    return showDialog(
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this party?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                final party = PartyRepository();
                await party.deleteParty(id: id, context: context, ref: ref);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, cRef, __) {
      final providerData = cRef.watch(salesTransactionProvider);
      final purchaseList = cRef.watch(purchaseTransactionProvider);
      final printerData = cRef.watch(salesPrinterProvider);
      final printerDataPurchase = cRef.watch(printerPurchaseProviderNotifier);
      final personalData = cRef.watch(businessInfoProvider);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            lang.S.of(context).CustomerDetails,
            style: GoogleFonts.poppins(
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                EditCustomer(customerModel: widget.party).launch(context);
              },
              icon: const Icon(
                FeatherIcons.edit2,
                color: Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () async {
                await showDeleteConfirmationAlert(context: context, id: widget.party.id.toString(), ref: cRef);
              },

              // onPressed: () async {
              //   // DatabaseReference ref = FirebaseDatabase.instance.ref("$constUserId/Customers/$customerKey");
              //   // await ref.remove();
              //   cRef.refresh(partiesProvider);
              //   // ignore: use_build_context_synchronously
              //   Navigator.pop(context);
              // },
              icon: const Icon(
                FeatherIcons.trash2,
                color: Colors.grey,
              ),
            ),
          ],
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  image: widget.party.image == null
                      ? const DecorationImage(
                          image: AssetImage('images/no_shop_image.png'),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(
                          image: NetworkImage('${APIConfig.domain}${widget.party.image!}'),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.party.name ?? '',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.party.phone ?? '',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final Uri url = Uri.parse('tel:${widget.party.phone}');

                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }

                      setState(() {
                        buttonsSelected = 'Call';
                      });
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration:
                          BoxDecoration(color: buttonsSelected == 'Call' ? kMainColor : kMainColor.withOpacity(0.10), borderRadius: const BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FeatherIcons.phone,
                              size: 25,
                              color: buttonsSelected == 'Call' ? Colors.white : Colors.black,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Call',
                              style: TextStyle(
                                fontSize: 20,
                                color: buttonsSelected == 'Call' ? Colors.white : Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final Uri url = Uri.parse('sms:${widget.party.phone}');

                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                      setState(() {
                        buttonsSelected = 'Message';
                      });
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: buttonsSelected == 'Message' ? kMainColor : kMainColor.withOpacity(0.10),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FeatherIcons.messageSquare,
                              size: 25,
                              color: buttonsSelected == 'Message' ? Colors.white : Colors.black,
                            ),
                            Text(
                              'Message',
                              style: TextStyle(
                                fontSize: 20,
                                color: buttonsSelected == 'Message' ? Colors.white : Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        buttonsSelected = 'Email';
                      });
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration:
                          BoxDecoration(color: buttonsSelected == 'Email' ? kMainColor : kMainColor.withOpacity(0.10), borderRadius: const BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FeatherIcons.mail,
                              size: 25,
                              color: buttonsSelected == 'Email' ? Colors.white : Colors.black,
                            ),
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 20,
                                color: buttonsSelected == 'Email' ? Colors.white : Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                lang.S.of(context).recentTransaction,
                style: const TextStyle(fontSize: 18),
              ),
              widget.party.type != 'Supplier'
                  ? providerData.when(data: (transaction) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: transaction.length,
                        itemBuilder: (context, index) {
                          final reTransaction = transaction.reversed.toList();
                          return Visibility(
                            visible: reTransaction[index].party?.id == widget.party.id,
                            child: GestureDetector(
                              onTap: () {
                                SalesInvoiceDetails(
                                  businessInfo: personalData.value!,
                                  saleTransaction: reTransaction[index],
                                ).launch(context);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    width: context.width(),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${lang.S.of(context).totalProduct} : ${reTransaction[index].details!.length.toString()}",
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                            Text('#${reTransaction[index].invoiceNumber}'),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: reTransaction[index].dueAmount! <= 0 ? const Color(0xff0dbf7d).withOpacity(0.1) : const Color(0xFFED1A3B).withOpacity(0.1),
                                                  borderRadius: const BorderRadius.all(Radius.circular(10))),
                                              child: Text(
                                                reTransaction[index].dueAmount! <= 0 ? lang.S.of(context).paid : lang.S.of(context).unPaid,
                                                style: TextStyle(color: reTransaction[index].dueAmount! <= 0 ? const Color(0xff0dbf7d) : const Color(0xFFED1A3B)),
                                              ),
                                            ),
                                            Text(
                                              reTransaction[index].saleDate!.substring(0, 10),
                                              style: const TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          '${lang.S.of(context).total} : $currency ${reTransaction[index].totalAmount.toString()}',
                                          style: const TextStyle(color: Colors.grey),
                                        ),
                                        personalData.when(data: (data) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${lang.S.of(context).due}: $currency ${reTransaction[index].dueAmount.toString()}',
                                                style: const TextStyle(fontSize: 16),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      await printerData.getBluetooth();
                                                      PrintTransactionModel model = PrintTransactionModel(transitionModel: reTransaction[index], personalInformationModel: data);
                                                      connected
                                                          ? printerData.printSalesTicket(
                                                              printTransactionModel: model,
                                                              productList: model.transitionModel!.details,
                                                            )
                                                          // ignore: use_build_context_synchronously
                                                          : showDialog(
                                                              context: context,
                                                              builder: (_) {
                                                                return Dialog(
                                                                  child: SizedBox(
                                                                    height: 200,
                                                                    child: ListView.builder(
                                                                      itemCount:
                                                                          printerData.availableBluetoothDevices.isNotEmpty ? printerData.availableBluetoothDevices.length : 0,
                                                                      itemBuilder: (context, index) {
                                                                        return ListTile(
                                                                          onTap: () async {
                                                                            String select = printerData.availableBluetoothDevices[index];
                                                                            List list = select.split("#");
                                                                            // String name = list[0];
                                                                            String mac = list[1];
                                                                            bool isConnect = await printerData.setConnect(mac);
                                                                            // ignore: use_build_context_synchronously
                                                                            isConnect
                                                                                // ignore: use_build_context_synchronously
                                                                                ? finish(context)
                                                                                : toast('Try Again');
                                                                          },
                                                                          title: Text('${printerData.availableBluetoothDevices[index]}'),
                                                                          subtitle: Text(lang.S.of(context).clickToConnect),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                    },
                                                    icon: const Icon(
                                                      FeatherIcons.printer,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      FeatherIcons.share,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        FeatherIcons.moreVertical,
                                                        color: Colors.grey,
                                                      )),
                                                ],
                                              )
                                            ],
                                          );
                                        }, error: (e, stack) {
                                          return Text(e.toString());
                                        }, loading: () {
                                          return const Text('Loading');
                                        }),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 0.5,
                                    width: context.width(),
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }, error: (e, stack) {
                      return Text(e.toString());
                    }, loading: () {
                      return const Center(child: CircularProgressIndicator());
                    })
                  : purchaseList.when(data: (transaction) {
                      final reTransaction = transaction.reversed.toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: reTransaction.length,
                        itemBuilder: (context, index) {
                          return Visibility(
                            visible: reTransaction[index].party?.id == widget.party.id,
                            child: GestureDetector(
                              onTap: () {
                                PurchaseInvoiceDetails(
                                  transitionModel: reTransaction[index],
                                  businessInfo: personalData.value!,
                                ).launch(context);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    width: context.width(),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${lang.S.of(context).totalProduct} : ${reTransaction[index].details!.length.toString()}",
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                            Text('#${reTransaction[index].invoiceNumber}'),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: reTransaction[index].dueAmount! <= 0 ? const Color(0xff0dbf7d).withOpacity(0.1) : const Color(0xFFED1A3B).withOpacity(0.1),
                                                  borderRadius: const BorderRadius.all(Radius.circular(10))),
                                              child: Text(
                                                reTransaction[index].dueAmount! <= 0 ? lang.S.of(context).paid : lang.S.of(context).unPaid,
                                                style: TextStyle(color: reTransaction[index].dueAmount! <= 0 ? const Color(0xff0dbf7d) : const Color(0xFFED1A3B)),
                                              ),
                                            ),
                                            Text(
                                              reTransaction[index].purchaseDate!.substring(0, 10),
                                              style: const TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          '${lang.S.of(context).total} : $currency ${reTransaction[index].totalAmount.toString()}',
                                          style: const TextStyle(color: Colors.grey),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${lang.S.of(context).due}: $currency ${reTransaction[index].dueAmount.toString()}',
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                            personalData.when(data: (data) {
                                              return Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: () async {
                                                        await printerData.getBluetooth();
                                                        PrintPurchaseTransactionModel model = PrintPurchaseTransactionModel(
                                                          personalInformationModel: data,
                                                          purchaseTransitionModel: reTransaction[index],
                                                        );
                                                        connected
                                                            ? printerDataPurchase.printPurchaseThermalInvoice(
                                                                printTransactionModel: model,
                                                                productList: model.purchaseTransitionModel!.details ?? [],
                                                              )
                                                            // ignore: use_build_context_synchronously
                                                            : showDialog(
                                                                context: context,
                                                                builder: (_) {
                                                                  return Dialog(
                                                                    child: SizedBox(
                                                                      height: 200,
                                                                      child: ListView.builder(
                                                                        itemCount:
                                                                            printerData.availableBluetoothDevices.isNotEmpty ? printerData.availableBluetoothDevices.length : 0,
                                                                        itemBuilder: (context, index) {
                                                                          return ListTile(
                                                                            onTap: () async {
                                                                              String select = printerData.availableBluetoothDevices[index];
                                                                              List list = select.split("#");
                                                                              // String name = list[0];
                                                                              String mac = list[1];
                                                                              bool isConnect = await printerData.setConnect(mac);
                                                                              // ignore: use_build_context_synchronously
                                                                              isConnect
                                                                                  // ignore: use_build_context_synchronously
                                                                                  ? finish(context)
                                                                                  // ignore: use_build_context_synchronously
                                                                                  : toast(lang.S.of(context).tryAgain);
                                                                            },
                                                                            title: Text('${printerData.availableBluetoothDevices[index]}'),
                                                                            subtitle: Text(lang.S.of(context).connect),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  );
                                                                });
                                                      },
                                                      icon: const Icon(
                                                        FeatherIcons.printer,
                                                        color: Colors.grey,
                                                      )),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        FeatherIcons.share,
                                                        color: Colors.grey,
                                                      )),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        FeatherIcons.moreVertical,
                                                        color: Colors.grey,
                                                      )),
                                                ],
                                              );
                                            }, error: (e, stack) {
                                              return Text(e.toString());
                                            }, loading: () {
                                              return Text(lang.S.of(context).loading);
                                            }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 0.5,
                                    width: context.width(),
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }, error: (e, stack) {
                      return Text(e.toString());
                    }, loading: () {
                      return const Center(child: CircularProgressIndicator());
                    }),
            ],
          ),
        ),
        bottomNavigationBar: ButtonGlobal(
          iconWidget: null,
          buttontext: lang.S.of(context).viewAll,
          iconColor: Colors.white,
          buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
          onPressed: () {},
        ),
      );
    });
  }
}
