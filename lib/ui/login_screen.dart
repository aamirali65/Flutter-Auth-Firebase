import 'package:firebase/ui/phone_login.dart';
import 'package:firebase/ui/post_screen.dart';
import 'package:firebase/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase/ui/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/widgets/message.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  bool _obscureText = true;
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void login(){
    if (formkey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text.toString())
          .then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const PostScreen()));
        setState(() {
          loading = false;
        });
      })
          .onError((error, stackTrace) {
            utils().toastMessage(error.toString());
        setState(() {
          loading = false;
        });
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: 'Email', prefixIcon: Icon(Icons.email)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(onPressed: (){
                            setState(() {
                                _obscureText = !_obscureText;
                            });

                        }, icon: _obscureText==true ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)),
                        prefixIcon: const Icon(Icons.lock)
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Password';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
            Button(
              title: 'Login',
              loading: loading,
              onTap: () {
              login();
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ));
                    },
                    child: const Text('Sign Up'))
              ],
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>LoginPhone()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: const Text('Login with Phone Number'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.black
                  )
                )
                ),
            ),
          ],
        ),
      ),
    );
  }
}
