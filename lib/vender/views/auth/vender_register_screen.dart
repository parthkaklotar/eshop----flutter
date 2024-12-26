// ignore_for_file: unused_field, unnecessary_import, non_constant_identifier_names, prefer_final_fields, avoid_types_as_parameter_names

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eshop/vender/controllers/vender_register_controller.dart';
import 'package:eshop/vender/views/auth/vender_login_screen.dart';

class VenderRegisterScreen extends StatefulWidget {
  const VenderRegisterScreen({super.key});

  @override
  State<VenderRegisterScreen> createState() => _VenderRegisterScreenState();
}

class _VenderRegisterScreenState extends State<VenderRegisterScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final VenderController _venderController = VenderController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String businessName;
  late String email;
  late String phoneNumber;
  late String countryValue;
  late String stateValue;
  late String cityValue;
  late String taxStatus;
 String? taxNumber = '';

  Uint8List? _image;

  selectGalleryImage() async {
    Uint8List im = await _venderController.pickStoreImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  selectCameraImage() async {
    Uint8List im = await _venderController.pickStoreImage(ImageSource.camera);

    setState(() {
      _image = im;
    });
  }

  String? _texStatus;
  List<String> _taxOptions = ['Yes', 'No'];

  _saveVenderDetail() async {
    EasyLoading.show(status: 'Please Wait');

    if(_texStatus == 'No'){
      taxNumber = '';
    }

    if (_formkey.currentState!.validate()) {
      await _venderController.registervender(
        businessName,
        email,
        phoneNumber,
        countryValue,
        stateValue,
        cityValue,
        _texStatus!,
        taxNumber!,
        _image,
      ).whenComplete((){
        EasyLoading.dismiss();

        setState(() {
          
          _formkey.currentState!.reset();
          _image = null;
           Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (BuildContext context) {
        return VenderLoginScreen(); 
      }));
        });
      });
      print('done');
    } else {
      print('Bad');
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 200,
            flexibleSpace: LayoutBuilder(builder: (context, Constraints) {
              return FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade900,
                        Colors.blue,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: _image != null
                                    ? Image.memory(
                                        _image!,
                                        fit: BoxFit.cover,
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          selectGalleryImage();
                                        },
                                        icon: const Icon(CupertinoIcons.photo),
                                      ),
                              ),
                              Expanded(
                                child: _image != null
                                    ? Image.memory(
                                        _image!,
                                        fit: BoxFit.cover,
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          selectCameraImage();
                                        },
                                        icon: const Icon(CupertinoIcons.camera),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        businessName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Business Name Cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Business Name',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email Name Cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'phone Name Cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectState(
                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            stateValue = value;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            cityValue = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Text Registered',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Container(
                              width: 150,
                              child: DropdownButtonFormField(
                                hint: const Text('select'),
                                items:
                                    _taxOptions.map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _texStatus = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_texStatus == 'Yes')
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            taxNumber = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Tax Number Cannot be empty';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Tax Number',
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        _saveVenderDetail();
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
