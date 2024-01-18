import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_pos/model/business_info_model.dart';

import '../Repository/API/business_info_repo.dart';

BusinessRepository businessRepository = BusinessRepository();
final businessInfoProvider = FutureProvider<BusinessInformation>((ref) => businessRepository.fetchBusinessData());
