import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_pos/model/currency_model.dart';

import '../Repo/currency_repo.dart';

Currency repo = Currency();
final currencyProvider = FutureProvider<List<CurrencyModel>>((ref) => repo.fetchAllCurrency());
