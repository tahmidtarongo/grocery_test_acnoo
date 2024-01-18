
import 'package:flutter/material.dart';

// const kMainColor = Color(0xFF3F8CFF);
const kMainColor = Color(0xFF007AD0);
const kGreyTextColor = Color(0xFF828282);
const kBorderColorTextField = Color(0xFFC2C2C2);
const kDarkWhite = Color(0xFFF1F7F7);
const kPremiumPlanColor = Color(0xFF8752EE);
const kPremiumPlanColor2 = Color(0xFFFF5F00);
const kTitleColor = Color(0xFF000000);
bool connected = false;
bool isPrintEnable = false;
List<String> paymentsTypeList = ['Cash', 'Card', 'Check', 'Mobile Pay', 'Due'];
bool isExpiringInFiveDays = false;
bool isExpiringInOneDays = false;
const String appVersion = '5.3';
String paypalClientId = '';
String paypalClientSecret = '';
const bool sandbox = true;
String noProductImageUrl = 'images/no_product_image.png';
String purchaseCode = '528cdb9a-5d37-4292-a2b5-b792d5eca03a';

const kButtonDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(
    Radius.circular(5),
  ),
);

const kInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: kBorderColorTextField),
  filled: true,
  fillColor: Colors.white70,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
  ),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(1.0),
    borderSide: const BorderSide(color: kBorderColorTextField),
  );
}

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

// List<String> language = ['English'];

List<String> productCategory = ['Fashion', 'Electronics', 'Computer', 'Gadgets', 'Watches', 'Cloths'];

///______________________________________________________________________________________________
String constUserId = '';
String subUserTitle = '';
String subUserEmail = '';
bool isSubUserDeleted = true;
bool newSelect = false;
