import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_pos/Screens/Currency/Provider/currency_provider.dart';
import 'package:mobile_pos/model/currency_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant.dart';
import '../../currency.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({Key? key}) : super(key: key);

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  CurrencyModel selectedCurrency = CurrencyModel(name: currencyName, symbol: currency);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, __) {
      final currencyData = ref.watch(currencyProvider);
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Currency',
            style: GoogleFonts.poppins(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0.0,
        ),
        body: currencyData.when(data: (data) {
          return  SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      selected: selectedCurrency.name == data[index].name,
                      selectedColor: Colors.white,
                      selectedTileColor: kMainColor.withOpacity(.7),


                      onTap: () {
                        setState(() {
                          selectedCurrency = data[index];
                        });
                      },
                      title: Text('${data[index].name} - ${data[index].symbol}'),
                      trailing: const Icon(
                        (Icons.arrow_forward_ios),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }, error: (error, stackTrace) {
          return null;
        }, loading: () => const Center(child: CircularProgressIndicator()),),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('currency', selectedCurrency.symbol);
              await prefs.setString('currencyName', selectedCurrency.name);
              setState(() {
                currency = selectedCurrency.symbol;
                currencyName = selectedCurrency.name;
                Navigator.pop(context);
              });
            },
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: kMainColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Center(
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
