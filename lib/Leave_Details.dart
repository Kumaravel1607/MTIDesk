import 'dart:convert';

import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:mtidesk/Api/api.dart';
import 'package:mtidesk/Constant/color.dart';
import 'package:mtidesk/Dashboard.dart';
import 'package:mtidesk/History.dart';
import 'package:mtidesk/Student_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LeaveDetails extends StatefulWidget {
  final String id;
  final int screen;
  LeaveDetails({Key? key, required this.id, required this.screen})
      : super(key: key);

  @override
  State<LeaveDetails> createState() => _LeaveDetailsState();
}

class _LeaveDetailsState extends State<LeaveDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    leavedetails();
  }

  String _reason = '';
  String _type = '';
  String _fromdate = '';
  String _fromtime = '';
  String _todate = '';
  String _totime = '';

  String _parentapproval = '';
  String _statusopen = '';
  String _statustext = '';
  String _name = '';
  String _deg = '';
  int _statusnum = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: violet,
        automaticallyImplyLeading: false,
        leadingWidth: 20,
        leading: GestureDetector(
          onTap: () {
            //   Navigator.pop(context, true);
            // Navigator.of(context).pushAndRemoveUntil(
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => History_Screen()),
            //     (Route<dynamic> route) => false);
            var screen = widget.screen;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => screen == 1 ? Home() : Request_list()),
            );
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 5),
            child: Icon(
              Icons.arrow_back,
              color: white,
            ),
          ),
        ),
        title: const Text(
          "Leave Details",
          style: TextStyle(
              fontFamily: 'Poppins',
              color: white,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "REASON",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _reason,
                              // "Permission",
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "REQUEST TYPE",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _type,
                              // "ATM",
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "FROM DATE",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _fromdate,
                              // "22 JUN 2023",
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "FROM TIME",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _fromtime,
                              //  "09:00:AM",
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "TO DATE",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _todate,
                              // "22 JUN 2023",
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "TO TIME",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _totime,
                              //"05:00:PM",
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "STATUS",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _statustext,
                              //"05:00:PM",
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void leavedetails() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    print("--------");
    var id = session.getInt('id');
    var token = session.getString('token');
    var url = Detail;
    var data = {"id": widget.id};
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
      _reason = (response_data['results']['request_type'].toString());
      _type = (response_data['results']['reason_type'].toString());
      _fromdate = (response_data['results']['from_date'].toString());
      _fromtime = (response_data['results']['from_time'].toString());
      _todate = (response_data['results']['to_date'].toString());
      _totime = (response_data['results']['to_time'].toString());
      _parentapproval = (response_data['results']['parents_status'].toString());
      _statusopen = (response_data['results']['status_open'].toString());
      _statustext = (response_data['results']['status_text'].toString());
      _name = (response_data['results']['first_name'].toString());
      _deg = (response_data['results']['section'].toString());
      _statusnum =
          int.parse(response_data['results']['current_status'].toString());

      print('Success');
    } else {}
  }
}
