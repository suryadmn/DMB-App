/// A class that holds constants for API URL access.
class UrlAccess {
  /// Base URL for the API.
  static String urlBase = "https://api.themoviedb.org/";
  static String urlBaseMedia = "https://image.tmdb.org/t/p/original";

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

  /// Account related paths.
  static String account = "account/";

  /// Watchlist related paths.
  static String watchlist = "watchlist/";

  /// Path for requesting a new token.
  static String newToken = "new";

  /// Path for requesting a new session.
  static String newSession = "new";

  /// Path for validating with login.
  static String validateWithLogin = "validate_with_login";

  /// Path for requesting watch list.
  static String movies = "movies";

  /// Path for requesting watch list.
  static String favorite = "favorite";

  /// Path for requesting top rated.
  static String topRated = "top_rated";

  /// Path for requesting now playing.
  static String nowPlaying = "now_playing";

  /// Path for requesting popular.
  static String popular = "popular";

  /// Path for requesting credits.
  static String credits = "credits";

  /// Path for requesting similar.
  static String similar = "similar";
}
