// Only care about the full_name  and id
class GithubRepo {
  final String full_name;
  final int ownerId;

  GithubRepo({this.full_name, this.ownerId});

  factory GithubRepo.fromJson(Map<String, dynamic> json) {
    return GithubRepo(
        full_name: json["full_name"], ownerId: json["owner"]["id"] as int);
  }
}
