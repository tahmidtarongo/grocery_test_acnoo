import 'package:flutter/material.dart';
import 'package:mobile_pos/constant.dart';
import 'package:mobile_pos/currency.dart';

class ExpenseReport extends StatefulWidget {
  const ExpenseReport({Key? key}) : super(key: key);

  @override
  State<ExpenseReport> createState() => _ExpenseReportState();
}

class _ExpenseReportState extends State<ExpenseReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kWhite,
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        title: const Text('Expense Report'),
        surfaceTintColor: kWhite,
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
            color: Color(0xffFEF0F1)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total:',style: gTextStyle.copyWith(fontWeight: FontWeight.bold,color: kTitleColor),),
            Text('$currency 500',style: gTextStyle.copyWith(fontWeight: FontWeight.bold,color: kTitleColor),),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xffFEF0F1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Name',style: gTextStyle.copyWith(fontWeight: FontWeight.bold,color: kTitleColor),),
                Text('Category',style: gTextStyle.copyWith(fontWeight: FontWeight.bold,color: kTitleColor),),
                Text('Balance',style: gTextStyle.copyWith(fontWeight: FontWeight.bold,color: kTitleColor),),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 20,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_,index){
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Staff Salary'),
                                Text('Jun 29, 2024',style: gTextStyle.copyWith(color: kGreyTextColor),)
                              ],
                            ),
                            const Text('Salary'),
                            Text('$currency 5,000.00')
                          ],
                        ),
                      );
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
