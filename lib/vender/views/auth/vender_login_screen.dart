// ignore_for_file: use_build_context_synchronously, unused_import

import 'package:flutter/material.dart';
import 'package:eshop/utils/show_snackbar.dart';
import 'package:eshop/vender/controllers/vender_register_controller.dart';
import 'package:eshop/vender/views/auth/vender_signup_screen.dart';
import 'package:eshop/vender/views/auth/vender_register_screen.dart';
import 'package:eshop/vender/views/screens/landing_screen.dart';

class VenderLoginScreen extends StatefulWidget {
  const VenderLoginScreen({super.key});

  @override
  State<VenderLoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<VenderLoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final VenderController _authController = VenderController();

  late String email;
  late String password;

  bool _isLoging = false;

  _loginUsers() async {
    setState(() {
      _isLoging = true;
    });


    if (_formkey.currentState!.validate()) {
    String  res = await _authController.loginUsers(email, password);
      
      if(res == 'success'){
        return Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (BuildContext context) {
        return LandingScreen(); 
      //  return const VenderRegisterScreen(); 
      }));
      }else{
        setState(() {
          _isLoging = false;
        });
        return showsnack(
          context,  res, Colors.red.shade700);
      }

    } else {
      return showsnack(
        context, 'fileds not be empty', Colors.red.shade700);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login Vender's Account",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email cannot be empty';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  email = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Enter Email Address',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password cannot be empty';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  password = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                _loginUsers();
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  Center(
                  child: _isLoging
                  ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                  : const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Need An account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const VenderSignUpScreen();
                        },
                      ),
                    );
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
