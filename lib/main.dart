import 'package:flutter/material.dart';
import 'package:zoom_clone_flutter/resources/auth_methods.dart';
import 'package:zoom_clone_flutter/screens/home_page.dart';
import 'package:zoom_clone_flutter/screens/login_page.dart';
import 'package:zoom_clone_flutter/screens/video_call_page.dart';
import 'package:zoom_clone_flutter/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoom Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/video-call': (context) => const VideoCallPage(),
      },
      home: StreamBuilder(
        stream: AuthMethods().authChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return const HomePage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
