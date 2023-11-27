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
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}

enum Status { LOADING, COMPLETED }

class BaseClient {
  var client = http.Client();

  Future<ApiResponse<dynamic>> get(String api) async {
    try {
      var url = Uri.parse(baseUrl + api);
      var headers = {
        'app-id': '6564b42915e99d4dfee32b6a'
      };

      var response = await client.get(url, headers: headers);

      if (response.statusCode == 200) {
        return ApiResponse.completed(response.body);
      } else {
        var errorJson = json.decode(response.body);
        var errorMessage = errorJson['error'] as String? ?? 'Something went wrong!';
        throw ApiException(errorMessage);
      }
    } catch (error) {
      throw ApiException("$error");
    }
  }

  Future<ApiResponse<dynamic>> post(String api, dynamic object) async {
    try {
      var url = Uri.parse(baseUrl + api);
      var payload = json.encode(object);
      var headers = {
        'Content-Type': 'application/json',
        'app-id': '6564b42915e99d4dfee32b6a'
      };

      var response = await client.post(url, body: payload, headers: headers);

      if (response.statusCode == 201) {
        return ApiResponse.completed(response.body);
      } else {
        var errorJson = json.decode(response.body);
        var error = errorJson['error'] as String? ?? 'Something went wrong!';
        var errorDetails = errorJson['data'] as Map<String, dynamic>?;
        var errorMessage = '$error\n';
        if (errorDetails != null) {
          errorDetails.forEach((key, value) {
            errorMessage += "$key: $value\n";
          });
        }
        throw ApiException(errorMessage);
      }
    } catch (error) {
      throw ApiException("$error");
    }
  }

  Future<ApiResponse<dynamic>> put(String api, dynamic object) async {
    try {
      var url = Uri.parse(baseUrl + api);
      var payload = json.encode(object);
      var headers = {
        'Content-Type': 'application/json',
        'app-id': '6564b42915e99d4dfee32b6a'
      };

      var response = await client.put(url, body: payload, headers: headers);

      if (response.statusCode == 200) {
        return ApiResponse.completed(response.body);
      } else {
        var errorJson = json.decode(response.body);
        var errorMessage = errorJson['error'] as String? ?? 'Something went wrong!';
        throw ApiException(errorMessage);
      }
    } catch (error) {
      throw ApiException("$error");
    }
  }

  Future<ApiResponse<dynamic>> delete(String api) async {
    try {
      var url = Uri.parse(baseUrl + api);
      var headers = {
        'app-id': '6564b42915e99d4dfee32b6a'
      };

      var response = await client.delete(url, headers: headers);

      if (response.statusCode == 200) {
        return ApiResponse.completed(response.body);
      } else {
        var errorJson = json.decode(response.body);
        var errorMessage = errorJson['error'] as String? ?? 'Something went wrong!';
        throw ApiException(errorMessage);
      }
    } catch (error) {
      throw ApiException("$error");
    }
  }
}
