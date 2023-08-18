
import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/constants/local_storege_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthIntercptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    final RequestOptions(:headers, :extra) = options;

    const authHeaderKey = 'Authorization';

    headers.remove(authHeaderKey);

    if(extra case {'DIO_AUTH_KEY': true}) {
      final sp = await SharedPreferences.getInstance();
      headers.addAll({
        authHeaderKey: 'Bearer ${sp.getString(LocalStoregeKeys.accessToken)}'
      });
    }
    handler.next(options);
  }
}