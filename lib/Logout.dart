import 'package:flutter/material.dart';
import 'package:mtidesk/Constant/color.dart';
import 'package:mtidesk/Staff_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatefulWidget {
  Logout({Key? key}) : super(key: key);

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Are you sure you want to logout?',
              style: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: black),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: violet,
                    minimumSize: const Size.fromHeight(44),
                  ),
                  onPressed: () async {
                    // Obtain shared preferences.
                    final session = await SharedPreferences.getInstance();
                    //  Remove data for the 'counter' key.
                    await session.remove('email');
                    await session.remove('suser_id');

                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return Staff_Login();
                        },
                      ),
                      (_) => false,
                    );
                    // Navigator.of(context).pushAndRemoveUntil(
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) => Staff_Login()),
                    //     (Route<dynamic> route) => false);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => Student_login()));
                  },
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'LOGOUT',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}
