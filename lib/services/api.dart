enum Endpoint { Curated, API_KEY }

class Api {
  static int perPage = 30;
  static int pageNumber = 1;
  static Map<Endpoint, String> endpoint = {
    Endpoint.Curated: "curated?page=$pageNumber&per_page=$perPage",
    Endpoint.API_KEY: "1EYoMYDTgro4ri2dmtlginRU6cjNnwxAhA1HND7DCQ9918EgF8q0Vzoo"
  };

  static String? getEndpoint(Endpoint url) {
    return endpoint[url];
  }
}
