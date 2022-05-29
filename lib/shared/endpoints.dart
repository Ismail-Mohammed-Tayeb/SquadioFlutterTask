abstract class ApiEndpoints {
  //Not Best Practices
  static const String apiKey =
      "?api_key=8f907a9fcbdd2843e00e8dafbb58fd60&language=en-US";
  static String getPeopleEndPoint =
      "https://api.themoviedb.org/3/person/popular$apiKey&page=";
  static const String imageEndpoint = 'https://image.tmdb.org/t/p/w500';
  static String getPersonDetailsEndPoint =
      "https://api.themoviedb.org/3/person/";
}
