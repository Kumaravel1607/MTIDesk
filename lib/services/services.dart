import 'dart:convert';

import 'package:mtidesk/Api/api.dart';
import 'package:mtidesk/models/history.dart';
import 'package:mtidesk/models/requestlist.dart';
import 'package:mtidesk/models/studentlist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Services {
  static Future<List<Requestlist>> requestlist() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var id = session.getInt('student_id');
    var token = session.getString('token');

    List<Requestlist> users = [];

    Map data = {};
    print('-----xxx----');
    // print(data);
    var url = principalDashboard;
    var urlparse = Uri.parse(url);

    final response = await http.get(urlparse, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    // print(urlparse);
    // print(data);

    var responseBody = json.decode(response.body.toString());
    print(responseBody);
    if (response.statusCode == 200) {
      users = RequestlistResponse(jsonEncode(responseBody['results']));
      // print(list);
      return users;
      // Map<String, dynamic> map = json.decode(response.body);
      // List<dynamic> jsonResponse = map["results"];
      // return jsonResponse
      //     .map((data) => new LeaveHistory.fromJson(data))
      //     .toList();
    } else {
      throw Exception("Problem in fetching ");
    }
    // return list;
  }

  static List<Requestlist> RequestlistResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Requestlist>((json) => Requestlist.fromJson(json))
        .toList();
  }

  static Future<List<Historylist>> historylist() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var student_id = session.getInt('student_id');
    var token = session.getString('token');
    List<Historylist> users = [];

    Map data = {};
    print('-----xxx----');
    // print(data);
    var url = princiaplRequestlist;
    var urlparse = Uri.parse(url);

    final response = await http.post(urlparse, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(urlparse);
    print(data);

    var responseBody = json.decode(response.body.toString());
    print(responseBody);
    if (response.statusCode == 200) {
      users = HistorylistResponse(jsonEncode(responseBody['results']));
      // print(list);
      return users;
      // Map<String, dynamic> map = json.decode(response.body);
      // List<dynamic> jsonResponse = map["results"];
      // return jsonResponse
      //     .map((data) => new LeaveHistory.fromJson(data))
      //     .toList();
    } else {
      throw Exception("Problem in fetching ");
    }
    // return list;
  }

  static List<Historylist> HistorylistResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Historylist>((json) => Historylist.fromJson(json))
        .toList();
  }

  static Future<List<Studentlist>> studentlist() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var student_id = session.getInt('student_id');
    var token = session.getString('token');
    List<Studentlist> users = [];
    //String _searchlist = '';
    print(token);
    Map data = {};
    print('-----student----');
    // print(data);
    var url = StudentList;
    var urlparse = Uri.parse(url);
    print(urlparse);
    print(data);

    final response = await http.get(urlparse, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    var responseBody = json.decode(response.body.toString());
    print(responseBody);
    if (response.statusCode == 200) {
      users = StudentlistResponse(jsonEncode(responseBody['results']));
      // _searchlist = (responseBody['results']['request_type'].toString());
      // print(list);
      return users;
      // Map<String, dynamic> map = json.decode(response.body);
      // List<dynamic> jsonResponse = map["results"];
      // return jsonResponse
      //     .map((data) => new LeaveHistory.fromJson(data))
      //     .toList();
    } else {
      throw Exception("Problem in fetching ");
    }
    // return list;
  }

  static List<Studentlist> StudentlistResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Studentlist>((json) => Studentlist.fromJson(json))
        .toList();
  }
}
