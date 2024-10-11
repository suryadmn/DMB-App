/// A class that holds constants for API URL access.
class UrlAccess {
  /// Base URL for the API.
  static String urlBase = "https://api.themoviedb.org/";

  /// API version.
  static String apiVersion = "3/";

  /// Authorization Bearer token.
  static String authorization =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNDRkZDg5MDE5NTgwOWRmMmNiYmEzZjUxZGM0MDViMiIsIm5iZiI6MTcyODU3MzY1NC43NjAyNTcsInN1YiI6IjY3MDcyZTc4NjcxODAxMmZjMjMzNmVlZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BAIbldhIY4gJTsz_u_-eDSafAb6qXqzyo54ZWvWC4jk";

  /// Authentication related paths.
  static String authentication = "authentication/";

  /// Token related paths.
  static String token = "token/";

  /// Session related paths.
  static String session = "session/";

  /// Path for requesting a new token.
  static String newToken = "new";

  /// Path for validating with login.
  static String validateWithLogin = "validate_with_login";
}
