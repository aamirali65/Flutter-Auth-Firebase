import 'package:firebase/ui/post_screen.dart';
import 'package:firebase/widgets/main_button.dart';
import 'package:firebase/widgets/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyPhone extends StatefulWidget {
  final verficiationID;
  const VerifyPhone({super.key,required this.verficiationID});

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  bool loading = false;
  final number = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Verify',
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
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone), hintText: '6 digit code'),
            ),
            const SizedBox(
              height: 50,
            ),
            Button(
              title: 'Verify',
              onTap: () async {
                setState(() {
                  loading = true;
                });
                final authLogin = PhoneAuthProvider.credential(
                    verificationId: widget.verficiationID,
                    smsCode: number.text.toString()
                );
                try{
                  setState(() {
                    loading = false;
                  });
                  await auth.signInWithCredential(authLogin);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PostScreen()));
                }catch(e){
                  setState(() {
                    loading = false;
                  });
                  utils().toastMessage(e.toString());
                };
              },
              loading: loading,
            )
          ],
        ),
      ),
    );
  }
}
