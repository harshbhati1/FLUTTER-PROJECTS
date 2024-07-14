import 'dart:io';

import 'package:chatapp1/widgets/imagePicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';


final _firebase = FirebaseAuth.instance;
class AuthScreenState extends StatefulWidget {
  const AuthScreenState({super.key});

  @override
  State<AuthScreenState> createState() => _AuthScreenStateState();
}

class _AuthScreenStateState extends State<AuthScreenState> {
  var _isLogin = true;
  final _formkey = GlobalKey<FormState>();
  var emailAddress = "";
  var password = "";
  var username = "";
  File?  selectedImage;
  var isAuthenticating = false;


  void _submit() async{
    final isValid = _formkey.currentState!.validate();

    if (!isValid || (!_isLogin && selectedImage == null)){
     return;
    }
     _formkey.currentState!.save();

     try{
      setState(() {
        isAuthenticating = true;
      });
      if (_isLogin){
      final userCredentials = await _firebase.signInWithEmailAndPassword(email: emailAddress, password: password);
      
     } 
     else{
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: emailAddress, password: password);
          final storageRef = FirebaseStorage.instance.ref().child('user_images').child('${userCredentials.user!.uid}.jpg');
          await storageRef.putFile(selectedImage!);
          final imageurl = await storageRef.getDownloadURL();
           await FirebaseFirestore.instance.collection('users').doc(userCredentials.user!.uid).set({
            'username': username,
            'email':emailAddress,
            'image_url': imageurl,
           });
          }
         
     }
     on FirebaseAuthException catch (error){
        if (error.code == 'email-already-in-use'){
          //....
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message?? "Authentication failed")));
        setState(() {
          isAuthenticating = false;
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body:  Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20
                ), width: 200,
                child: Image.asset("assets/images/chat.png"),
              ),
              Card(
                margin:  const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child:  Padding(padding: const EdgeInsets.all(16),
                  child: Form(key: _formkey,child: 
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!_isLogin)  userImagePicker(onPickImage: (File pickedImage){
                        selectedImage = pickedImage;
                      },),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email Address',),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                           validator: (value) {
                            if (value == null || value.trim().isEmpty || !value.contains('@')){
                              return "Please enter a valid email";
                            } return null;
                           }, onSaved: (value){
                            emailAddress = value!;
                           },
                      ), if (!_isLogin) TextFormField(
                        decoration: const InputDecoration(labelText: 'Username: '),
                        validator: (value){
                          if (value == null || value.isEmpty || value.trim().length<4){
                            return 'Please atleast enter 4 characters';
                          } return null;
                        },
                        onSaved: (newValue) {
                          username = newValue!;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password'
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.trim().length<6){
                            return "Password must have 6 characters";
                          } return null;
                        },
                        onSaved: (value){
                          password = value!;
                        },
                      ),
                      const SizedBox(height: 20,),
                      if (isAuthenticating)
                       const  CircularProgressIndicator(),
                       if (!isAuthenticating)
                      ElevatedButton(onPressed: (){
                        _submit();
                      },  
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ), child: Text(_isLogin? "Login":"SignUp", style: const TextStyle(color: Colors.white),),),
                      if (!isAuthenticating)
                      TextButton(onPressed: (){
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      }, child: Text(_isLogin?"Create an account":"Already have an account"))
                    ],
                  )),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}