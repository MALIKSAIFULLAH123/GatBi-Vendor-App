import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../Theme/app_colors.dart';
import '../../../../Theme/app_text_styles.dart';
import '../../../Routes/app_route.dart';

class NotificationsHeader extends StatelessWidget {
  const NotificationsHeader({super.key, this.onBack, this.onSettings});

  final VoidCallback? onBack;
  final VoidCallback? onSettings;

  // ============================================================
  // Back
  // ============================================================

  void _handleBack(BuildContext context) {
    if (onBack != null) {
      onBack!.call();
      return;
    }

    context.pop();
  }

  // ============================================================
  // Settings
  // ============================================================

  void _handleSettings(BuildContext context) {
    if (onSettings != null) {
      onSettings!.call();
      return;
    }
    context.push(AppRoutes.notificationSettings);
  }

  // ============================================================
  // Build
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildBackButton(context),

        const SizedBox(width: 12),

        Expanded(child: _buildTitle()),

        const SizedBox(width: 12),

        _buildSettingsButton(context),
      ],
    );
  }

  // ============================================================
  // Back Button
  // ============================================================

  Widget _buildBackButton(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => _handleBack(context),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.arrow_back_rounded,
            size: 22,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Settings Button
  // ============================================================

  Widget _buildSettingsButton(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => _handleSettings(context),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.settings_outlined,
            size: 22,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Title
  // ============================================================

  Widget _buildTitle() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notifications',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          'Stay updated with your latest activity',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
