import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Services/api_exception.dart';
import '../../../../Services/dio.dart';
import '../../../../Services/dio_client.dart';
import '../Models/dashboard_model.dart';
import '../Repo/dashboard_repository.dart';

// ============================================================
// Dashboard Provider
// ============================================================

final dashboardControllerProvider = Provider<DashboardController>((ref) {
  final dioClient = ref.watch(dioProvider);

  return DashboardController(dioClient: dioClient);
});

// ============================================================
// Dashboard Controller
// ============================================================

class DashboardController {
  DashboardController({required DioClient dioClient})
    : _repository = DashboardRepository(dioClient);

  final DashboardRepository _repository;

  // ==========================================================
  // Get Dashboard
  // ==========================================================

  Future<DashboardModel> getDashboard() async {
    try {
      final result = await _repository.getDashboard();

      return result;
    } on ApiException {
      // Existing API exception ko as-is UI tak jane dein.
      // Is se statusCode, code aur validation/error details
      // preserve rehti hain.
      rethrow;
    } catch (error) {
      // Unexpected errors ko standard ApiException mein convert
      // kar rahe hain.
      throw ApiException(
        message: 'Something went wrong. Please try again.',
        code: 'UNKNOWN_ERROR',
        originalError: error,
      );
    }
  }
}
