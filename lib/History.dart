import 'package:flutter/material.dart';
import 'package:mtidesk/Constant/color.dart';
import 'package:mtidesk/Leave_Details.dart';
import 'package:mtidesk/Leave_Details1.dart';
import 'package:mtidesk/models/history.dart';
import 'package:mtidesk/services/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Request_list extends StatefulWidget {
  Request_list({Key? key}) : super(key: key);

  @override
  State<Request_list> createState() => _Request_listState();
}

class _Request_listState extends State<Request_list> {
  late List<Historylist> users = [];
  bool isloading = true;
  @override
  void initState() {
    super.initState();
    _historylist();
  }

  _historylist() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    print("--------");
    var id = session.getInt('id');
    var email = session.getString('email');
    var token = session.getString('token');
    print("--------");
    // print(email);
    // print(student_id);

    Services.historylist().then((results) {
      setState(() {
        isloading = false;
        users = results;

        //print(users[0].gameTittle);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: violet,
          automaticallyImplyLeading: false,
          //leadingWidth: 20,
          // leading: GestureDetector(
          //   onTap: () {
          //     // Navigator.pop(context);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => Navigation()),
          //     );
          //   },
          // child: Padding(
          //   padding: const EdgeInsets.only(left: 5),
          //   child: Icon(
          //     Icons.arrow_back,
          //     color: white,
          //   ),
          // ),
          // ),
          title: Text(
            "Leave History",
            style: TextStyle(
                fontFamily: 'Poppins',
                color: white,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _historylist();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: isloading == true
                      ? CircularProgressIndicator()
                      : users.length == 0
                          ? Text("No List Found")
                          : Column(
                              children: [
                                ListView.builder(
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    // itemCount: 4,
                                    itemCount: users.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final user = users[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        child: GestureDetector(
                                          onTap: () {
                                            // Navigator.of(context).pushReplacement(
                                            //     MaterialPageRoute(
                                            //         builder: (BuildContext context) =>
                                            //             Details(
                                            //               price: user.price,
                                            //               std: user.stadiumId,
                                            //             )));
                                          },
                                          child: Card(
                                            elevation: 5,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.account_circle,
                                                        size: 40,
                                                      ),
                                                      // const CircleAvatar(
                                                      //   radius: 20,
                                                      //   backgroundColor: Colors.transparent,
                                                      //   backgroundImage: AssetImage(
                                                      //     'assets/images/profileuser.png',
                                                      //   ),
                                                      // ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            // user.firstName.toString(),

                                                            'Pandiyan',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            user.section
                                                                .toString(),
                                                            //'DEC',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(
                                                    thickness: 0.5,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            user.requestType
                                                                .toString(),
                                                            //  "PERMISSION",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: lite,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            2),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5)),
                                                                    backgroundColor: (user.status ==
                                                                            '3')
                                                                        ? Colors
                                                                            .red
                                                                        : (user.status) ==
                                                                                '5'
                                                                            ? Colors.red
                                                                            : (user.status) == '7'
                                                                                ? Colors.green.shade500
                                                                                : Colors.orange.shade500),
                                                            // backgroundColor: (user.statusText ==
                                                            //         'Parent Rejected')
                                                            //     ? Colors
                                                            //         .red
                                                            //     : (user.statusText) ==
                                                            //             'Principal Rejected'
                                                            //         ? Colors.red
                                                            //         : (user.statusText) == 'Parent Approval'
                                                            //             ? Colors.green.shade500
                                                            //             : (user.statusText) == 'Principal Approval'
                                                            //                 ? Colors.green.shade500
                                                            //                 : (user.statusText) == 'Reached'
                                                            //                     ? Colors.green.shade500
                                                            //                     : Colors.yellow.shade500),
                                                            onPressed: () {},
                                                            child: Text(
                                                              user.statusText
                                                                  .toString(),
                                                              // "APPROVED",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      // SizedBox(
                                                      //   height: 5,
                                                      // ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            user.fromDate
                                                                    .toString() +
                                                                "  - " +
                                                                user.toDate
                                                                    .toString(),

                                                            // "22 JUN 2023 - 22 JUN 2023",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      LeaveDetails(
                                                                          id: user
                                                                              .id
                                                                              .toString(),
                                                                          screen:
                                                                              2)));
                                                            },
                                                            child: Image.asset(
                                                              'assets/images/next.png',
                                                              height: 20,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      // SizedBox(
                                                      //   height: 5,
                                                      // ),
                                                      Text(
                                                        user.reasonType
                                                            .toString(),
                                                        // "ATM",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                ),
              ),
            ),
          ),
        ));
  }
}
