// ignore_for_file: use_build_context_synchronously

import 'package:eshop/controller/auth_controller.dart';
import 'package:eshop/utils/show_snackbar.dart';
import 'package:eshop/views/buyers/auth/buyer_register_screen.dart';
import 'package:eshop/views/buyers/main_screen.dart';
import 'package:flutter/material.dart';

class BuyerLoginScreen extends StatefulWidget {
  const BuyerLoginScreen({super.key});

  @override
  State<BuyerLoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<BuyerLoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

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
        return const MainScreen(); 
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
              "Login Customer's Account",
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
                  ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                  : Text(
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
                          return const BuyerRegisterScreen();
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
