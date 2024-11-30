import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mechanix_admin/data/api_endpoints.dart';
import 'package:mechanix_admin/models/analytics_count_model.dart';
import 'package:mechanix_admin/models/analytics_model.dart';

class AnalyticsService {
  Future<Map<String, dynamic>> getActivitiesAnalyticsData(
      {required String token}) async {
    String url =
        '${ApiEndPoints.baseUrl}${ApiEndPoints.dashboardActivitiesAnalyticsUrl}';
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final AnalyticsData analyticsData =
            AnalyticsData.fromJson(responseData['data'] ?? {});

        return {'success': true, 'data': analyticsData};
      } else {
        return {'success': false, 'data': null};
      }
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getActivitiesCountData(
      {required String token}) async {
    String url =
        '${ApiEndPoints.baseUrl}${ApiEndPoints.dashboardActivitiesCountUrl}';
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Map<String, dynamic> countData = responseData["data"];
        ActivtiesCount activitiesCount = ActivtiesCount.fromJson(countData);

        return {'success': true, 'data': activitiesCount};
      } else {
        return {'success': false};
      }
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }
}
