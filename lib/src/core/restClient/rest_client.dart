import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dw_barbershop/src/core/restClient/interceptors/auth_intercptor.dart';

final class RestClient extends DioForNative {
  RestClient()
      : super(BaseOptions(
          baseUrl: 'http://192.168.0.139:8080',
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 80),
        )) {
    interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
      AuthIntercptor(),
    ]);
  }

  RestClient get auth {
    options.extra['DIO_AUTH_KEY'] = true;
    return this;
  }

  RestClient get unAuth {
    options.extra['DIO_AUTH_KEY'] = false;
    return this;
  }
}
