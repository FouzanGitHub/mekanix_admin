import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mechanix_admin/data/api_endpoints.dart';
import 'package:mechanix_admin/helpers/storage_helper.dart';
import 'package:mechanix_admin/models/user_model.dart';

class UsersService extends GetxController {
  Future<Map<String, dynamic>> fetchUsers() async {
    String url = '${ApiEndPoints.baseUrl}${ApiEndPoints.getAllUsersUrl}';
    final Map<String, dynamic> body = {"search": ""};

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> usersJson = responseData["data"][0]["users"];
        print('TotalUsers: ${usersJson.length}');
        final List<User> users =
            usersJson.map((json) => User.fromJson(json)).toList();
        return {'success': true, 'users': users};
      } else {
        return {'success': false, 'users': []};
      }
    } catch (e) {
      return {'success': false, 'users': [], 'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> approveUser(User user) async {
    debugPrint('Arroving user: ${user.firstName} ${user.lastName}');
    String url = '${ApiEndPoints.baseUrl}${ApiEndPoints.approveUserUrl}';
    var payload = {
      "user_id": user.id,
    };
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${storage.read('token')}"
        },
        body: jsonEncode(payload),
      );
      if (response.statusCode == 200) {
        debugPrint('Approved user: ${user.firstName} ${user.lastName}');
        debugPrint('${response.body} ${response.reasonPhrase}');
        return {'success': true};
      } else {
        debugPrint('${response.body} ${response.reasonPhrase}');
        return {'success': false, 'error': response.body};
      }
    } catch (e) {
      debugPrint(e.toString());
      return {'success': false, 'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> deleteUser(String userId) async {
    String url = '${ApiEndPoints.baseUrl}${ApiEndPoints.deleteUserUrl}';
    var payload = {
      "user_id": userId,
      "REJECTED": true,
      "REMOVED": false,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${storage.read('token')}"
        },
        body: jsonEncode(payload),
      );
      debugPrint(
          '${response.body} ${response.statusCode}} ${response.reasonPhrase}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        // Process the response data if needed
        return {'success': true};
      } else {
        return {'success': false, 'error': 'Failed to delete user'};
      }
    } catch (e) {
      return {'success': false, 'error': 'Exception occurred: $e'};
    }
  }

  // Future<Map<String, dynamic>> declineUser(
  //     {required User user, bool isRejected = false}) async {
  //   String url = '${ApiEndPoints.baseUrl}${ApiEndPoints.deleteUserUrl}';
  //   var payload = {
  //     "user_id": user.id,
  //     "REJECTED": isRejected ? true : false,
  //     "REMOVED": isRejected ? false : true
  //   };
  //   try {
  //     final http.Response response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Authorization": "Bearer ${storage.read('token')}"
  //       },
  //       body: jsonEncode(payload),
  //     );
  //     debugPrint(
  //         '${response.body} ${response.statusCode}} ${response.reasonPhrase}');
  //
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       if (responseData['status'] == 'success') {
  //         debugPrint(
  //             '${isRejected ? 'Rejected' : 'Removed'} user: ${user.firstName} ${user.lastName}');
  //         return {'success': true};
  //       } else {
  //         return {'success': false, 'error': responseData['message']};
  //       }
  //     } else {
  //       debugPrint('${response.body} ${response.reasonPhrase}');
  //       return {'success': false, 'error': response.body};
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     return {'success': false, 'error': e.toString()};
  //   }
  // }
}
