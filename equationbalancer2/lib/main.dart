import 'package:equationbalancer2/firebase_options.dart';
import 'package:equationbalancer2/splash.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("6f347465-a778-4451-a949-e08aa56216ee");
  OneSignal.Notifications.requestPermission(true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();
    logAppStartEvent(); // Log the app start event when the app initializes
  }

  Future<void> logAppStartEvent() async {
    await analytics.logEvent(
      name: 'app_start',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chemical Equation Balancer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF5ECA29),
          selectionHandleColor: Color(0xFF5ECA29),
          selectionColor: Color(0xFF5ECA29),
        ),
        primarySwatch: const MaterialColor(
          0xFF5ECA29,
          <int, Color>{
            50: Color(0xFF5ECA29),
            100: Color(0xFF5ECA29),
            200: Color(0xFF5ECA29),
            300: Color(0xFF5ECA29),
            400: Color(0xFF5ECA29),
            500: Color(0xFF5ECA29),
            600: Color(0xFF5ECA29),
            700: Color(0xFF5ECA29),
            800: Color(0xFF5ECA29),
            900: Color(0xFF5ECA29),
          },
        ),
        primaryColor: const Color(0xFF5ECA29),
      ),
      home: const SplashScreen(),
    );
  }
}
