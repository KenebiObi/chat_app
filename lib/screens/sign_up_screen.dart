import 'dart:io';

import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/widgets/image_picker_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // For validatin guser input
  final _form = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';
  File? _selectedImage;
  var _isAuthenticating = false;
  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid || _selectedImage == null) {
      return;
    } else {
      _form.currentState!.save();
      print(_enteredEmail);
      print(_enteredPassword);
    }
    try {
      setState(() {
        _isAuthenticating = true;
      });
      final userCredentials = await _firebase.createUserWithEmailAndPassword(
        email: _enteredEmail,
        password: _enteredPassword,
      );
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${userCredentials.user!.uid}.jpg');
      await storageRef.putFile(_selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();
      print(imageUrl);
      print(userCredentials);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.message ?? "Authentication Failed",
          ),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const Spacer(),
            Form(
              key: _form,
              child: Column(
                children: [
                  UserImagePicker(
                    onPickImage: (pickedImage) => _selectedImage = pickedImage,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          !value.contains("@")) {
                        return ("Please enter a valid email address");
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      label: const Text("Email Address"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onSaved: (newValue) {
                      _enteredEmail = newValue!;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.trim().length < 6) {
                        return ("Password must be at least 6 characters long.");
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      label: const Text("Password"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onSaved: (newValue) {
                      _enteredPassword = newValue!;
                    },
                  ),
                  const SizedBox(height: 50.0),
                  // if (!_isAuthenticating) const CircularProgressIndicator(),
                  // if (!_isAuthenticating)
                  !_isAuthenticating
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            minimumSize: const Size(double.infinity, 50.0),
                          ),
                          onPressed: () {
                            _submit;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text("Sign Up"),
                        )
                      : const CircularProgressIndicator(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an accound?"),
                      !_isAuthenticating
                          ? TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text("Login"),
                            )
                          : const CircularProgressIndicator(),
                    ],
                  ),
                  SizedBox(height: (deviceHeight / 4) - 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// https://discord.gg/vaECD6Uw43
