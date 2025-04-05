import 'package:dio/dio.dart';

import 'package:fast_order/config/index.dart';
import 'package:fast_order/domain/index.dart';
import 'package:fast_order/infrastructure/index.dart';

class RenderAuthDatasourceImpl implements AuthDatasource {

  final Dio dio; //!Dio is a coupled dependency Datasources

  RenderAuthDatasourceImpl()
      : dio = Dio(
        BaseOptions(
          baseUrl: Environment.apiUrl,
          ),
        );

  @override
  Future<User> login(String email, String password) async {
    await Future.delayed(Duration(milliseconds: 500));
    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          "email": email,
          "password": password,
        },
      );
      final User user = User.mapJsonToUserEntity(response.data);
      return user;
    } on DioException catch (e) {
      if( e.response?.statusCode == 404 || e.response?.statusCode == 400) throw WrongCredentials( message: e.response?.data['error']);
      if( e.type == DioExceptionType.connectionTimeout ) throw ConnectionTimeout();
      throw CustomError('Unexpected DioException', 500);
    }
  }

  @override
  Future<TokenPair> refreshToken(String refreshToken) async {
    try {
      final response = await dio.post(
        '/auth/refresh-token',
        data: {
          "refreshToken": refreshToken,
        }
      );
      final TokenPair tokenPair = TokenPair.mapJsonToTokenPair(response.data);
      return tokenPair;
    } on DioException catch (e) {
      if( e.response?.statusCode == 401 ) throw InvalidToken();
      if( e.type == DioExceptionType.connectionTimeout ) throw ConnectionTimeout();
      throw CustomError('Unexpected DioException', 500);
    }
  }
  
  @override
  Future<User> checkAuthStatus(String accessToken, String refreshtoken) async {
    try{
      final response = await dio.post(
        '/auth/check-auth-status',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          }
        )
      );
      final Map<String, dynamic> dataWithTokens = {
        ...response.data,
        'accessToken': accessToken,
        'refreshToken': refreshtoken,
      };
      final User user = User.mapJsonToUserEntity(dataWithTokens);
      return user;
    } on DioException catch (e) {
      if( e.response?.statusCode == 401 ) throw InvalidToken();
      if( e.type == DioExceptionType.connectionTimeout ) throw ConnectionTimeout();
      throw CustomError('Unexpected DioException', 500);
    }
  }
  
}