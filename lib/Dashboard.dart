import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mtidesk/Api/api.dart';
import 'package:mtidesk/Constant/color.dart';
import 'package:mtidesk/Constant/toast.dart';
import 'package:mtidesk/Leave_Details.dart';
import 'package:mtidesk/models/requestlist.dart';
import 'package:mtidesk/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

Timer? timer;

class _HomeState extends State<Home> {
  List<Requestlist> users = [];
  bool isloading = true;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 120), (Timer t) => _requestlist());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  _requestlist() async {
    SharedPreferences session = await SharedPreferences.getInstance();

    print("--------");
    var id = session.getInt('id');

    print("--------");
    // print(email);
    // print(student_id);

    Services.requestlist().then((results) {
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
          title: Text(
            "Dashboard",
            style: TextStyle(
                color: white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              _requestlist();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                margin: const EdgeInsets.only(top: 20),
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
                                      // itemCount: 3,
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
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
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
                                                              user.firstName
                                                                  .toString(),

                                                              //'Pandiyan',
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
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              user.requestType
                                                                  .toString(),
                                                              // "PERMISSION",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: lite,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              '${user.fromDate}'
                                                              ' - '
                                                              '${user.toDate}',
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
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            // Text(
                                                            //   //   '${user.fromDate}'
                                                            //   //   ' - '
                                                            //   //   '${user.toDate}',
                                                            //   'Duration :'
                                                            //   '${user.toDate}',
                                                            //   style: TextStyle(
                                                            //       fontFamily: 'Poppins',
                                                            //       color: black,
                                                            //       fontSize: 12,
                                                            //       fontWeight:
                                                            //           FontWeight.w400),
                                                            // ),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
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

                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.of(context).pushReplacement(
                                                                    MaterialPageRoute(
                                                                        builder: (BuildContext
                                                                                context) =>
                                                                            LeaveDetails(
                                                                              id: user.id.toString(),
                                                                              screen: 1,
                                                                            )));
                                                            
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/next.png',
                                                                height: 20,
                                                              ),
                                                            )
                                                              ],
                                                        ),
                                                      ],
                                                    ),
                              
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        SizedBox(
                                                          width: 140,
                                                          height: 40,
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              backgroundColor:
                                                                  violet,
                                                            ),
                                                          
                                                            onPressed: () {
                                                              update_status(
                                                                  user.id
                                                                      .toString(),
                                                                  1);
                                                              users.removeAt(
                                                                  index);
                                                            },
                                                            child: const Text(
                                                              // user.statusText,
                                                              "ACCEPT",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: white,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 140,
                                                          height: 40,
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              backgroundColor:
                                                                  dash,
                                                            ),
                                                            // (user.statusText ==
                                                            //         'Rejected')
                                                            //     ? Colors.red
                                                            //     : (user.statusText) ==
                                                            //             'Pending'
                                                            //         ? Colors.yellow
                                                            //             .shade600
                                                            //         : Colors.green
                                                            //             .shade600),
                                                            onPressed: () {
                                                              update_status(
                                                                  user.id
                                                                      .toString(),
                                                                  0);
                                                              users.removeAt(
                                                                  index);
                                                            },
                                                            child: const Text(
                                                              // user.statusText,
                                                              "REJECT",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: white,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
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
            )));
  }

  update_status(leave_id, status) async {
    var url = principalstatus;
    var data = {
      // "name":name.text,
      "leave_id": leave_id.toString(),
      "status": status.toString(),

      //"app_key": token,
    };
    print(data);
    var body = json.encode(data);
    var urlparse = Uri.parse(url);

    http.Response response = await http.post(
      urlparse,
      body: data,
    );
    var response_data = json.decode(response.body.toString());
    print(response_data);
    if (response.statusCode == 200) {
     
      setState(() {});
     
      print('Success');
      toastInfo(mesg: response_data['message'].toString());
      
 
    } else {
      toastInfo(mesg: response_data['message'].toString());
     
    }
  }
}
