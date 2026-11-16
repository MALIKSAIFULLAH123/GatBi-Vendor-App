import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Routes/app_route.dart';
import 'Features/Push Notification/Services/firebase_messaging_service.dart';
import 'Services/device_registration_helper.dart';
import 'Services/dio.dart';
import 'Services/token_storage.dart';
import 'Theme/app_theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ============================================================
  // FIREBASE INITIALIZATION
  // ============================================================

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ============================================================
  // FCM BACKGROUND HANDLER
  // ============================================================

  FirebaseMessaging.onBackgroundMessage(
    FirebaseMessagingService.firebaseMessagingBackgroundHandler,
  );

  // ============================================================
  // FCM INITIALIZATION
  // ============================================================

  await FirebaseMessagingService.instance.initialize();

  // ============================================================
  // RIVERPOD CONTAINER
  // ============================================================

  final container = ProviderContainer();

  // ============================================================
  // FCM TOKEN REFRESH -> BACKEND
  // ============================================================

  FirebaseMessagingService.instance.onTokenRefresh = (_) async {
    if (!await SecureStorageService.instance.hasToken()) {
      return;
    }

    await DeviceRegistrationHelper.registerDevice(
      dioClient: container.read(dioProvider),
    );
  };

  // ============================================================
  // RUN APP
  // ============================================================

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Vendor Hub',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
