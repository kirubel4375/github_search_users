class Auser {
  String? avatar_url;
  String? login;
  String? bio;
  int? followers;
  int? following;
  int? public_repos;
  String? html_url;
  String? name;
  String? created_at;

  Auser({
    required this.login,
    required this.avatar_url,
    required this.bio,
    required this.followers,
    required this.following,
    required this.public_repos,
    required this.html_url,
    required this.name,
    required this.created_at,
  });
  static Auser fromJson(Map<String, dynamic> json) => Auser(
        login: json['login'],
        avatar_url: json['avatar_url'],
        bio: json['bio'],
        followers: json['followers'],
        following: json['following'],
        public_repos: json['public_repos'],
        html_url: json['html_url'],
        name: json['name'],
        created_at: json['created_at'],
      );
}
