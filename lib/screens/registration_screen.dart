import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? email;
  String? password;
  bool spinning = false;

  final _auth  = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(

        inAsyncCall: spinning,
        opacity: 0.3,
        color: Colors.red,
        child: Padding(
          
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText:
                    'Enter your email'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,

                textAlign: TextAlign.center,
                onChanged: (value) {
                 password = value;
                },
                decoration:  kTextFieldDecoration.copyWith(hintText:
                    'Enter your password') ,
              ),
              const SizedBox(
                height: 24.0,
              ),
             RoundedButton(label: 'register',
             colour: Colors.blueAccent,
             onPressed: ()async{
               setState(() {
                 spinning = true;
               });
               try {
                await _auth.createUserWithEmailAndPassword(
                     email: email!, password: password!);

                   Navigator.pushNamed(context, LoginScreen.id);
                   setState(() {
                     spinning = false;
                   });


               }catch(e){
    print(e);}
             }),
            ],
          ),
        ),
      ),
    );
  }
}
