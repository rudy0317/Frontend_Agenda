import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'agenda.dart';

class AgendaService {
  late final Dio _dio;

  AgendaService() {
    // Kalau jalan di web pakai 127.0.0.1, kalau nanti Android pakai 10.0.2.2
    final baseUrl = kIsWeb
        ? 'http://127.0.0.1:8000/api'  // Flutter Web
        : 'http://10.0.2.2:8000/api';   // Emulator Android (kalau dipakai)

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
  }

  Future<List<Agenda>> getAll() async {
    final response = await _dio.get('/agenda');
    return (response.data as List)
        .map((json) => Agenda.fromJson(json))
        .toList();
  }

  Future<void> create(Agenda agenda) async {
    await _dio.post('/agenda', data: agenda.toJson());
  }

  Future<void> update(int id, Agenda agenda) async {
    await _dio.put('/agenda/$id', data: agenda.toJson());
  }

  Future<void> delete(int id) async {
    await _dio.delete('/agenda/$id');
  }
}
