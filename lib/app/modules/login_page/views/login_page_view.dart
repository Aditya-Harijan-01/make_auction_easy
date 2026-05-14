import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text.dart';
import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Text(
                'Welcome Back',
                style: AppTextStyles.heading.copyWith(fontSize: 30.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                'Sign in using your phone number, email, or Google account.',
                style: AppTextStyles.body.copyWith(height: 1.45),
              ),
              SizedBox(height: 160.h),
              _buildModeSelector(),
              SizedBox(height: 16.h),
              Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 280),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  child: controller.isEmailMode.value
                      ? _buildEmailCard()
                      : _buildPhoneCard(),
                ),
              ),
              SizedBox(height: 22.h),
              _buildDivider(),
              SizedBox(height: 18.h),
              _buildGoogleButton(),
              // SizedBox(height: 20.h),
              // Text(
              //   'Make sure Firebase Email/Password, Phone, and Google sign-in are enabled in your Firebase Console.',
              //   style: AppTextStyles.small.copyWith(height: 1.4),
              // ),
              // SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeSelector() {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          color: AppColors.secondaryBg,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildModeButton(
                label: 'Email',
                selected: controller.isEmailMode.value,
                onTap: () => controller.switchMode(true),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _buildModeButton(
                label: 'Phone OTP',
                selected: !controller.isEmailMode.value,
                onTap: () => controller.switchMode(false),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeButton({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: selected ? AppColors.primary : Colors.transparent,
        ),
        child: Text(
          label,
          style: AppTextStyles.button.copyWith(
            fontSize: 14.sp,
            color: selected ? AppColors.white : AppColors.white70,
          ),
        ),
      ),
    );
  }

  Widget _buildEmailCard() {
    return Container(
      key: const ValueKey<String>('email-form'),
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email Login', style: AppTextStyles.subHeading),
          SizedBox(height: 14.h),
          TextField(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            style: AppTextStyles.body.copyWith(color: Colors.white),
            decoration: _inputDecoration(
              label: 'Email address',
              hint: 'name@email.com',
              prefix: Icons.mail_outline_rounded,
            ),
          ),
          SizedBox(height: 12.h),
          Obx(
            () => TextField(
              controller: controller.passwordController,
              obscureText: controller.obscurePassword.value,
              style: AppTextStyles.body.copyWith(color: Colors.white),
              decoration: _inputDecoration(
                label: 'Password',
                hint: 'Enter your password',
                prefix: Icons.lock_outline_rounded,
                suffix: IconButton(
                  onPressed: controller.togglePasswordVisibility,
                  icon: Icon(
                    controller.obscurePassword.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.white70,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 18.h),
          Obx(
            () => SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: controller.isEmailLoading.value
                    ? null
                    : controller.loginWithEmailPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: AppColors.primary.withValues(
                    alpha: 0.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: controller.isEmailLoading.value
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.2,
                        ),
                      )
                    : Text('Login with Email', style: AppTextStyles.button),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneCard() {
    return Container(
      key: const ValueKey<String>('phone-form'),
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Phone OTP Login', style: AppTextStyles.subHeading),
          SizedBox(height: 14.h),
          TextField(
            controller: controller.phoneController,
            keyboardType: TextInputType.phone,
            style: AppTextStyles.body.copyWith(color: Colors.white),
            decoration: _inputDecoration(
              label: 'Phone number',
              hint: '+919876543210',
              prefix: Icons.phone_outlined,
            ),
          ),
          SizedBox(height: 12.h),
          Obx(
            () => controller.otpSent.value
                ? TextField(
                    controller: controller.otpController,
                    keyboardType: TextInputType.number,
                    style: AppTextStyles.body.copyWith(color: Colors.white),
                    decoration: _inputDecoration(
                      label: 'OTP code',
                      hint: 'Enter 6-digit code',
                      prefix: Icons.verified_user_outlined,
                    ),
                  )
                : Text(
                    'We will send a one-time password to this number.',
                    style: AppTextStyles.small,
                  ),
          ),
          SizedBox(height: 18.h),
          Obx(
            () => SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: controller.isSendingOtp.value
                    ? null
                    : controller.sendOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: AppColors.primary.withValues(
                    alpha: 0.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: controller.isSendingOtp.value
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.2,
                        ),
                      )
                    : Text(
                        controller.otpSent.value ? 'Resend OTP' : 'Send OTP',
                        style: AppTextStyles.button,
                      ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Obx(
            () => SizedBox(
              width: double.infinity,
              height: 50.h,
              child: OutlinedButton(
                onPressed:
                    controller.otpSent.value && !controller.isVerifyingOtp.value
                    ? controller.verifyOtp
                    : null,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: controller.otpSent.value
                        ? AppColors.primary
                        : AppColors.border,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: controller.isVerifyingOtp.value
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.2,
                        ),
                      )
                    : Text(
                        'Verify OTP',
                        style: AppTextStyles.button.copyWith(
                          color: controller.otpSent.value
                              ? AppColors.white
                              : AppColors.white54,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.white24)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text('or continue with', style: AppTextStyles.small),
        ),
        const Expanded(child: Divider(color: Colors.white24)),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        height: 52.h,
        child: OutlinedButton(
          onPressed: controller.isGoogleLoading.value
              ? null
              : controller.signInWithGoogle,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
          child: controller.isGoogleLoading.value
              ? SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.2,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 26.w,
                      height: 26.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'G',
                        style: TextStyle(
                          color: Colors.red.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Login with Google',
                      style: AppTextStyles.button.copyWith(color: Colors.white),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData prefix,
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.05),
      labelStyle: AppTextStyles.small,
      hintStyle: AppTextStyles.small.copyWith(color: AppColors.white54),
      prefixIcon: Icon(prefix, color: AppColors.white70, size: 20.sp),
      suffixIcon: suffix,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14.r)),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: AppColors.secondaryBg,
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(color: AppColors.border),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.22),
          blurRadius: 14,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }
}
