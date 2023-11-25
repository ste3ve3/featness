// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://dummyapi.io/data/v1';

class ApiResponse<T> {
  Status status;
  T? data;
  String? error;

  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.error) : status = Status.ERROR;
}

enum Status { LOADING, COMPLETED, ERROR }

class BaseClient {
  var client = http.Client();

  Future<ApiResponse<dynamic>> get(String api) async {
    try {
      var url = Uri.parse(baseUrl + api);
      var headers = {
        'app-id': '65616f978a69f92e3239b091'
      };

      var response = await client.get(url, headers: headers);

      if (response.statusCode == 200) {
        return ApiResponse.completed(response.body);
      } else {
        return ApiResponse.error("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      return ApiResponse.error("Error: $e");
    }
  }

  Future<ApiResponse<dynamic>> post(String api, dynamic object) async {
    try {
      var url = Uri.parse(baseUrl + api);
      var payload = json.encode(object);
      var headers = {
        'Content-Type': 'application/json',
        'app-id': '65616f978a69f92e3239b091'
      };

      var response = await client.post(url, body: payload, headers: headers);

      if (response.statusCode == 201) {
        return ApiResponse.completed(response.body);
      } else {
        return ApiResponse.error("Failed to post data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      return ApiResponse.error("Error: $e");
    }
  }

  Future<ApiResponse<dynamic>> put(String api, dynamic object) async {
    try {
      var url = Uri.parse(baseUrl + api);
      var payload = json.encode(object);
      var headers = {
        'Content-Type': 'application/json',
        'app-id': '65616f978a69f92e3239b091'
      };

      var response = await client.put(url, body: payload, headers: headers);

      if (response.statusCode == 200) {
        return ApiResponse.completed(response.body);
      } else {
        return ApiResponse.error("Failed to update data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      return ApiResponse.error("Error: $e");
    }
  }

  Future<ApiResponse<dynamic>> delete(String api) async {
    try {
      var url = Uri.parse(baseUrl + api);
      var headers = {
        'app-id': '65616f978a69f92e3239b091'
      };

      var response = await client.delete(url, headers: headers);

      if (response.statusCode == 200) {
        return ApiResponse.completed(response.body);
      } else {
        return ApiResponse.error("Failed to delete data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      return ApiResponse.error("Error: $e");
    }
  }
}
