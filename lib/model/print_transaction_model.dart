import 'package:mobile_pos/model/due_transaction_model.dart';
import 'package:mobile_pos/model/transition_model.dart';

import 'business_info_model.dart';

class PrintTransactionModel {
  PrintTransactionModel({required this.transitionModel, required this.personalInformationModel});

  BusinessInformationModel personalInformationModel;
  SaleTransactionModel? transitionModel;
}

class PrintPurchaseTransactionModel {
  PrintPurchaseTransactionModel({required this.purchaseTransitionModel, required this.personalInformationModel});

  BusinessInformationModel personalInformationModel;
  PurchaseTransitionModel? purchaseTransitionModel;
}

class PrintDueTransactionModel {
  PrintDueTransactionModel({required this.dueTransactionModel, required this.personalInformationModel});

  DueTransactionModel? dueTransactionModel;
  BusinessInformationModel personalInformationModel;
}
