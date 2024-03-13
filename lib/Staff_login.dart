import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mtidesk/Api/api.dart';
import 'package:mtidesk/Constant/color.dart';
import 'package:mtidesk/Constant/toast.dart';
import 'package:mtidesk/Notification_services.dart';
import 'package:mtidesk/navigation.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Staff_Login extends StatefulWidget {
  Staff_Login({Key? key}) : super(key: key);

  @override
  State<Staff_Login> createState() => _Staff_LoginState();
}

class _Staff_LoginState extends State<Staff_Login> {
  bool isloading = false;
  @override
  NotificationServices notificationServices = NotificationServices();
  void initState() {
    // TODO: implement initState
    super.initState();

    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    // notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _passVisibility = true;

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
      key: formkey,
      child: Container(
        margin: EdgeInsets.only(top: 120),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.asset(
                'assets/images/log-grow.png',
                height: 150,
                fit: BoxFit.cover,
              )),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'Staff/Principal Sign ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Username',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter username";
                  }

                  return null;
                },
                controller: email,
                autocorrect: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Blue, width: 2)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: box),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Blue, width: 2),
                    ),
                    contentPadding:
                        const EdgeInsets.only(left: 24, top: 14, bottom: 13),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter your username",
                    hintStyle: const TextStyle(
                        color: grey, fontFamily: 'Rubik', fontSize: 14),
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: Blue,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Password',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter password";
                  }

                  return null;
                },
                controller: pass,
                autocorrect: true,
                obscureText: _passVisibility,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: red, width: 2)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: box),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Blue, width: 2),
                    ),
                    contentPadding:
                        const EdgeInsets.only(left: 24, top: 14, bottom: 13),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter your password',
                    hintStyle: const TextStyle(
                        fontFamily: 'Rubik', color: grey, fontSize: 14),
                    suffixIcon: IconButton(
                      color: grey,
                      icon: _passVisibility
                          ? Icon(
                              Icons.visibility_off,
                              color: LiteBlue,
                            )
                          : Icon(
                              Icons.visibility,
                              color: Blue,
                            ),
                      onPressed: () {
                        _passVisibility = !_passVisibility;
                        setState(() {});
                      },
                    ),
                    prefixIcon: Icon(
                      Icons.lock_rounded,
                      color: Blue,
                    )),
              ),
              SizedBox(height: 25),
              Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Blue,
                      minimumSize: const Size.fromHeight(44),
                    ),
                    onPressed: () {
                      setState(() {
                        if (formkey.currentState!.validate()) {
                          isloading = true;
                          print(isloading);
                          user();
                        }
                      });
                    },
                    child: isloading == true
                        ? Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(2.0),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    )));
  }

  user() async {
    // String? deviceId = await _getId();
    // String? token = await FirebaseMessaging.instance.getToken();
    // print('Deviceid :' '$deviceId');
    // var token = await getToken();
    String? token;
    print('token :' '$token');
    var url = Login;
    var data = {
      // "name":name.text,
      "email": email.text,
      "password": pass.text,
    };
    print(data);
    print(url);
    var body = json.encode(data);
    var urlparse = Uri.parse(url);

    http.Response response = await http.post(
      urlparse,
      body: data,
    );
    var response_data = json.decode(response.body.toString());

    if (response.statusCode == 200) {
      setState(() {
        isloading = false;
      });
      print(isloading);
      print(response_data['result']);
      print(response_data['result']['user_id']);
      print(response_data['result']['name']);

      print(response_data['result']['email']);
      final session = await SharedPreferences.getInstance();
      await session.setString('email', response_data['result']['email']);
      await session.setInt('user_id', response_data['result']['user_id']);
      await session.setString('name', response_data['result']['name']);
      await session.setString('token', response_data['result']['token']);

      var user_name = session.getString('name');

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Navigation()),
          (Route<dynamic> route) => false);

      print('Success');
      toastInfo(mesg: response_data['message'].toString());
    } else {
      setState(() {
        isloading = false;
      });
      print(isloading);
      toastInfo(mesg: response_data['message'].toString());
    }
  }
}
