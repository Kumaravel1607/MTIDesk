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

class LeaveDetails1 extends StatefulWidget {
  final String id;
  LeaveDetails1({Key? key, required this.id}) : super(key: key);

  @override
  State<LeaveDetails1> createState() => _LeaveDetails1State();
}

class _LeaveDetails1State extends State<LeaveDetails1> {
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
  String _principalapproval = '';
  String _parentapproval = '';
  String _statusopen = '';
  String _statustext = '';
  String _name = '';
  String _deg = '';
  int _statusnum = 0;

  List<StepperData> stepperData = [
    StepperData(
        title: StepperText(
          "Requested Leave",
          textStyle: const TextStyle(
              fontFamily: 'Poppins',
              color: black,
              fontSize: 14,
              fontWeight: FontWeight.w600),
          
        ),
        subtitle: StepperText(""),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          //child: Icon(Icons.add),
        )),
    StepperData(
        title: StepperText(
          "Waiting Principal Approval",
          textStyle: const TextStyle(
              fontFamily: 'Poppins',
              color: black,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        subtitle: StepperText(
          "",
        ),
        iconWidget: Container(
          decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        )),
    StepperData(
        title: StepperText(
          "Principal Approved",
          textStyle: const TextStyle(
              fontFamily: 'Poppins',
              color: black,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        subtitle: StepperText(""),
        iconWidget: Container(
          decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        )),
    StepperData(
        title: StepperText(
          "Waiting Parent Approval",
          textStyle: const TextStyle(
              fontFamily: 'Poppins',
              color: black,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        subtitle: StepperText("56mins"),
        iconWidget: Container(
          decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        )),
    StepperData(
        title: StepperText(
          "Parent Approved",
          textStyle: const TextStyle(
              fontFamily: 'Poppins',
              color: black,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        subtitle: StepperText('2hrs'),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(30))),
        )),
  ];
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
            Navigator.pop(context);
           
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
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Center(
                      child: Column(
                        children: const [
                          Icon(
                            Icons.account_circle,
                            size: 70,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "PANDIYAN",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "DEG",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
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
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
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
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
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
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
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
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
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
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
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
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "PRINICIPAL APPROVED",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 30,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor:
                                        (_principalapproval == 'Rejected')
                                            ? Colors.red
                                            : (_principalapproval) == 'Pending'
                                                ? Colors.yellow.shade600
                                                : Colors.green.shade600),
                                // minimumSize: const Size.fromHeight(30),

                                // minimumSize: const Size.fromHeight(30),

                                onPressed: () {
                               
                                },
                                child: Text(
                                  _principalapproval,
                                  //  "APPROVED",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                        
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "PARENT APPROVED",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 30,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor:
                                        (_parentapproval == 'Rejected')
                                            ? Colors.red
                                            : (_parentapproval) == 'Pending'
                                                ? Colors.yellow.shade600
                                                : Colors.green.shade600),
                                // minimumSize: const Size.fromHeight(30),

                                // minimumSize: const Size.fromHeight(30),

                                onPressed: () {
                                
                                },
                                child: Text(
                                  _parentapproval,
                                  // "PENDING",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                backgroundColor: (_statusopen == 'Closed')
                                    ? red
                                    : (_statusopen) == 'Open'
                                        ? Blue_bottom
                                        : Colors.green.shade600),
                            // minimumSize: const Size.fromHeight(30),

                            onPressed: () {
                              // Navigator.of(context).push(
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             Login_page()));
                            },
                            child: Text(
                              _statusopen,
                              // 'OPEN',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: AnotherStepper(
                          stepperList: [
                            StepperData(
                                title: StepperText(
                                  "Requested Leave",
                                  textStyle: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  // textStyle: const TextStyle(
                                  //   color: Colors.grey,
                                  // ),
                                ),
                                subtitle: StepperText(""),
                                iconWidget: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: _statusnum > 0
                                          ? Colors.blueAccent
                                          : Colors.grey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  //child: Icon(Icons.add),
                                )),
                            StepperData(
                                title: StepperText(
                                  "Waiting Principal Approval",
                                  textStyle: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: StepperText(
                                  "",
                                ),
                                iconWidget: Container(
                                  decoration: BoxDecoration(
                                      color: _statusnum > 1
                                          ? Colors.blueAccent
                                          : Colors.grey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                )),
                            StepperData(
                                title: StepperText(
                                  "Principal Approved",
                                  textStyle: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: StepperText(""),
                                iconWidget: Container(
                                  decoration: BoxDecoration(
                                      color: _statusnum > 2
                                          ? Colors.blueAccent
                                          : Colors.grey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                )),
                            StepperData(
                                title: StepperText(
                                  "Waiting Parent Approval",
                                  textStyle: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: StepperText(""),
                                iconWidget: Container(
                                  decoration: BoxDecoration(
                                      color: _statusnum > 3
                                          ? Colors.blueAccent
                                          : Colors.grey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                )),
                            StepperData(
                                title: StepperText(
                                  "Parent Approved",
                                  textStyle: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: StepperText(''),
                                iconWidget: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: _statusnum > 4
                                          ? Colors.blueAccent
                                          : Colors.grey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                )),
                          ],
                          stepperDirection: Axis.vertical,
                          iconWidth: 20,
                          iconHeight: 20,
                          activeBarColor: Colors.blue,
                          inActiveBarColor: Colors.grey,
                          //inverted: true,
                          verticalGap: 15,
                          activeIndex: 1,
                          barThickness: 2,
                        ),
                      ),
                    ],
                  ),
                )
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
      _principalapproval =
          (response_data['results']['principal_status'].toString());
      _statusopen = (response_data['results']['status_open'].toString());
      _statustext = (response_data['results']['status_text'].toString());
      _name = (response_data['results']['first_name'].toString());
      _deg = (response_data['results']['section'].toString());
      _statusnum = int.parse(response_data['results']['current_status']);
    
      print('Success');
    
    } else {
    
    }
  }
}
