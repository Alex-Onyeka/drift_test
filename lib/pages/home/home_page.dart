import 'package:drifttest/auth_service/auth_service.dart';
import 'package:drifttest/db/app_database/app_database.dart';
import 'package:drifttest/functions/general_constants.dart';
import 'package:drifttest/main.dart';
import 'package:drifttest/pages/auth/base_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;
  late Future<User?> getLoggedInUserFuture;
  Future<User?> getUser() async {
    return await returnDb(
      context,
    ).usersDao.getLoggedInUser(context);
  }

  @override
  void initState() {
    super.initState();
    getLoggedInUserFuture = getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          returnNetwork(context, listen: true).isLoggedIn,
        ),
        centerTitle: true,
        toolbarHeight: 70,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 20,
            ),
            child: Row(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        // snapshot.connectionState ==
                        //         ConnectionState.waiting
                        //     ? Colors.amber
                        //     : snapshot.data!.isEmpty
                        //     ? Colors.grey
                        //     : Colors.green,
                        returnNetwork(
                          context,
                          listen: true,
                        ).color,
                  ),
                ),
                Text(
                  style: TextStyle(fontSize: 10),
                  // snapshot.connectionState ==
                  //         ConnectionState.waiting
                  //     ? 'Loading'
                  //     : snapshot.data!.isEmpty
                  //     ? 'Offline'
                  //     : 'Online',
                  returnNetwork(
                    context,
                    listen: true,
                  ).isConnected,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 30.0,
          right: 30,
          bottom: 20,
        ),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getLoggedInUserFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error.toString()}',
                      ),
                    );
                  } else {
                    var user = snapshot.data!;
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                count++;
                              });
                            },
                            onLongPress: () {
                              count--;
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 30.0,
                                    vertical: 10,
                                  ),
                              child: Text(
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                  fontSize:
                                      Fonts()
                                          .mainHeading_25,
                                ),
                                user.firstName,
                              ),
                            ),
                          ),
                          Text(
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize:
                                  Fonts().smallText_12,
                            ),
                            user.email,
                          ),
                          Text(
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize:
                                  Fonts().smallText_12,
                            ),
                            count.toString(),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () async {
                await AuthService().logOut(context);
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
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
