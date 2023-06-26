// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueButton {
    return Intl.message(
      'Continue',
      name: 'continueButton',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone {
    return Intl.message(
      'Phone Number',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email {
    return Intl.message(
      'Email Address',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Previous Due`
  String get previousDue {
    return Intl.message(
      'Previous Due',
      name: 'previousDue',
      desc: '',
      args: [],
    );
  }

  /// `Select Your Language`
  String get selectLang {
    return Intl.message(
      'Select Your Language',
      name: 'selectLang',
      desc: '',
      args: [],
    );
  }

  /// `Add Contact`
  String get addContact {
    return Intl.message(
      'Add Contact',
      name: 'addContact',
      desc: '',
      args: [],
    );
  }

  /// `More Info`
  String get moreInfo {
    return Intl.message(
      'More Info',
      name: 'moreInfo',
      desc: '',
      args: [],
    );
  }

  /// `Retailer`
  String get retailer {
    return Intl.message(
      'Retailer',
      name: 'retailer',
      desc: '',
      args: [],
    );
  }

  /// `Dealer`
  String get dealer {
    return Intl.message(
      'Dealer',
      name: 'dealer',
      desc: '',
      args: [],
    );
  }

  /// `Wholesaler`
  String get wholesaler {
    return Intl.message(
      'Wholesaler',
      name: 'wholesaler',
      desc: '',
      args: [],
    );
  }

  /// `Supplier`
  String get supplier {
    return Intl.message(
      'Supplier',
      name: 'supplier',
      desc: '',
      args: [],
    );
  }

  /// `Customer Details`
  String get CustomerDetails {
    return Intl.message(
      'Customer Details',
      name: 'CustomerDetails',
      desc: '',
      args: [],
    );
  }

  /// `Recent Transactions`
  String get recentTransaction {
    return Intl.message(
      'Recent Transactions',
      name: 'recentTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Total Products`
  String get totalProduct {
    return Intl.message(
      'Total Products',
      name: 'totalProduct',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get paid {
    return Intl.message(
      'Paid',
      name: 'paid',
      desc: '',
      args: [],
    );
  }

  /// `UnPaid`
  String get unPaid {
    return Intl.message(
      'UnPaid',
      name: 'unPaid',
      desc: '',
      args: [],
    );
  }

  /// `Due`
  String get due {
    return Intl.message(
      'Due',
      name: 'due',
      desc: '',
      args: [],
    );
  }

  /// `Click to connect`
  String get connect {
    return Intl.message(
      'Click to connect',
      name: 'connect',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Parties List`
  String get partyList {
    return Intl.message(
      'Parties List',
      name: 'partyList',
      desc: '',
      args: [],
    );
  }

  /// `Please Add A Customer`
  String get addCustomer {
    return Intl.message(
      'Please Add A Customer',
      name: 'addCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Update Contact`
  String get updateContact {
    return Intl.message(
      'Update Contact',
      name: 'updateContact',
      desc: '',
      args: [],
    );
  }

  /// `Due List`
  String get dueList {
    return Intl.message(
      'Due List',
      name: 'dueList',
      desc: '',
      args: [],
    );
  }

  /// `Collect Due`
  String get collectDue {
    return Intl.message(
      'Collect Due',
      name: 'collectDue',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Due Amount: `
  String get dueAmount {
    return Intl.message(
      'Due Amount: ',
      name: 'dueAmount',
      desc: '',
      args: [],
    );
  }

  /// `Customer Name`
  String get customerName {
    return Intl.message(
      'Customer Name',
      name: 'customerName',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get totalAmount {
    return Intl.message(
      'Total Amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Paid Amount`
  String get paidAmount {
    return Intl.message(
      'Paid Amount',
      name: 'paidAmount',
      desc: '',
      args: [],
    );
  }

  /// `Payment Type`
  String get paymentTypes {
    return Intl.message(
      'Payment Type',
      name: 'paymentTypes',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Expense Report`
  String get expenseReport {
    return Intl.message(
      'Expense Report',
      name: 'expenseReport',
      desc: '',
      args: [],
    );
  }

  /// `From Date`
  String get fromDate {
    return Intl.message(
      'From Date',
      name: 'fromDate',
      desc: '',
      args: [],
    );
  }

  /// `To Date`
  String get toDate {
    return Intl.message(
      'To Date',
      name: 'toDate',
      desc: '',
      args: [],
    );
  }

  /// `Expense For`
  String get expenseFor {
    return Intl.message(
      'Expense For',
      name: 'expenseFor',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `No Data Available`
  String get noData {
    return Intl.message(
      'No Data Available',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `Total Expense`
  String get totalExpense {
    return Intl.message(
      'Total Expense',
      name: 'totalExpense',
      desc: '',
      args: [],
    );
  }

  /// `Add Expense`
  String get addExpense {
    return Intl.message(
      'Add Expense',
      name: 'addExpense',
      desc: '',
      args: [],
    );
  }

  /// `Expense Date`
  String get expenseDate {
    return Intl.message(
      'Expense Date',
      name: 'expenseDate',
      desc: '',
      args: [],
    );
  }

  /// `Reference Number`
  String get referenceNo {
    return Intl.message(
      'Reference Number',
      name: 'referenceNo',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Expense Categories`
  String get expenseCat {
    return Intl.message(
      'Expense Categories',
      name: 'expenseCat',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Add Expense Category`
  String get addExpenseCat {
    return Intl.message(
      'Add Expense Category',
      name: 'addExpenseCat',
      desc: '',
      args: [],
    );
  }

  /// `Category name`
  String get categoryName {
    return Intl.message(
      'Category name',
      name: 'categoryName',
      desc: '',
      args: [],
    );
  }

  /// `Already Added`
  String get alreadyAdded {
    return Intl.message(
      'Already Added',
      name: 'alreadyAdded',
      desc: '',
      args: [],
    );
  }

  /// `What's New`
  String get whatNew {
    return Intl.message(
      'What\'s New',
      name: 'whatNew',
      desc: '',
      args: [],
    );
  }

  /// `Loss/Profit`
  String get lp {
    return Intl.message(
      'Loss/Profit',
      name: 'lp',
      desc: '',
      args: [],
    );
  }

  /// `Profit`
  String get profit {
    return Intl.message(
      'Profit',
      name: 'profit',
      desc: '',
      args: [],
    );
  }

  /// `Loss`
  String get loss {
    return Intl.message(
      'Loss',
      name: 'loss',
      desc: '',
      args: [],
    );
  }

  /// `Loss/Profit Details`
  String get lpDetails {
    return Intl.message(
      'Loss/Profit Details',
      name: 'lpDetails',
      desc: '',
      args: [],
    );
  }

  /// `Invoice`
  String get invoice {
    return Intl.message(
      'Invoice',
      name: 'invoice',
      desc: '',
      args: [],
    );
  }

  /// `Date:`
  String get dates {
    return Intl.message(
      'Date:',
      name: 'dates',
      desc: '',
      args: [],
    );
  }

  /// `Mobile:`
  String get mobile {
    return Intl.message(
      'Mobile:',
      name: 'mobile',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message(
      'Product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Total Loss`
  String get totalLoss {
    return Intl.message(
      'Total Loss',
      name: 'totalLoss',
      desc: '',
      args: [],
    );
  }

  /// `Total Profit`
  String get totalProfit {
    return Intl.message(
      'Total Profit',
      name: 'totalProfit',
      desc: '',
      args: [],
    );
  }

  /// `Product List`
  String get productList {
    return Intl.message(
      'Product List',
      name: 'productList',
      desc: '',
      args: [],
    );
  }

  /// `Stock`
  String get stock {
    return Intl.message(
      'Stock',
      name: 'stock',
      desc: '',
      args: [],
    );
  }

  /// `Add New Product`
  String get addNewProduct {
    return Intl.message(
      'Add New Product',
      name: 'addNewProduct',
      desc: '',
      args: [],
    );
  }

  /// `Product name`
  String get productName {
    return Intl.message(
      'Product name',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `Product Code`
  String get productCode {
    return Intl.message(
      'Product Code',
      name: 'productCode',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Price`
  String get purchasePrice {
    return Intl.message(
      'Purchase Price',
      name: 'purchasePrice',
      desc: '',
      args: [],
    );
  }

  /// `MRP`
  String get mrp {
    return Intl.message(
      'MRP',
      name: 'mrp',
      desc: '',
      args: [],
    );
  }

  /// `WholeSale Price`
  String get wholeSalePrice {
    return Intl.message(
      'WholeSale Price',
      name: 'wholeSalePrice',
      desc: '',
      args: [],
    );
  }

  /// `Dealer price`
  String get dealerPrice {
    return Intl.message(
      'Dealer price',
      name: 'dealerPrice',
      desc: '',
      args: [],
    );
  }

  /// `Manufacturer`
  String get manufacturer {
    return Intl.message(
      'Manufacturer',
      name: 'manufacturer',
      desc: '',
      args: [],
    );
  }

  /// `Save and Publish`
  String get saveNPublish {
    return Intl.message(
      'Save and Publish',
      name: 'saveNPublish',
      desc: '',
      args: [],
    );
  }

  /// `Brands`
  String get brands {
    return Intl.message(
      'Brands',
      name: 'brands',
      desc: '',
      args: [],
    );
  }

  /// `Add Brand`
  String get addBrand {
    return Intl.message(
      'Add Brand',
      name: 'addBrand',
      desc: '',
      args: [],
    );
  }

  /// `Brand name`
  String get brandName {
    return Intl.message(
      'Brand name',
      name: 'brandName',
      desc: '',
      args: [],
    );
  }

  /// `Add Unit`
  String get addUnit {
    return Intl.message(
      'Add Unit',
      name: 'addUnit',
      desc: '',
      args: [],
    );
  }

  /// `Unit name`
  String get unitName {
    return Intl.message(
      'Unit name',
      name: 'unitName',
      desc: '',
      args: [],
    );
  }

  /// `Units`
  String get units {
    return Intl.message(
      'Units',
      name: 'units',
      desc: '',
      args: [],
    );
  }

  /// `Please Add A Product`
  String get addProduct {
    return Intl.message(
      'Please Add A Product',
      name: 'addProduct',
      desc: '',
      args: [],
    );
  }

  /// `Update Product`
  String get updateProduct {
    return Intl.message(
      'Update Product',
      name: 'updateProduct',
      desc: '',
      args: [],
    );
  }

  /// `Sale Price`
  String get salePrice {
    return Intl.message(
      'Sale Price',
      name: 'salePrice',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Business Category`
  String get businessCat {
    return Intl.message(
      'Business Category',
      name: 'businessCat',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Update Your Profile`
  String get updateProfile {
    return Intl.message(
      'Update Your Profile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Company & Business Name`
  String get businessName {
    return Intl.message(
      'Company & Business Name',
      name: 'businessName',
      desc: '',
      args: [],
    );
  }

  /// `Add Purchase`
  String get addPurchase {
    return Intl.message(
      'Add Purchase',
      name: 'addPurchase',
      desc: '',
      args: [],
    );
  }

  /// `Inv No.`
  String get inv {
    return Intl.message(
      'Inv No.',
      name: 'inv',
      desc: '',
      args: [],
    );
  }

  /// `Supplier Name`
  String get supplierName {
    return Intl.message(
      'Supplier Name',
      name: 'supplierName',
      desc: '',
      args: [],
    );
  }

  /// `Item Added`
  String get itemAdded {
    return Intl.message(
      'Item Added',
      name: 'itemAdded',
      desc: '',
      args: [],
    );
  }

  /// `Add Items`
  String get addItems {
    return Intl.message(
      'Add Items',
      name: 'addItems',
      desc: '',
      args: [],
    );
  }

  /// `Sub Total`
  String get subTotal {
    return Intl.message(
      'Sub Total',
      name: 'subTotal',
      desc: '',
      args: [],
    );
  }

  /// `Return Amount`
  String get returnAmount {
    return Intl.message(
      'Return Amount',
      name: 'returnAmount',
      desc: '',
      args: [],
    );
  }

  /// `Choose a Supplier`
  String get chooseSupplier {
    return Intl.message(
      'Choose a Supplier',
      name: 'chooseSupplier',
      desc: '',
      args: [],
    );
  }

  /// `No Supplier Available`
  String get noSupplier {
    return Intl.message(
      'No Supplier Available',
      name: 'noSupplier',
      desc: '',
      args: [],
    );
  }

  /// `Sales Details`
  String get salesDetails {
    return Intl.message(
      'Sales Details',
      name: 'salesDetails',
      desc: '',
      args: [],
    );
  }

  /// `Edit Purchase Invoice`
  String get editPurchaseInvoice {
    return Intl.message(
      'Edit Purchase Invoice',
      name: 'editPurchaseInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Purchase List`
  String get purchaseList {
    return Intl.message(
      'Purchase List',
      name: 'purchaseList',
      desc: '',
      args: [],
    );
  }

  /// `Please Add A Purchase`
  String get addAPurchase {
    return Intl.message(
      'Please Add A Purchase',
      name: 'addAPurchase',
      desc: '',
      args: [],
    );
  }

  /// `Due Report`
  String get dueReport {
    return Intl.message(
      'Due Report',
      name: 'dueReport',
      desc: '',
      args: [],
    );
  }

  /// `Fully Paid`
  String get fullyPaid {
    return Intl.message(
      'Fully Paid',
      name: 'fullyPaid',
      desc: '',
      args: [],
    );
  }

  /// `Still Unpaid`
  String get stillUnpaid {
    return Intl.message(
      'Still Unpaid',
      name: 'stillUnpaid',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Report`
  String get purchaseReport {
    return Intl.message(
      'Purchase Report',
      name: 'purchaseReport',
      desc: '',
      args: [],
    );
  }

  /// `Connect your printer`
  String get connectPrinter {
    return Intl.message(
      'Connect your printer',
      name: 'connectPrinter',
      desc: '',
      args: [],
    );
  }

  /// `Click to connect`
  String get clickToConnect {
    return Intl.message(
      'Click to connect',
      name: 'clickToConnect',
      desc: '',
      args: [],
    );
  }

  /// `Please Collect A Due`
  String get collectDues {
    return Intl.message(
      'Please Collect A Due',
      name: 'collectDues',
      desc: '',
      args: [],
    );
  }

  /// `Please Add A Purchase`
  String get addNewPurchase {
    return Intl.message(
      'Please Add A Purchase',
      name: 'addNewPurchase',
      desc: '',
      args: [],
    );
  }

  /// `Sales Report`
  String get salesReport {
    return Intl.message(
      'Sales Report',
      name: 'salesReport',
      desc: '',
      args: [],
    );
  }

  /// `Please Add A Sale`
  String get addSale {
    return Intl.message(
      'Please Add A Sale',
      name: 'addSale',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get reports {
    return Intl.message(
      'Reports',
      name: 'reports',
      desc: '',
      args: [],
    );
  }

  /// `Choose a Customer`
  String get chooseCustomer {
    return Intl.message(
      'Choose a Customer',
      name: 'chooseCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Add Sales`
  String get addSales {
    return Intl.message(
      'Add Sales',
      name: 'addSales',
      desc: '',
      args: [],
    );
  }

  /// `Sales List`
  String get saleList {
    return Intl.message(
      'Sales List',
      name: 'saleList',
      desc: '',
      args: [],
    );
  }

  /// `Edit Sales Invoice`
  String get editSalesInvoice {
    return Intl.message(
      'Edit Sales Invoice',
      name: 'editSalesInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Previous Pay Amount`
  String get previousPayAmount {
    return Intl.message(
      'Previous Pay Amount',
      name: 'previousPayAmount',
      desc: '',
      args: [],
    );
  }

  /// `Printing Option`
  String get printing {
    return Intl.message(
      'Printing Option',
      name: 'printing',
      desc: '',
      args: [],
    );
  }

  /// `Subscription`
  String get subscription {
    return Intl.message(
      'Subscription',
      name: 'subscription',
      desc: '',
      args: [],
    );
  }

  /// `User Role`
  String get userRole {
    return Intl.message(
      'User Role',
      name: 'userRole',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message(
      'Currency',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message(
      'Log Out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Stock List`
  String get stockList {
    return Intl.message(
      'Stock List',
      name: 'stockList',
      desc: '',
      args: [],
    );
  }

  /// `Purchase`
  String get purchase {
    return Intl.message(
      'Purchase',
      name: 'purchase',
      desc: '',
      args: [],
    );
  }

  /// `Sale`
  String get sale {
    return Intl.message(
      'Sale',
      name: 'sale',
      desc: '',
      args: [],
    );
  }

  /// `Your Package`
  String get yourPack {
    return Intl.message(
      'Your Package',
      name: 'yourPack',
      desc: '',
      args: [],
    );
  }

  /// `Free Plan`
  String get freePlan {
    return Intl.message(
      'Free Plan',
      name: 'freePlan',
      desc: '',
      args: [],
    );
  }

  /// `You are using `
  String get youRUsing {
    return Intl.message(
      'You are using ',
      name: 'youRUsing',
      desc: '',
      args: [],
    );
  }

  /// `Free Package`
  String get freePack {
    return Intl.message(
      'Free Package',
      name: 'freePack',
      desc: '',
      args: [],
    );
  }

  /// `Premium Plan`
  String get premiumPlan {
    return Intl.message(
      'Premium Plan',
      name: 'premiumPlan',
      desc: '',
      args: [],
    );
  }

  /// `Package Features`
  String get packFeatures {
    return Intl.message(
      'Package Features',
      name: 'packFeatures',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited`
  String get unlimited {
    return Intl.message(
      'Unlimited',
      name: 'unlimited',
      desc: '',
      args: [],
    );
  }

  /// `Update Now`
  String get updateNow {
    return Intl.message(
      'Update Now',
      name: 'updateNow',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Premium Plan`
  String get purchasePremium {
    return Intl.message(
      'Purchase Premium Plan',
      name: 'purchasePremium',
      desc: '',
      args: [],
    );
  }

  /// `Buy premium Plan`
  String get buyPremium {
    return Intl.message(
      'Buy premium Plan',
      name: 'buyPremium',
      desc: '',
      args: [],
    );
  }

  /// `Pay With Paypal`
  String get paypalPay {
    return Intl.message(
      'Pay With Paypal',
      name: 'paypalPay',
      desc: '',
      args: [],
    );
  }

  /// `You Have Got An Email`
  String get gotEmail {
    return Intl.message(
      'You Have Got An Email',
      name: 'gotEmail',
      desc: '',
      args: [],
    );
  }

  /// `We Have Send An Email with instructions on how to reset password to:`
  String get sendEmail {
    return Intl.message(
      'We Have Send An Email with instructions on how to reset password to:',
      name: 'sendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Check Email`
  String get checkEmail {
    return Intl.message(
      'Check Email',
      name: 'checkEmail',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get forgotPassword {
    return Intl.message(
      'Forgot password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address below to receive password Reset Link.`
  String get enterEmail {
    return Intl.message(
      'Please enter your email address below to receive password Reset Link.',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Link`
  String get sendLink {
    return Intl.message(
      'Send Reset Link',
      name: 'sendLink',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailText {
    return Intl.message(
      'Email',
      name: 'emailText',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get logIn {
    return Intl.message(
      'Log In',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Haven't any account?`
  String get noAcc {
    return Intl.message(
      'Haven\'t any account?',
      name: 'noAcc',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Phone Verification`
  String get phoneVerification {
    return Intl.message(
      'Phone Verification',
      name: 'phoneVerification',
      desc: '',
      args: [],
    );
  }

  /// `We need to register your phone without getting started!`
  String get registerTitle {
    return Intl.message(
      'We need to register your phone without getting started!',
      name: 'registerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Send the code`
  String get sendCode {
    return Intl.message(
      'Send the code',
      name: 'sendCode',
      desc: '',
      args: [],
    );
  }

  /// `Staff Login`
  String get staffLogin {
    return Intl.message(
      'Staff Login',
      name: 'staffLogin',
      desc: '',
      args: [],
    );
  }

  /// `Login With Email`
  String get logInWithMail {
    return Intl.message(
      'Login With Email',
      name: 'logInWithMail',
      desc: '',
      args: [],
    );
  }

  /// `Setup Your Profile`
  String get setUpProfile {
    return Intl.message(
      'Setup Your Profile',
      name: 'setUpProfile',
      desc: '',
      args: [],
    );
  }

  /// `Update your profile to connect your doctor with better impression`
  String get setUpDesc {
    return Intl.message(
      'Update your profile to connect your doctor with better impression',
      name: 'setUpDesc',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Company Address`
  String get companyAddress {
    return Intl.message(
      'Company Address',
      name: 'companyAddress',
      desc: '',
      args: [],
    );
  }

  /// `Opening Balance`
  String get openingBalance {
    return Intl.message(
      'Opening Balance',
      name: 'openingBalance',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPass {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPass',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get haveAcc {
    return Intl.message(
      'Already have an account?',
      name: 'haveAcc',
      desc: '',
      args: [],
    );
  }

  /// `Login With Phone`
  String get loginWithPhone {
    return Intl.message(
      'Login With Phone',
      name: 'loginWithPhone',
      desc: '',
      args: [],
    );
  }

  /// `Edit Phone Number ?`
  String get editPhone {
    return Intl.message(
      'Edit Phone Number ?',
      name: 'editPhone',
      desc: '',
      args: [],
    );
  }

  /// `Create a Free Account`
  String get createAcc {
    return Intl.message(
      'Create a Free Account',
      name: 'createAcc',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations`
  String get congratulation {
    return Intl.message(
      'Congratulations',
      name: 'congratulation',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'af'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'az'),
      Locale.fromSubtags(languageCode: 'bn'),
      Locale.fromSubtags(languageCode: 'bs'),
      Locale.fromSubtags(languageCode: 'cs'),
      Locale.fromSubtags(languageCode: 'da'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'el'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fa'),
      Locale.fromSubtags(languageCode: 'fi'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'he'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'hr'),
      Locale.fromSubtags(languageCode: 'hu'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'kk'),
      Locale.fromSubtags(languageCode: 'km'),
      Locale.fromSubtags(languageCode: 'kn'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'lo'),
      Locale.fromSubtags(languageCode: 'mr'),
      Locale.fromSubtags(languageCode: 'ms'),
      Locale.fromSubtags(languageCode: 'my'),
      Locale.fromSubtags(languageCode: 'ne'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ro'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'si'),
      Locale.fromSubtags(languageCode: 'sk'),
      Locale.fromSubtags(languageCode: 'sq'),
      Locale.fromSubtags(languageCode: 'sr'),
      Locale.fromSubtags(languageCode: 'sv'),
      Locale.fromSubtags(languageCode: 'sw'),
      Locale.fromSubtags(languageCode: 'ta'),
      Locale.fromSubtags(languageCode: 'th'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'uk'),
      Locale.fromSubtags(languageCode: 'ur'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
