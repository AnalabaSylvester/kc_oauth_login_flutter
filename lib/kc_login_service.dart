
class KingsLoginException implements Exception {
  final String message;
  KingsLoginException(this.message);
}

class KcScopes {
  final List<String> accepted;
  final List<String> declined;

  KcScopes({required this.accepted, required this.declined});

  factory KcScopes.fromMap(Map<dynamic, dynamic> map) {
    return KcScopes(
      accepted: List<String>.from(map['accepted'] ?? []),
      declined: List<String>.from(map['declined'] ?? []),
    );
  }
}

class KingsLoginResult {
  final String authorizationCode;
  final KcScopes scopes;

  KingsLoginResult({required this.authorizationCode, required this.scopes});
}
