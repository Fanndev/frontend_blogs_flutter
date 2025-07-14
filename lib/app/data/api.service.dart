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

  static Future<Response> register(Map data) async {
    try {
      print('[API] POST register: $data');
      return await dio.post('/auth/register', data: data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> login(Map data) async {
    try {
      print('[API] POST login: $data');
      return await dio.post('/auth/login', data: data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> setToken(String token) async {
    await storage.write(key: 'jwt_token', value: token);
    print('[API] JWT token saved: $token');
  }

  static Future<String?> getToken() async {
    final token = await storage.read(key: 'jwt_token');
    print('[API] JWT token fetched: $token');
    return token;
  }

  static Future<void> clearToken() async {
    await storage.delete(key: 'jwt_token');
    print('[API] JWT token cleared.');
  }

  /// ==================== GENERIC METHODS WITH JWT ====================

  static Future<Response> getRequest(String endpoint) async {
  final token = await getToken();
  print('[ApiService] GET: $endpoint with token: $token');

  return dio.get(
    endpoint,
    options: Options(
      headers: token != null
          ? {'Authorization': 'Bearer $token'}
          : null, // skip header jika token null
    ),
  );
}


  static Future<Response> postRequest(String endpoint, Map data) async {
    final token = await getToken();
    try {
      print('[API] POST $endpoint | Data: $data');
      return await dio.post(endpoint, data: data, options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> putRequest(String endpoint, Map data) async {
    final token = await getToken();
    try {
      print('[API] PUT $endpoint | Data: $data');
      return await dio.put(endpoint, data: data, options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> deleteRequest(String endpoint) async {
    final token = await getToken();
    try {
      print('[API] DELETE $endpoint');
      return await dio.delete(endpoint, options: Options(headers: {'Authorization': 'Bearer $token'}));
    } catch (e) {
      rethrow;
    }
  }

  /// ==================== BERITA ====================

  static Future<Response> getAllBerita() async => await getRequest('/berita');

  static Future<Response> getBeritaDetail(int id) async => await getRequest('/berita/$id/');

  static Future<Response> createBerita(Map data) async => await postRequest('/berita/', data);

  static Future<Response> updateBerita(int id, Map data) async => await putRequest('/berita/$id/', data);

  static Future<Response> deleteBerita(int id) async => await deleteRequest('/berita/$id/');

  /// ==================== TAG ====================

  static Future<Response> getAllTags() async => await getRequest('/tag');

  static Future<Response> getTagDetail(int id) async => await getRequest('/tag/$id/');

  static Future<Response> createTag(Map data) async => await postRequest('/tag/', data);

  static Future<Response> updateTag(int id, Map data) async => await putRequest('/tag/$id/', data);

  static Future<Response> deleteTag(int id) async => await deleteRequest('/tag/$id/');

  /// ==================== COMMENTS ====================

  static Future<Response> getAllComments() async => await getRequest('/comments/');

  static Future<Response> getCommentDetail(int id) async => await getRequest('/comments/$id/');

  static Future<Response> createComment(Map data) async => await postRequest('/comments/', data);

  static Future<Response> updateComment(int id, Map data) async => await putRequest('/comments/$id/', data);

  static Future<Response> deleteComment(int id) async => await deleteRequest('/comments/$id/');
}
