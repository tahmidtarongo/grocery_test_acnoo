import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/business_info_model.dart' as business;
import '../../Products/Model/product_model.dart';
import '../home_screen.dart';

final productSearchProvider = ChangeNotifierProvider<ProductSearchNotifier>((ref) {
  return ProductSearchNotifier();
});

class ProductSearchNotifier extends ChangeNotifier {
  List<DrawerManuTile> drawerMenuList = [
    DrawerManuTile(title: 'Home', image: 'assets/grocery/home.svg', route: 'Home'),
    DrawerManuTile(title: 'Sales List', image: 'assets/grocery/sales_list.svg', route: 'Sales List'),
    DrawerManuTile(title: 'Parties', image: 'assets/grocery/parties.svg', route: 'Parties'),
    DrawerManuTile(title: 'Items', image: 'assets/grocery/items.svg', route: 'Products'),
    DrawerManuTile(title: 'Purchase', image: 'assets/grocery/purchase.svg', route: 'Purchase'),
    DrawerManuTile(title: 'Purchase List', image: 'assets/grocery/sales_list.svg', route: 'Purchase List'), // Assuming you intended to use 'sales_list.svg' here
    DrawerManuTile(title: 'Due List', image: 'assets/grocery/due_list.svg', route: 'Due List'),
    DrawerManuTile(title: 'Loss/Profit', image: 'assets/grocery/loss_profit.svg', route: 'Loss/Profit'),
    DrawerManuTile(title: 'Stocks', image: 'assets/grocery/stock.svg', route: "Stock"),
    // DrawerManuTile(title: 'Ledger', image: 'assets/grocery/ledger.svg',route: ''),
    DrawerManuTile(title: 'Expense', image: 'assets/grocery/expense.svg', route: 'Expense'),
    DrawerManuTile(title: 'Reports', image: 'assets/grocery/reports.svg', route: 'Reports'),
  ];
  bool checkPermission({required String item, required business.Visibility? visibility}) {
    if (item == 'Sales' && (visibility?.salePermission ?? true)) {
      return true;
    } else if (item == 'Parties' && (visibility?.partiesPermission ?? true)) {
      return true;
    } else if (item == 'Purchase' && (visibility?.purchasePermission ?? true)) {
      return true;
    } else if (item == 'Products' && (visibility?.productPermission ?? true)) {
      return true;
    } else if (item == 'Due List' && (visibility?.dueListPermission ?? true)) {
      return true;
    } else if (item == 'Stock' && (visibility?.stockPermission ?? true)) {
      return true;
    } else if (item == 'Reports' && (visibility?.reportsPermission ?? true)) {
      return true;
    } else if (item == 'Sales List' && (visibility?.salesListPermission ?? true)) {
      return true;
    } else if (item == 'Purchase List' && (visibility?.purchaseListPermission ?? true)) {
      return true;
    } else if (item == 'Loss/Profit' && (visibility?.lossProfitPermission ?? true)) {
      return true;
    } else if (item == 'Expense' && (visibility?.addExpensePermission ?? true)) {
      return true;
    }
    return false;
  }

  List<ProductModel> _productsList = [];
  List<ProductModel> _filteredProductsList = [];

  List<ProductModel> get filteredProductsList => _filteredProductsList;

  void setProducts(List<ProductModel> products) {
    _productsList = products;
    _filteredProductsList = products; // Initialize with all products
    notifyListeners();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProductsList = _productsList;
    } else {
      _filteredProductsList = _productsList.where((product) => product.productName!.toLowerCase().contains(query.toLowerCase())).toList();

    }
    notifyListeners();
    // notifyListeners();
  }
}
