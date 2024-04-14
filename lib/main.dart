// import 'package:chat_app/screens/chat_screen.dart';
// import 'package:chat_app/screens/splash_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:chat_app/screens/auth.dart';
// import 'package:flutter/material.dart';

// final colorScheme = ColorScheme.fromSeed(
//   seedColor: Color.fromARGB(255, 0, 140, 255),
//   background: Color.fromARGB(255, 255, 255, 255),
// );

// final theme = ThemeData().copyWith(
//   useMaterial3: true,
//   scaffoldBackgroundColor: colorScheme.onPrimary,
//   colorScheme: colorScheme,
//   // textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
//   //   titleSmall: GoogleFonts.ubuntuCondensed(
//   //     fontWeight: FontWeight.bold,
//   //   ),
//   //   titleMedium: GoogleFonts.ubuntuCondensed(
//   //     fontWeight: FontWeight.bold,
//   //   ),
//   //   titleLarge: GoogleFonts.ubuntuCondensed(
//   //     fontWeight: FontWeight.bold,
//   //   ),
//   // ),
// );

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(
//     const MyApp(),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: theme,
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Chat App',
//       home: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData == ConnectionState.waiting) {
//             return const SpalshScreen();
//           }
//           if (snapshot.hasData) {
//             return const ChatScreen();
//           }
//           return const AuthScreen();
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          // Set the app's primary theme color

          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        home: PasswordGenerator());
  }
}

class PasswordGenerator extends StatefulWidget {
  @override
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  String _password = '';

  // Method for Generating Random Passwords

  void _generatePassword() {
    final random = Random();

    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNO'
        'PQRSTUVWXYZ0123456789!@#\$%^&*()_+';

    String password = '';

    for (int i = 0; i < 12; i++) {
      password += characters[

          // Generate a random password

          random.nextInt(characters.length)];
    }

    setState(() {
      // Update the displayed password
      _password = password;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Password:',
              style: TextStyle(fontSize: 18),
            ),

            Text(
              _password, // Displayed password

              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20), // Vertical spacing

            ElevatedButton(
              onPressed:
                  _generatePassword, // Call _generatePassword when button is pressed

              child: Text('Generate Password'), // Button text
            ),
          ],
        ),
      ),
    );
  }
}
