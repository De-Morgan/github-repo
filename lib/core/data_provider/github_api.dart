import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:githubrepo/core/model/githup_repo.dart';

class GithubRepoApiNetwork implements GitHubRepoApi {
  final dio = Dio();

  final String BASEURL = "https://api.github.com/search/repositories";

  static GithubRepoApiNetwork _instance = GithubRepoApiNetwork._internal();

  factory GithubRepoApiNetwork() {
    return _instance;
  }
  GithubRepoApiNetwork._internal();

  @override
  Future<List<GithubRepo>> getGithubRepo() async {
    try {
      Response response = await Dio().get(BASEURL, queryParameters: {
        "q": "flutter+language:dart",
        "page": 1,
        "per_page": 10
      });
      if (response.statusCode == 200) {
        print("${response.data.runtimeType}");
        print("${response.data}");
        // Map<String, dynamic> rawJson = json.decode(response.data);
        Map<String, dynamic> rawJson = response.data;
        List<dynamic> result = rawJson["items"];
        return result.map((data) => GithubRepo.fromJson(data)).toList();
      } else {
        throw Exception("Error Ocurred");
      }
    } catch (e) {
      print(e);
    }
  }
}

abstract class GitHubRepoApi {
  Future<List<GithubRepo>> getGithubRepo();
}
