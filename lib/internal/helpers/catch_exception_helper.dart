import 'package:dio/dio.dart';

class CatchException {
  String? message;

  CatchException({this.message});

  static CatchException convertException(dynamic error) {
    if (error is DioException) {
      print(error);
      if (error.type == DioExceptionType.connectionTimeout) {
        print('CONNECTION_ERROR');
        return CatchException(
            message: 'Превышено время обработки запроса. Повторите позднее');
      } else if (error.type == DioExceptionType.receiveTimeout) {
        print('RECIVE_ERROR');
        return CatchException(
            message: 'Превышено время обработки запроса. Повторите позднее');
      } else if (error.response == null) {
        print('NO_INTERNET');
        return CatchException(message: 'Нет интернет соеденения');
      } else if (error.response != null && error.response!.statusCode! >= 500) {
        return CatchException(
            message:
                error.response?.data["error"] ?? 'Произошла системная ошибка');
      } else if (error.response != null && error.response!.statusCode == 404) {
        return CatchException(
            message: error.response?.data["error"] ??
                'Неверный номер телефона или пароль');
      } else if (error.response != null && error.response!.statusCode == 409) {
        return CatchException(
            message: error.response?.data["error"] ??
                'Данный номер уже зарегестрирован');
      }
    }
    if (error is CatchException) {
      return error;
    } else {
      return CatchException(message: 'Произошла системная ошибка');
    }
  }
}
