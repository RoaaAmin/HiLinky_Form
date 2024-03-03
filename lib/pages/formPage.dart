import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hilinky_demo/pages/thankPage.dart';
import 'package:sizer/sizer.dart';
import 'package:animate_do/animate_do.dart';

import '../models/SnackBar.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController companyController = TextEditingController();

  var focusNodeEmail = FocusNode();
  var focusNodePassword = FocusNode();
  var focusNodeName = FocusNode();
  var focusNodeCompany = FocusNode();
  bool isFocusedEmail = false;
  bool isFocusedPassword = false;
  bool isFocusedName = false;
  bool isFocusedCompany = false;


  int? _genderRadioBtnVal = 0; // For selecting between individuals and companies

  @override
  void initState() {
    focusNodeName.addListener(() {
      setState(() {
        isFocusedName = focusNodeName.hasFocus;
      });
    });
    focusNodeEmail.addListener(() {
      setState(() {
        isFocusedEmail = focusNodeEmail.hasFocus;
      });
    });
    focusNodePassword.addListener(() {
      setState(() {
        isFocusedPassword = focusNodePassword.hasFocus;
      });
    });
    focusNodeCompany.addListener(() {
      setState(() {
        isFocusedCompany = focusNodeCompany.hasFocus;
      });
    });
    super.initState();
  }

  void _handleGenderChange(int? value) {
    setState(() {
      _genderRadioBtnVal = value;
    });
  }

  void submitData(BuildContext context) async {
    try {
      String name = nameController.text;
      String email = emailController.text;
      String phoneNumber = phoneNumberController.text;
      String companyName = companyController.text;

      print('Name: $name');
      print('Email: $email');
      print('Phone Number: $phoneNumber');

      FirebaseFirestore firestore = FirebaseFirestore.instance;

      if (name.isNotEmpty && email.isNotEmpty && phoneNumber.isNotEmpty) {
        if (_genderRadioBtnVal == 0) {
          // Individual selected
          await firestore.collection('individuals').add({
            'name': name,
            'email': email,
            'phoneNumber': phoneNumber,
            'submitDateTime': DateTime.now(),
          });
        } else if (name.isNotEmpty && email.isNotEmpty && phoneNumber.isNotEmpty && companyName.isNotEmpty) {
          // Companies selected
          await firestore.collection('companies').add({
            'name': name,
            'email': email,
            'phoneNumber': phoneNumber,
            'companyName': companyName,
            'submitDateTime': DateTime.now(),
          });
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ThankPage()),
        );
        nameController.clear();
        emailController.clear();
        phoneNumberController.clear();
        companyController.clear();
      }

      else {
        showInSnackBar('You have to fill all the fields ', Color(0xFFEF9453) , Colors.white, 3, context, _scaffoldKey);
      }
    } catch (e) {
      print('Error submitting data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                height: 100.h,
                decoration: BoxDecoration(color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInDown(
                            delay: const Duration(milliseconds: 800),
                            duration: const Duration(milliseconds: 900),
                            child: Text(
                              'Fill in your details: ',
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 88,
                    ),
                    // Toggle Animation
                    FadeInDown(
                      delay: const Duration(milliseconds: 700),
                      duration: const Duration(milliseconds: 800),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => _handleGenderChange(0),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: _genderRadioBtnVal == 0 ? Color(0xFFEF9453) : Colors.grey[300], // Change background color here
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Individuals',
                                style: TextStyle(
                                  color: _genderRadioBtnVal == 0 ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _handleGenderChange(1),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: _genderRadioBtnVal == 1 ?Color(0xFFEF9453) : Colors.grey[300], // Change background color here
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Companies',
                                style: TextStyle(
                                  color: _genderRadioBtnVal == 1 ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    FadeInDown(
                      delay: const Duration(milliseconds: 700),
                      duration: const Duration(milliseconds: 800),
                      child: Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    FadeInDown(
                      delay: const Duration(milliseconds: 600),
                      duration: const Duration(milliseconds: 700),
                      child: _buildTextField(
                        controller: nameController,
                        hintText: 'Your Name',
                        focusNode: focusNodeName,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    FadeInDown(
                      delay: const Duration(milliseconds: 700),
                      duration: const Duration(milliseconds: 800),
                      child: Visibility(
                        visible: _genderRadioBtnVal == 1, // Only visible when companies are selected
                        child: Text(
                          'Company',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    FadeInDown(
                      delay: const Duration(milliseconds: 600),
                      duration: const Duration(milliseconds: 700),
                      child: _buildTextField(
                        controller: companyController,
                        hintText: 'Your Company Name',
                        focusNode: focusNodeCompany,
                        isVisible: _genderRadioBtnVal == 1,
                      ),
                    ),
                    FadeInDown(
                      delay: const Duration(milliseconds: 700),
                      duration: const Duration(milliseconds: 800),
                      child: const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    FadeInDown(
                      delay: const Duration(milliseconds: 600),
                      duration: const Duration(milliseconds: 700),
                      child: _buildTextField(
                        controller: emailController,
                        hintText: 'Your Email',
                        keyboardType: TextInputType.emailAddress,
                        focusNode: focusNodeEmail,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    FadeInDown(
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(milliseconds: 600),
                      child: const Text(
                        'Phone Number',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    FadeInDown(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 500),
                      child: _buildTextField(
                        controller: phoneNumberController,
                        hintText: 'Your Phone Number',
                        focusNode: focusNodePassword,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.black,
                      ),
                    ),

                    SizedBox( height: 9.h,),
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      duration: const Duration(milliseconds: 700),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => submitData(context),
                              child: FadeInUp(
                                delay: const Duration(milliseconds: 700),
                                duration: const Duration(milliseconds: 800),
                                child: Text('Submit'),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Satoshi',
                                ),
                                backgroundColor: Color(0xFF234E5C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          ),

                        ],
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required FocusNode focusNode,
    TextInputType keyboardType = TextInputType.text,
    TextStyle? style,
    Color? cursorColor,
    bool isVisible = true, // Default to true
  }) {
    return Visibility(
      visible: isVisible,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.8.h),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: .3.h),
        decoration: BoxDecoration(
          color: focusNode.hasFocus ? Colors.white : Color(0xFFF1F0F5),
          border: Border.all(width: 1, color: Color(0xFFD2D2D4)),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (focusNode.hasFocus)
              BoxShadow(
                color: Color(0xFFEF9453).withOpacity(.3),
                blurRadius: 4.0,
                spreadRadius: 2.0,
              ),
          ],
        ),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: style,
          cursorColor: cursorColor,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
          focusNode: focusNode,
        ),
      ),
    );
  }

}

