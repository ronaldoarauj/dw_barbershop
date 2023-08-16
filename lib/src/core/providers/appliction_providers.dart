import 'package:dw_barbershop/src/core/restClient/rest_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appliction_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();