// The best way to handle network requests in Flutter
// Applications frequently need to perform POST and GET and other HTTP requests.
// Flutter provides an http package that supports making HTTP requests.

// HTTP methods: GET, POST, PATCH, PUT, DELETE

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../shared_preference/local_storage.dart';
import '../shared_preference/shared_preference_services.dart';

class ApiClient extends GetxService {
  static const int _timeoutInSeconds = 5;

  final String baseUrl;

  late String _token;
  late Map<String, String> _mainHeaders;

  Future getToken() async {
    _token = await getDataFromLocalStorage(
          dataType: LocalStorage.stringType,
          prefKey: LocalStorageKey.token,
        ) ??
        "";
  }

  ApiClient({
    required this.baseUrl,
  }) {
    getToken();
    _mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token'
    };
  }

  void updateHeader(
    String token,
  ) {
    _token = token;
    _mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
    };
  }

  Future<dynamic> get(
    String uri,
  ) async {
    debugPrint(
      _mainHeaders["Authorization"],
    );
    try {
      final response = await http
          .get(
            Uri.parse(
              baseUrl + uri,
            ),
            headers: _mainHeaders,
          )
          .timeout(
            const Duration(
              seconds: _timeoutInSeconds,
            ),
          );

      if (foundation.kDebugMode) {
        developer.log(
          'API => ${response.request!.url.toString()} \nStatusCode => [${response.statusCode}] \nResponse => ${response.body}',
        );
      }

      return _handleResponse(
        response,
      );
    } on SocketException {
      throw FetchDataException(
        'No Internet connection',
        uri,
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API not responded in time',
        uri,
      );
    }
  }

  Future<dynamic> delete(
    String uri,
  ) async {
    try {
      final response = await http
          .delete(
            Uri.parse(baseUrl + uri),
            headers: _mainHeaders,
          )
          .timeout(
            const Duration(
              seconds: _timeoutInSeconds,
            ),
          );

      if (foundation.kDebugMode) {
        developer.log(
          'API => ${response.request!.url.toString()} \nStatusCode => [${response.statusCode}] \nResponse => ${response.body}',
        );
      }

      return _handleResponse(
        response,
      );
    } on SocketException {
      throw FetchDataException(
        'No Internet connection',
        uri,
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API not responded in time',
        uri,
      );
    }
  }

  Future<dynamic> post(
    String uri, {
    Object? body,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(baseUrl + uri),
            body: body,
            headers: _mainHeaders,
          )
          .timeout(
            const Duration(
              seconds: _timeoutInSeconds,
            ),
          );

      if (foundation.kDebugMode) {
        developer.log(
          'API => ${response.request!.url.toString()} \nBody => $body \nStatusCode => [${response.statusCode}] \nResponse => ${response.body}',
        );
      }

      return _handleResponse(
        response,
      );
    } on SocketException {
      throw FetchDataException(
        'No Internet connection',
        uri,
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API not responded in time',
        uri,
      );
    }
  }

  Future<dynamic> put(
    String uri, {
    Object? body,
  }) async {
    try {
      final response = await http
          .put(
            Uri.parse(baseUrl + uri),
            body: body,
            headers: _mainHeaders,
          )
          .timeout(
            const Duration(
              seconds: _timeoutInSeconds,
            ),
          );

      if (foundation.kDebugMode) {
        developer.log(
          'API => ${response.request!.url.toString()} \nBody => $body \nStatusCode => [${response.statusCode}] \nResponse => ${response.body}',
        );
      }

      return _handleResponse(
        response,
      );
    } on SocketException {
      throw FetchDataException(
        'No Internet connection',
        uri,
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API not responded in time',
        uri,
      );
    }
  }

  Future<dynamic> patch(
    String uri, {
    Object? body,
  }) async {
    try {
      final response = await http
          .patch(
            Uri.parse(baseUrl + uri),
            body: body,
            headers: _mainHeaders,
          )
          .timeout(
            const Duration(
              seconds: _timeoutInSeconds,
            ),
          );

      if (foundation.kDebugMode) {
        developer.log(
          'API => ${response.request!.url.toString()} \nBody => $body \nStatusCode => [${response.statusCode}] \nResponse => ${response.body}',
        );
      }

      return _handleResponse(
        response,
      );
    } on SocketException {
      throw FetchDataException(
        'No Internet connection',
        uri,
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API not responded in time',
        uri,
      );
    }
  }

  Future<dynamic> patchMultipart(
    String uri, {
    Map<String, String>? body,
    List<MultipartBody>? multipartBody,
  }) async {
    try {
      http.MultipartRequest _request = http.MultipartRequest(
        'PATCH',
        Uri.parse(baseUrl + uri),
      );
      _request.headers.addAll(_mainHeaders);

      if (multipartBody != null) {
        for (MultipartBody multipart in multipartBody) {
          File _file = File(multipart.file.path);
          _request.files.add(
            http.MultipartFile(
              multipart.key,
              _file.readAsBytes().asStream(),
              _file.lengthSync(),
              filename: _file.path.split('/').last,
            ),
          );
        }
      }

      if (body != null) {
        _request.fields.addAll(
          body,
        );
      }

      final response = await http.Response.fromStream(
        await _request.send(),
      );

      if (foundation.kDebugMode) {
        developer.log(
          'API => ${response.request!.url.toString()} \nBody => $body \nStatusCode => [${response.statusCode}] \nResponse => ${response.body}',
        );
      }

      return _handleResponse(
        response,
      );
    } on SocketException {
      throw FetchDataException(
        'No Internet connection',
        uri,
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API not responded in time',
        uri,
      );
    }
  }

  dynamic _handleResponse(
    http.Response response,
  ) {
    switch (response.statusCode) {
      case 200:
        final responseJson = jsonDecode(
          response.body,
        );
        return responseJson;

      case 401:
        throw UnAuthorizedException(
          response.body,
          response.request!.url.toString(),
        );

      case 404:
        throw FetchDataException(
          response.body,
          response.request!.url.toString(),
        );

      case 500:
        try {
          final json = jsonDecode(response.body);
          throw FetchDataException(
            json['message'],
            response.request!.url.toString(),
          );
        } catch (e) {
          throw FetchDataException(
            'Internal server error',
            response.request!.url.toString(),
          );
        }

      case 503:
        throw ApiNotRespondingException(
          'Service Temporarily Unavailable',
          response.request!.url.toString(),
        );

      default:
        throw FetchDataException(
          'Error occured with code : ${response.statusCode}',
          response.request!.url.toString(),
        );
    }
  }
}

class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException([
    this.message,
    this.prefix,
    this.url,
  ]);
}

class BadRequestException extends AppException {
  BadRequestException([
    String? message,
    String? url,
  ]) : super(
          message,
          'Bad Request',
          url,
        );
}

class FetchDataException extends AppException {
  FetchDataException([
    String? message,
    String? url,
  ]) : super(
          message,
          'Unable to process',
          url,
        );
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([
    String? message,
    String? url,
  ]) : super(
          message,
          'Api not responded in time',
          url,
        );
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([
    String? message,
    String? url,
  ]) : super(
          message,
          'UnAuthorized request',
          url,
        );
}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(
    this.key,
    this.file,
  );
}
