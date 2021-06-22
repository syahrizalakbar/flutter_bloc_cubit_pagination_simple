
import 'dart:developer';

import 'package:dio/dio.dart';

class DioHandler {
  Dio dio = Dio()..interceptors.add(InterceptorsWrapper(
    onResponse: (Response res, handler) {
      log("Response: ${res.data}");
      handler.next(res);
    },
    onRequest: (RequestOptions req, handler) {
      log("Request: " + {
        "method": req.method,
        "url": req.baseUrl + req.path,
        "data": req.data is FormData ? req.data.fields : req.data,
        "params": req.queryParameters,
      }.toString());
      handler.next(req);
    },
    onError: (DioError err, handler) {
      log("Error: ${err.response?.statusCode} - ${err.response?.data}");
      handler.next(err);
    },
  ));
}

Dio dio = DioHandler().dio;