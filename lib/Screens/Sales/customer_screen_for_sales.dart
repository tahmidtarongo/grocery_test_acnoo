import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_pos/Const/api_config.dart';
import 'package:mobile_pos/Screens/Customers/add_customer.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';
import '../../currency.dart';
import '../Customers/Provider/customer_provider.dart';

class CustomerScreenSales extends StatefulWidget {
  const CustomerScreenSales({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomerScreenSalesState createState() => _CustomerScreenSalesState();
}

class _CustomerScreenSalesState extends State<CustomerScreenSales> {
  Color color = Colors.black26;
  String searchCustomer = '';

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, __) {
      final providerData = ref.watch(partiesProvider);
      return Scaffold(
        backgroundColor: kWhite,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            lang.S.of(context).chooseCustomer,
            style: GoogleFonts.poppins(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: providerData.when(data: (customer) {
              return customer.isNotEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: AppTextField(
                            textFieldType: TextFieldType.NAME,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: lang.S.of(context).search,
                              prefixIcon: Icon(
                                Icons.search,
                                color: kGreyTextColor.withOpacity(0.5),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchCustomer = value;
                              });
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context, null);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 50.0,
                                  width: 50.0,
                                  child: CircleAvatar(
                                    foregroundColor: Colors.blue,
                                    backgroundColor: Colors.white,
                                    radius: 70.0,
                                    child: ClipOval(
                                      child: Image.asset(
                                        'images/no_shop_image.png',
                                        fit: BoxFit.cover,
                                        width: 120.0,
                                        height: 120.0,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lang.S.of(context).walkInCustomer,
                                      //'Walk-in Customer',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    Text(
                                      lang.S.of(context).guest,
                                      //'Guest',
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const SizedBox(width: 20),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: kGreyTextColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: customer.length,
                            itemBuilder: (_, index) {
                              customer[index].type == 'Retailer' ? color = const Color(0xFF56da87) : Colors.white;
                              customer[index].type == 'Wholesaler' ? color = const Color(0xFF25a9e0) : Colors.white;
                              customer[index].type == 'Dealer' ? color = const Color(0xFFff5f00) : Colors.white;
                              customer[index].type == 'Supplier' ? color = const Color(0xFFA569BD) : Colors.white;
                              return customer[index].name!.contains(searchCustomer) && !customer[index].type!.contains('Supplier')
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context, customer[index]);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 50.0,
                                              width: 50.0,
                                              child: CircleAvatar(
                                                foregroundColor: Colors.blue,
                                                backgroundColor: Colors.white,
                                                radius: 70.0,
                                                child: ClipOval(
                                                  child: customer[index].image == null
                                                      ? Image.asset(
                                                          'images/no_shop_image.png',
                                                          fit: BoxFit.cover,
                                                          width: 120.0,
                                                          height: 120.0,
                                                        )
                                                      : Image.network(
                                                          '${APIConfig.domain}${customer[index].image}',
                                                          fit: BoxFit.cover,
                                                          width: 120.0,
                                                          height: 120.0,
                                                        ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10.0),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  customer[index].name ?? '',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                Text(
                                                  customer[index].type ?? '',
                                                  style: GoogleFonts.poppins(
                                                    color: color,
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '$currency ${customer[index].due}',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                Text(
                                                  lang.S.of(context).due,
                                                  style: GoogleFonts.poppins(
                                                    color: const Color(0xFFff5f00),
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                              ],
                                            ).visible(customer[index].due != null && customer[index].due != 0),
                                            const SizedBox(width: 20),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              color: kGreyTextColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container();
                            }),
                      ],
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.pop(context, null);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 50.0,
                              width: 50.0,
                              child: CircleAvatar(
                                foregroundColor: Colors.blue,
                                backgroundColor: Colors.white,
                                radius: 70.0,
                                child: ClipOval(
                                  child: Image.asset(
                                    'images/no_shop_image.png',
                                    fit: BoxFit.cover,
                                    width: 120.0,
                                    height: 120.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lang.S.of(context).walkInCustomer,
                                  //'Walk-in Customer',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                  ),
                                ),
                                Text(
                                  lang.S.of(context).guest,
                                  //'Guest',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const SizedBox(width: 20),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: kGreyTextColor,
                            ),
                          ],
                        ),
                      ),
                    );
            }, error: (e, stack) {
              return Text(e.toString());
            }, loading: () {
              return const Center(child: CircularProgressIndicator());
            }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: kMainColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            child: const Icon(
              Icons.add,
              color: kWhite,
            ),
            onPressed: () {
              const AddParty().launch(context);
            }),
      );
    });
  }
}
