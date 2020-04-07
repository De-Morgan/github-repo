import 'package:githubrepo/core/data_provider/github_api.dart';
import 'package:githubrepo/core/model/githup_repo.dart';

class GithubRepoRepository {
  final GitHubRepoApi _gitHubRepoApi;
  GithubRepoRepository({GitHubRepoApi gitHubRepoApi})
      : _gitHubRepoApi = gitHubRepoApi ?? GithubRepoApiNetwork();

  Future<List<GithubRepo>> getGithubRepo() => _gitHubRepoApi.getGithubRepo();
}
