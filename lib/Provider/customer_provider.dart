import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_pos/Screens/Customers/Model/parties_model.dart';
import 'package:mobile_pos/repository/customer_repo.dart';

import '../Repository/API/parties_repo.dart';

PartyRepository partiesRepo = PartyRepository();
final partiesProvider = FutureProvider<List<Party>>((ref) => partiesRepo.fetchAllParties());
