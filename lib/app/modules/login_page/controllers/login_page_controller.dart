import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../routes/app_pages.dart';

class LoginPageController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static Future<void>? _googleSignInInitFuture;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  final RxBool isEmailMode = true.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool isEmailLoading = false.obs;
  final RxBool isGoogleLoading = false.obs;
  final RxBool isSendingOtp = false.obs;
  final RxBool isVerifyingOtp = false.obs;
  final RxBool otpSent = false.obs;
  final RxString verificationId = ''.obs;

  int? _forceResendToken;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    otpController.dispose();
    super.onClose();
  }

  void switchMode(bool emailMode) {
    isEmailMode.value = emailMode;
    if (emailMode) {
      _resetOtpState();
    }
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> loginWithEmailPassword() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // _showError('Missing details', 'Enter email and password.');
      // return;
      Get.offAllNamed(Routes.HOME);
    }

    isEmailLoading.value = true;
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _onAuthSuccess(credential.user, 'Logged in successfully.');
    } on FirebaseAuthException catch (error) {
      _showError('Login failed', _firebaseErrorMessage(error));
    } catch (_) {
      _showError('Login failed', 'Something went wrong. Please try again.');
    } finally {
      isEmailLoading.value = false;
    }
  }

  Future<void> sendOtp() async {
    if (kIsWeb) {
      _showError(
        'Unsupported on web',
        'Phone OTP flow in this screen is configured for Android/iOS.',
      );
      return;
    }

    final String? phone = _normalizePhone(phoneController.text.trim());
    if (phone == null) {
      _showError(
        'Invalid number',
        'Enter a valid number with country code, for example +919876543210.',
      );
      return;
    }

    isSendingOtp.value = true;
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        forceResendingToken: _forceResendToken,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _signInWithCredential(
            credential,
            successMessage: 'Phone number verified.',
          );
        },
        verificationFailed: (FirebaseAuthException error) {
          _showError('OTP failed', _firebaseErrorMessage(error));
        },
        codeSent: (String newVerificationId, int? newForceResendToken) {
          verificationId.value = newVerificationId;
          _forceResendToken = newForceResendToken;
          otpSent.value = true;
          _showSuccess('OTP sent', 'Enter the code sent to your number.');
        },
        codeAutoRetrievalTimeout: (String newVerificationId) {
          verificationId.value = newVerificationId;
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (_) {
      _showError('OTP failed', 'Could not send OTP. Try again.');
    } finally {
      isSendingOtp.value = false;
    }
  }

  Future<void> verifyOtp() async {
    if (verificationId.value.isEmpty || otpController.text.trim().isEmpty) {
      _showError('Missing code', 'Enter the OTP received on your phone.');
      return;
    }

    isVerifyingOtp.value = true;
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otpController.text.trim(),
      );
      await _signInWithCredential(
        credential,
        successMessage: 'Logged in with phone number.',
      );
    } on FirebaseAuthException catch (error) {
      _showError('Verification failed', _firebaseErrorMessage(error));
    } catch (_) {
      _showError('Verification failed', 'Please check OTP and try again.');
    } finally {
      isVerifyingOtp.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    isGoogleLoading.value = true;
    try {
      if (kIsWeb) {
        final GoogleAuthProvider provider = GoogleAuthProvider();
        final UserCredential credential = await _auth.signInWithPopup(provider);
        await _onAuthSuccess(credential.user, 'Logged in with Google.');
        return;
      }

      await _ensureGoogleInitialized();
      if (!_googleSignIn.supportsAuthenticate()) {
        _showError(
          'Google login unavailable',
          'This platform requires a native Google sign-in button.',
        );
        return;
      }

      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      if (googleAuth.idToken == null) {
        _showError(
          'Google login failed',
          'Google did not return an ID token for authentication.',
        );
        return;
      }

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      await _signInWithCredential(
        credential,
        successMessage: 'Logged in with Google.',
      );
    } on GoogleSignInException catch (_) {
      _showError('Google login canceled', 'Sign-in was canceled by the user.');
    } on FirebaseAuthException catch (error) {
      _showError('Google login failed', _firebaseErrorMessage(error));
    } catch (_) {
      _showError('Google login failed', 'Could not complete Google sign-in.');
    } finally {
      isGoogleLoading.value = false;
    }
  }

  Future<void> _ensureGoogleInitialized() {
    _googleSignInInitFuture ??= _googleSignIn.initialize();
    return _googleSignInInitFuture!;
  }

  Future<void> _signInWithCredential(
    AuthCredential credential, {
    required String successMessage,
  }) async {
    final UserCredential userCredential = await _auth.signInWithCredential(
      credential,
    );
    await _onAuthSuccess(userCredential.user, successMessage);
  }

  Future<void> _onAuthSuccess(User? user, String message) async {
    if (user == null) {
      _showError('Login failed', 'Could not fetch user details.');
      return;
    }
    _showSuccess('Success', message);
    await Future<void>.delayed(const Duration(milliseconds: 250));
    Get.offAllNamed(Routes.HOME);
  }

  void _resetOtpState() {
    otpSent.value = false;
    verificationId.value = '';
    otpController.clear();
  }

  String? _normalizePhone(String value) {
    final String digitsAndPlus = value.replaceAll(RegExp(r'[^\d+]'), '');
    if (digitsAndPlus.isEmpty) return null;

    if (digitsAndPlus.startsWith('+')) {
      return RegExp(r'^\+\d{10,15}$').hasMatch(digitsAndPlus)
          ? digitsAndPlus
          : null;
    }

    if (RegExp(r'^\d{10,14}$').hasMatch(digitsAndPlus)) {
      return '+$digitsAndPlus';
    }

    return null;
  }

  String _firebaseErrorMessage(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return 'Invalid email address.';
      case 'invalid-credential':
        return 'Invalid credentials. Check your details.';
      case 'wrong-password':
        return 'Wrong password.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      case 'invalid-verification-code':
        return 'OTP is incorrect.';
      case 'session-expired':
        return 'OTP has expired. Request a new one.';
      case 'network-request-failed':
        return 'Network error. Check your internet connection.';
      default:
        return error.message ?? 'Authentication failed.';
    }
  }

  void _showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 3),
    );
  }

  void _showSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade700,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
    );
  }
}
