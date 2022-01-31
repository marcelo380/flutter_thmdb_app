class Url {
  static const String baseURL = 'https://api.themoviedb.org/3';
  static const String baseURLImage = 'https://image.tmdb.org/t/p/w500';

  static const String movie = '/movie';
  static String getImageUrl(String path) => baseURLImage + path;
  static const String popularMovies = movie + '/popular';
  static String search(String query) => "/search" + movie;
  static const String genre = '/genre/movie/list';
  static String getCreditsUrl(int movieID) => movie + "/$movieID/credits";
}
