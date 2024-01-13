import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_pos/Screens/Purchase/Model/purchase_transaction_model.dart';
import 'package:mobile_pos/Screens/Purchase/Repo/purchase_repo.dart';
import 'package:mobile_pos/model/transition_model.dart';

import '../repository/transactions_repo.dart';

TransitionRepo transitionRepo = TransitionRepo();
final transitionProvider = FutureProvider<List<SaleTransactionModel>>((ref) => transitionRepo.getAllTransition());

// PurchaseTransitionRepo purchaseTransitionRepo = PurchaseTransitionRepo();
PurchaseRepo repo = PurchaseRepo();
final purchaseTransactionProvider = FutureProvider<List<PurchaseTransaction>>((ref) => repo.fetchPurchaseList());
