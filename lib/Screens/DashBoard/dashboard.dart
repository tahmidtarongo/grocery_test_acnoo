import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_pos/Screens/DashBoard/global_container.dart';
import 'package:mobile_pos/constant.dart';
import 'package:mobile_pos/currency.dart';

import 'numeric_axis.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);


  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<String> timeList=[
    'Weekly',
    'Monthly',
    'Yearly',
  ];
  String selectedTimeList='Weekly';
  DropdownButton<String> getTime(){
    List<DropdownMenuItem<String>> itemList=[];
    for(var des in timeList){
      var item=DropdownMenuItem(
          value: des,
          child: Text(des,style: const TextStyle(color: kGreyTextColor,fontSize: 14,fontWeight: FontWeight.w500),));
      itemList.add(item);
    }
    return DropdownButton(
      icon: const Icon(Icons.keyboard_arrow_down,color: kGreyTextColor,size: 18,),
      value: selectedTimeList,
        items: itemList,
        onChanged: (value){
        setState(() {
          selectedTimeList=value!;
        });
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kWhite,
        surfaceTintColor: kWhite,
        title: const Text('Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
                height: 32,
                padding: EdgeInsets.symmetric(horizontal: 5),
                // width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: kBorderColorTextField)
                ),
                child: DropdownButtonHideUnderline(child: getTime())),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: kWhite
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sales & Purchase Overview',style: gTextStyle.copyWith(fontWeight: FontWeight.bold,color: kTitleColor),),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.circle,color: Colors.green,size: 18,),
                        const SizedBox(width: 5,),
                        RichText(text: TextSpan(
                          text: 'Sales : ',
                          style: TextStyle(color: kTitleColor),
                          children: [
                            TextSpan(
                              text: '$currency 500',
                              style: gTextStyle.copyWith(fontWeight: FontWeight.bold,color: kTitleColor)
                            ),
                          ]
                        )),
                        const SizedBox(width: 20,),
                        const Icon(Icons.circle,color: kMainColor,size: 18,),
                        const SizedBox(width: 5,),
                        RichText(text: TextSpan(
                            text: 'Purchase : ',
                            style: const TextStyle(color: kTitleColor),
                            children: [
                              TextSpan(
                                  text: '$currency 300',
                                  style: gTextStyle.copyWith(fontWeight: FontWeight.bold,color: kTitleColor)
                              ),
                            ]
                        )),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    const SizedBox(
                        height: 250,
                        width: double.infinity,
                        child: NumericAxisChart()),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              const Row(
                children: [
                  Expanded(child: GlobalContainer(title: 'Total Items', image: 'assets/totalItem.svg', subtitle: '80')),
                  SizedBox(width: 12,),
                  Expanded(child: GlobalContainer(title: 'Total Categories', image: 'assets/purchaseLisst.svg', subtitle: '25'))
                ],
              ),
              const SizedBox(height: 20,),
              Text('Quick Overview',style: gTextStyle.copyWith(color: kTitleColor,fontWeight: FontWeight.bold,fontSize: 18),),
              const SizedBox(height: 10,),
               Row(
                children: [
                  Expanded(child: GlobalContainer(title: 'Total Income', image: 'assets/saleslist.svg', subtitle: '$currency 5,000.00')),
                  SizedBox(width: 12,),
                  Expanded(child: GlobalContainer(title: 'Total Expense', image: 'assets/expense.svg', subtitle: '$currency 4,0000.00'))
                ],
              ),
              const SizedBox(height: 10,),
               Row(
                children: [
                  Expanded(child: GlobalContainer(title: 'Total Due', image: 'assets/duelist.svg', subtitle: '$currency 5,000')),
                  SizedBox(width: 12,),
                  Expanded(child: GlobalContainer(title: 'Stock Qty', image: 'assets/stock.svg', subtitle: '250'))
                ],
              ),
              SizedBox(height: 20,),
              Text('Loss/Profit',style: gTextStyle.copyWith(color: kTitleColor,fontWeight: FontWeight.bold,fontSize: 18),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(child: GlobalContainer(title: 'Total Profit', image: 'assets/lossprofit.svg', subtitle: '$currency 50,000')),
                  SizedBox(width: 12,),
                  Expanded(child: GlobalContainer(title: 'Toatal Loss', image: 'assets/expense.svg', subtitle: '$currency 5,000'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
