import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:githubrepo/core/model/githup_repo.dart';

class GithubRepoApi implements Api {
  final dio = Dio();

  final String BASEURL = "https://api.github.com/search/repositories";

  static GithubRepoApi _instance = GithubRepoApi._internal();

  factory GithubRepoApi() {
    return _instance;
  }
  GithubRepoApi._internal();

  @override
  Future<List<GithubRepo>> getGithubRepo() async {
    try {
      Response response = await Dio().get(BASEURL, queryParameters: {
        "q": "flutter+language:dart",
        "page": 1,
        "per_page": 10
      });
      if (response.statusCode == 200) {
        print("${response.data}");
        Map<String, dynamic> rawJson = json.decode(response.data);
        List<dynamic> result = rawJson["items"];
        return result.map((data) => GithubRepo.fromJson(data));
      } else {
        throw Exception("Error Ocurred");
      }
    } catch (e) {
      print(e);
    }
  }
}

abstract class Api {
  Future<List<GithubRepo>> getGithubRepo();
}
