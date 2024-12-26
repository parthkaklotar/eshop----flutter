
// ignore_for_file: duplicate_import

import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:eshop/utils/show_snackbar.dart';
import 'package:eshop/vender/controllers/vender_register_controller.dart';
import 'package:eshop/vender/views/auth/vender_login_screen.dart';

class VenderSignUpScreen extends StatefulWidget {
  const VenderSignUpScreen({super.key});

  @override
  State<VenderSignUpScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<VenderSignUpScreen> {
  final VenderController _authController = VenderController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  
  

  late String email;
  late String fullName;
  late String phoneNumber;
  late String password;

  bool _isLoading = false;
 Uint8List? _image;

  _signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    if (_formkey.currentState!.validate()) {
      await _authController
          .signUpUsers(
        email,
        fullName,
        phoneNumber,
        password,
        _image,
      )
          .whenComplete(() {
        setState(() {
          _formkey.currentState!.reset();
          _image = null;
          _isLoading = false;
          Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (BuildContext context) {
        return VenderSignUpScreen(); 
      }));
        });
      });

      return showsnack(
        context,
        'Vender is Registred Successfully!',
        Colors.green.shade700,
      );
    } else {
      _isLoading = false;
      return showsnack(
        context,
        'All Fields Must Be Required!',
        Colors.red.shade700,
      );
    }
  }

  

  selectGalleyImage() async{
    Uint8List _im = await _authController.pickprofileimage(ImageSource.gallery);

    setState(() {
      _image = _im;
    });
  }

  selectCameraImage() async{
    Uint8List _im = await _authController.pickprofileimage(ImageSource.camera);

    setState(() {
      _image = _im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Create Vender's Account",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    _image !=null
                  ? CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.blue,
                    backgroundImage: MemoryImage(_image!)
                  )
                  :CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.blue,
                    backgroundImage: NetworkImage('data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJQAmwMBIgACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAABAUBAgMGB//EADIQAQACAQIDBQcCBwEAAAAAAAABAgMEEQUhMRITQWFxIjJRUqHB0SNiNEJygZKx8RT/xAAUAQEAAAAAAAAAAAAAAAAAAAAA/8QAFBEBAAAAAAAAAAAAAAAAAAAAAP/aAAwDAQACEQMRAD8A+qgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAImr4hi009mN75I61ienrLlxTW9zHc4p/UmPan5Y/KmjzBLy8R1OTpk7EfscJzZpnec2X/OXMB3x6zU459nPknytO6dpuLRO1dTWI/fX7wqiQeoraL1i1ZiYnpMeLKg0GstpbxFt5xTPOPh5r+JiYiYneJ6SAAAAAAAAAAA0zZIxYr5LdKxu3QuMX7Oj2+a0R9wUl7TkyWved7WneZYAAAAABccGzzfFfDaeeP3fSVOmcJt2dbWPmiYBegAAAAA1pbfr1bODet/CQdAidwBA41Ezpa+V4/wBSnuOtxd9pclI97bevqDzkdAAAAAAErhcTOux7eG8/RFWfBMXtZM3hHsx69Z+wLYAAGLWiOnOQZ3jZp3nwhpad5YAABmJmOjeL79XMB33iRwjePFvF5BU8U0ndZJzUj9O08/KUB6W1qXrNb13ieUqfW6OuGZviyV7HyWttMfkEIYi0SzuAG7pp8Xf37MXpX4za23/QYw4r58tceON7WeiwYa4MVcVelfq5aPBh0uPantWn3rfF2nJ8IBuxNohym0ywDe15nwaAAAAAADFrRWs2tO0RzmZ8AbIWp4jjxTNcft3jwjpH90LXa+2bemGZrj+PjZCBIza3UZveyTET/LXlCPPPqAAAAAN8ebLin9PJavpKfg4pMbV1Fd4+asfZWgPSY8lMtIvjtFqz0mGzz2nz5NPft459Y8J9V3pdRTU4+1TlMe9XfnAOwAAAAACo4nq+8t3OOf06zzmPGfwn8Qz/APn08zWdr25VUIAAAAAAAAAADpgzXwZa3pPTw+Pk5gPR4Mtc+KuSnSfo3VHCc/YyzhtPs35x6rcAAAAFNxbJ29TFPDHH1nn+EJ01Fu3qMtp6zaXMAAAAAAAAAAAAGazNbVtXrWd4ejx3jJjreOlo3ebXnDLdrR08t4BKAAAB5q3O0zPWZlgAAAAAAAAAAAAAFzwj+En+uQBNAB//2Q==')
                  ),
                  Positioned(
                    right:45,
                    top: 45,
                    child: IconButton(
                      onPressed: () {
                        selectGalleyImage();
                       // selectCameraImage();
                      },
                      icon:  Icon(
                        _image == null
                        ?CupertinoIcons.photo
                        : null,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ]),
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
                      labelText: 'Enter Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'FullName cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      fullName = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter Full Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Mobile Number cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter Mobile Number',
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
                GestureDetector(
                  onTap: () {
                    _signUpUser();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Register',
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
                    const Text('Already Have An account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const VenderLoginScreen();
                            },
                          ),
                        );
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
