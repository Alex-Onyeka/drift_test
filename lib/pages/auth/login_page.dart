import 'package:drifttest/auth_service/auth_service.dart';
import 'package:drifttest/components/main_button.dart';
import 'package:drifttest/functions/general_constants.dart';
import 'package:drifttest/main.dart';
import 'package:drifttest/pages/auth/base_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? switchPage;
  const LoginPage({super.key, required this.switchPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool passwordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text(
                      style: TextStyle(
                        fontSize: Fonts().mainHeading_25,
                        fontWeight: FontWeight.bold,
                      ),
                      'Login to your Account',
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Form(
                  key: _formKey,
                  autovalidateMode:
                      AutovalidateMode.onUnfocus,
                  child: Column(
                    spacing: 10,
                    children: [
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
                                    return 'Password field cannot be empty!';
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
                    ],
                  ),
                ),
                SizedBox(height: 15),
                MainButton(
                  formKey: _formKey,
                  action: () async {
                    var res = await AuthService().login(
                      context: context,
                      email: emailC.text,
                      password: passwordC.text,
                    );
                    if (res != false && context.mounted) {
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
                    } else {
                      if (context.mounted) {
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
                                    'Logging Failed.',
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
                                    'Check your email an password and try again. Or try putting on your data and logging in again.',
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
                      }
                    }
                  },
                  text: 'Login',
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: widget.switchPage,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            'Don\'t have an account? SignUp',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  height: 200,
                  child: FutureBuilder(
                    future:
                        returnDb(
                          context,
                        ).usersDao.getUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.done) {
                        var users = snapshot.data;
                        return ListView.builder(
                          itemCount: users?.length,
                          itemBuilder: (context, index) {
                            var user = users?[index];
                            return ListTile(
                              onTap: () {
                                returnDb(
                                  context,
                                ).usersDao.deleteAllUsers();
                                setState(() {});
                              },
                              title: Text(user!.firstName),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child:
                              CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                // Row(
                //   mainAxisAlignment:
                //       MainAxisAlignment.center,
                //   children: [
                //     InkWell(
                //       onTap: widget.action,
                //       child: Container(
                //         padding: EdgeInsets.all(10),
                //         child: Center(child: Text('Login')),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
