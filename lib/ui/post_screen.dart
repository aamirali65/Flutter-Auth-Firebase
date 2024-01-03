import 'package:firebase/ui/login_screen.dart';
import 'package:firebase/widgets/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepPurple,
          title: Text('Dashboard',style: TextStyle(color: Colors.white),),
          actions: [
            IconButton(onPressed: (){
              auth.signOut()
                  .then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context)=>LoginScreen()));
              })
                  .onError((error, stackTrace) {
                utils().toastMessage(error.toString());
              });
            }, icon: Icon(Icons.login,color: Colors.white,)),
            SizedBox(width: 10,)
          ],
        ),
      ),
    );
  }
}
