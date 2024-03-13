import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mtidesk/Constant/color.dart';
import 'package:mtidesk/Leave_Details.dart';
import 'package:mtidesk/models/studentlist.dart';
import 'package:mtidesk/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Student_list extends StatefulWidget {
  Student_list({Key? key}) : super(key: key);

  @override
  State<Student_list> createState() => _Student_listState();
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class _Student_listState extends State<Student_list> {
  final _debouncer = Debouncer();
  TextEditingController _textEditingController = TextEditingController();

  List<Studentlist> users = [];

  List<Studentlist> _search = [];

  bool isloading = true;
  @override
  void initState() {
    super.initState();
    _requestlist();
  }

  _requestlist() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    print("--------");
    var student_id = session.getInt('student_id');
    var email = session.getString('email');

    print("--------");

    Services.studentlist().then((results) {
      setState(() {
        isloading = false;
        users = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final filteredList = _getFilteredList();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: violet,
          automaticallyImplyLeading: false,
          title: Text(
            "Student List",
            style: TextStyle(
                color: white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            print("-");
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
                                TextField(
                                  // onChanged: (text) {
                                  //   setState(() {
                                  //     _keyword = text;
                                  //   });
                                  // },
                                  onChanged: (value) {
                                    setState(() {
                                      _search = users
                                          .where((element) => element.firstName!
                                              .toLowerCase()
                                              .contains(value.toLowerCase()))
                                          .toList();
                                    });
                                  },

                                  controller: _textEditingController,
                                  // onChanged: (value) => _Filter(value),
                                  decoration: InputDecoration(
                                      fillColor: light,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 3,
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              const BorderSide(color: grey),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      contentPadding:
                                          const EdgeInsets.only(left: 20),
                                      prefixIcon: Icon(Icons.search),
                                      hintText: 'Search Student name',
                                      hintStyle: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'NunitoSans',
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                _textEditingController.text.isNotEmpty &&
                                        _search.isEmpty
                                    ? Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 50, 0, 0),
                                              child: Text(
                                                'No results',
                                                style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    fontSize: 22,
                                                    color: Color(0xff848484)),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : ListView.builder(
                                        physics: const ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        // itemCount: 3,
                                        itemCount: _textEditingController
                                                .text.isNotEmpty
                                            ? _search.length
                                            : users.length,
                                        //itemCount: users.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final user = _textEditingController
                                                  .text.isNotEmpty
                                              ? _search[index]
                                              : users[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12),
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: Card(
                                                elevation: 5,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .account_circle,
                                                                size: 40,
                                                              ),
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
                                                                    // 'Pandiyan',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color:
                                                                            black,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    user.mobileNo
                                                                        .toString(),
                                                                    // '+91 9066418026',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color:
                                                                            black,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    user.section
                                                                        .toString(),
                                                                    // 'DEC',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color:
                                                                            black,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Total Leave :" +
                                                                    user.totalLeaveApproved
                                                                        .toString()
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color:
                                                                        black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
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
