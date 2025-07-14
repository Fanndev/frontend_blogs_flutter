import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://127.0.0.1:8000/api/v1',
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  static final FlutterSecureStorage storage = const FlutterSecureStorage();

  /// ==================== AUTH ====================
  static Future<Response> register(Map data) async => await dio.post('/auth/register', data: data);
  static Future<Response> login(Map data) async => await dio.post('/auth/login', data: data);

  static Future<void> setToken(String token) async => await storage.write(key: 'jwt_token', value: token);
  static Future<String?> getToken() async => await storage.read(key: 'jwt_token');
  static Future<void> clearToken() async => await storage.delete(key: 'jwt_token');

  /// ==================== GENERIC WITH JWT ====================
  static Future<Options> _authHeader() async {
    final token = await getToken();
    return Options(
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }

  static Future<Response> getRequest(String endpoint) async => await dio.get(endpoint, options: await _authHeader());
  static Future<Response> postRequest(String endpoint, Map data) async => await dio.post(endpoint, data: data, options: await _authHeader());
  static Future<Response> putRequest(String endpoint, Map data) async => await dio.put(endpoint, data: data, options: await _authHeader());
  static Future<Response> deleteRequest(String endpoint) async => await dio.delete(endpoint, options: await _authHeader());

  /// ==================== BERITA ====================
  static Future<Response> getAllBerita() async => await getRequest('/berita');
  static Future<Response> getBeritaDetail(int id) async => await getRequest('/berita/$id');

  static Future<Response> createBerita(Map<String, dynamic> data, {File? file}) async {
    final token = await getToken();
    FormData formData = FormData();

    data.forEach((key, value) {
      if (value is List) {
        for (var v in value) {
          formData.fields.add(MapEntry('${key}[]', v.toString()));
        }
      } else {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    });

    if (file != null) {
      final fileName = file.path.split('/').last;
      formData.files.add(MapEntry(
        'thumbnail',
        await MultipartFile.fromFile(file.path, filename: fileName),
      ));
    }

    return await dio.post(
      '/berita',
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
  }

  static Future<Response> createBeritaWithBytes({
    required Map<String, dynamic> data,
    required Uint8List fileBytes,
    required String filename,
  }) async {
    final token = await getToken();
    FormData formData = FormData.fromMap({
      ...data,
      'thumbnail': MultipartFile.fromBytes(fileBytes, filename: filename),
    });

    return await dio.post(
      '/berita',
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
  }

  static Future<Response> updateBerita(int id, Map<String, dynamic> data, {File? file}) async {
  final token = await getToken();
  FormData form = FormData();

  data.forEach((key, value) {
    if (value is List) {
      for (var v in value) {
        form.fields.add(MapEntry('${key}[]', v.toString()));
      }
    } else {
      form.fields.add(MapEntry(key, value.toString()));
    }
  });

  if (file != null) {
    final fileName = file.path.split('/').last;
    form.files.add(MapEntry(
      'thumbnail',
      await MultipartFile.fromFile(file.path, filename: fileName),
    ));
  }

  print('[API] PUT (multipart) /berita/$id | Data: $data | File: ${file?.path}');
  return dio.put(
    '/berita/$id',
    data: form,
    options: Options(
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      },
    ),
  );
}


  static Future<Response> updateBeritaWithBytes({
    required int id,
    required Map<String, dynamic> data,
    required Uint8List fileBytes,
    required String filename,
  }) async {
    final token = await getToken();
    FormData formData = FormData.fromMap({
      ...data,
      'thumbnail': MultipartFile.fromBytes(fileBytes, filename: filename),
    });

    return await dio.put(
      '/berita/$id',
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
  }

  static Future<Response> deleteBerita(int id) async => await deleteRequest('/berita/$id');

  /// ==================== TAG ====================
  static Future<Response> getAllTags() async => await getRequest('/tag');
  static Future<Response> getTagDetail(int id) async => await getRequest('/tag/$id');
  static Future<Response> createTag(Map data) async => await postRequest('/tag', data);
  static Future<Response> updateTag(int id, Map data) async => await putRequest('/tag/$id', data);
  static Future<Response> deleteTag(int id) async => await deleteRequest('/tag/$id');

  /// ==================== COMMENTS ====================
  static Future<Response> getAllComments() async => await getRequest('/comments');
  static Future<Response> getCommentDetail(int id) async => await getRequest('/comments/$id');
  static Future<Response> createComment(Map data) async => await postRequest('/comments', data);
  static Future<Response> updateComment(int id, Map data) async => await putRequest('/comments/$id', data);
  static Future<Response> deleteComment(int id) async => await deleteRequest('/comments/$id');
}
