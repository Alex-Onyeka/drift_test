import 'package:drifttest/auth_service/auth_service.dart';
import 'package:drifttest/components/main_button.dart';
import 'package:drifttest/functions/general_constants.dart';
import 'package:drifttest/pages/auth/base_page.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  final Function()? switchPage;
  const CreateAccount({
    super.key,
    required this.switchPage,
  });

  @override
  State<CreateAccount> createState() => _LoginPageState();
}

class _LoginPageState extends State<CreateAccount> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController confirmPasswordC =
      TextEditingController();
  TextEditingController firstNameC =
      TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  bool passwordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    style: TextStyle(
                      fontSize: Fonts().mainHeading_25,
                      fontWeight: FontWeight.bold,
                    ),
                    'Create Your User Account',
                  ),
                ],
              ),
              SizedBox(height: 15),
              Form(
                key: _formKey,
                autovalidateMode:
                    AutovalidateMode.onUnfocus,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                  ),
                  child: Column(
                    spacing: 10,
                    children: [
                      Row(
                        spacing: 7,
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty) {
                                  return 'Name field cannot be empty!';
                                } else {
                                  return null;
                                }
                              },
                              controller: firstNameC,
                              keyboardType:
                                  TextInputType.name,
                              textCapitalization:
                                  TextCapitalization.words,
                              autocorrect: true,
                              autovalidateMode:
                                  AutovalidateMode
                                      .onUnfocus,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(
                                      10,
                                      7,
                                      10,
                                      7,
                                    ),
                                hintText: 'First Name *',
                                hintStyle: TextStyle(
                                  fontSize:
                                      Fonts().smallText_12,
                                ),
                                border:
                                    OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              textCapitalization:
                                  TextCapitalization.words,
                              controller: lastNameC,
                              keyboardType:
                                  TextInputType.name,
                              autocorrect: true,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(
                                      10,
                                      7,
                                      10,
                                      7,
                                    ),
                                hintText:
                                    'Last Name (Optional)',
                                hintStyle: TextStyle(
                                  fontSize:
                                      Fonts().smallText_12,
                                ),
                                border:
                                    OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Email field cannot be empty!';
                          } else if (!value.contains('@')) {
                            return 'Please Enter a valid Email';
                          } else {
                            return null;
                          }
                        },
                        controller: emailC,
                        keyboardType:
                            TextInputType.emailAddress,
                        autocorrect: true,
                        autovalidateMode:
                            AutovalidateMode.onUnfocus,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(
                                10,
                                7,
                                10,
                                7,
                              ),
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(
                            fontSize: Fonts().smallText_12,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: Row(
                          spacing: 7,
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty) {
                                    return 'Email field cannot be empty!';
                                  } else if (value.length <
                                      6) {
                                    return 'Password must be Longer than 6 Characters';
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: passwordHidden,
                                obscuringCharacter: '*',
                                controller: passwordC,
                                keyboardType:
                                    TextInputType
                                        .visiblePassword,
                                autocorrect: false,
                                enableSuggestions: false,
                                autovalidateMode:
                                    AutovalidateMode
                                        .onUnfocus,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(
                                        10,
                                        7,
                                        10,
                                        7,
                                      ),
                                  hintText:
                                      'Enter Password',
                                  hintStyle: TextStyle(
                                    fontSize:
                                        Fonts()
                                            .smallText_12,
                                  ),
                                  border:
                                      OutlineInputBorder(),
                                ),
                              ),
                            ),
                            InkWell(
                              borderRadius:
                                  BorderRadius.circular(20),
                              onTap: () {
                                setState(() {
                                  passwordHidden =
                                      !passwordHidden;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  size: 18,
                                  color: Colors.grey,
                                  passwordHidden
                                      ? Icons.visibility
                                      : Icons
                                          .visibility_off_rounded,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: Row(
                          spacing: 7,
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty) {
                                    return 'Password field cannot be empty!';
                                  } else if (value.length <
                                      6) {
                                    return 'Password must be Longer than 6 Characters';
                                  } else if (value !=
                                      passwordC.text) {
                                    return 'Password fields must be The same.';
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: passwordHidden,
                                obscuringCharacter: '*',
                                controller:
                                    confirmPasswordC,
                                keyboardType:
                                    TextInputType
                                        .visiblePassword,
                                autocorrect: false,
                                enableSuggestions: false,
                                autovalidateMode:
                                    AutovalidateMode
                                        .onUnfocus,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(
                                        10,
                                        7,
                                        10,
                                        7,
                                      ),
                                  hintText:
                                      'Enter Confirm Password',
                                  hintStyle: TextStyle(
                                    fontSize:
                                        Fonts()
                                            .smallText_12,
                                  ),
                                  border:
                                      OutlineInputBorder(),
                                ),
                              ),
                            ),
                            InkWell(
                              borderRadius:
                                  BorderRadius.circular(20),
                              onTap: () {
                                setState(() {
                                  passwordHidden =
                                      !passwordHidden;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  size: 18,
                                  color: Colors.grey,
                                  passwordHidden
                                      ? Icons.visibility
                                      : Icons
                                          .visibility_off_rounded,
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
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                child: MainButton(
                  formKey: _formKey,
                  text: 'Create Account',
                  action: () async {
                    var res = await AuthService().signUp(
                      context: context,
                      email: emailC.text,
                      password: passwordC.text,
                      firstName: firstNameC.text,
                      secondName: lastNameC.text,
                    );

                    if (context.mounted) {
                      if (res == false) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              content: Column(
                                mainAxisSize:
                                    MainAxisSize.min,
                                children: [
                                  Text(
                                    style: TextStyle(
                                      fontSize:
                                          Fonts()
                                              .mainTitle_18,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                    'An Error Occured',
                                  ),
                                  Divider(),
                                  Text(
                                    style: TextStyle(
                                      fontSize:
                                          Fonts()
                                              .smallText_12,
                                      fontWeight:
                                          FontWeight.normal,
                                    ),
                                    'An error occured while creating your user account. Please check your internet, and try again.',
                                  ),
                                  SizedBox(height: 20),
                                  MainButton(
                                    text: 'Close',
                                    action: () {
                                      Navigator.of(
                                        context,
                                      ).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return BasePage();
                              },
                            ),
                            (route) => false,
                          );
                        }
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: widget.switchPage,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Already have an account? Login',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
