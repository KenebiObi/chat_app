import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:chat_app/screens/auth.dart';
import 'package:flutter/material.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 0, 140, 255),
  background: Color.fromARGB(255, 255, 255, 255),
);

final theme = ThemeData().copyWith(
  useMaterial3: true,
  scaffoldBackgroundColor: colorScheme.onPrimary,
  colorScheme: colorScheme,
  // textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
  //   titleSmall: GoogleFonts.ubuntuCondensed(
  //     fontWeight: FontWeight.bold,
  //   ),
  //   titleMedium: GoogleFonts.ubuntuCondensed(
  //     fontWeight: FontWeight.bold,
  //   ),
  //   titleLarge: GoogleFonts.ubuntuCondensed(
  //     fontWeight: FontWeight.bold,
  //   ),
  // ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat App',
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData == ConnectionState.waiting) {
            return const SpalshScreen();
          }
          if (snapshot.hasData) {
            return const ChatScreen();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}
