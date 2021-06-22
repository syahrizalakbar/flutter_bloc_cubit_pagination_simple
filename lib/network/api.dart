class Api {
  static String baseUrl = "https://jsonplaceholder.typicode.com";

  static void setProduction() {
    Api.baseUrl = "https://asad.com";
  }

  static String getUser = "$baseUrl/users";
}