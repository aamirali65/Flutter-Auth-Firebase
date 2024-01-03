import 'package:firebase/ui/verify_phone.dart';
import 'package:firebase/widgets/main_button.dart';
import 'package:firebase/widgets/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPhone extends StatefulWidget {
  const LoginPhone({super.key});

  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  bool loading = false;
  final number = TextEditingController();
  final formkey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: number,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone), hintText: '+92 345 6789'),
            ),
            const SizedBox(
              height: 50,
            ),
            Button(
              title: 'Login',
              onTap: () async {
                setState(() {
                  loading = true;
                });

                String phoneNumber = number.text;

                try {
                  await auth.verifyPhoneNumber(
                    phoneNumber: phoneNumber,
                    verificationCompleted: (_) {
                      setState(() {
                        loading = false;
                      });
                    },
                    verificationFailed: (e) {
                      print("Error: $e");
                      utils().toastMessage(e.toString());
                      setState(() {
                        loading = false;
                      });
                    },
                    codeSent: (String verificationId, int? token) {
                      setState(() {
                        loading = false;
                      });
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VerifyPhone(verficiationID: verificationId),
                        ),
                      );

                    },
                    codeAutoRetrievalTimeout: (e) {
                      print("Error: $e");
                      utils().toastMessage(e.toString());
                      setState(() {
                        loading = false;
                      });
                    },
                  );
                } catch (e) {
                  // Handle exceptions here
                  print("Error: $e");
                  utils().toastMessage(e.toString()); // Show the error message in your app
                  setState(() {
                    loading = false;
                  });
                }

              },
              loading: loading,
            )
          ],
        ),
      ),
    );
  }
}
