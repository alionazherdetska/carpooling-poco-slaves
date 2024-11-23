const String baseUrl = 'http://172.23.21.250:8000';


enum EApiRoutes {
  getRides(path: "/api/rides/"),
  postRides(path: "/api/rides/"),
  activeRides(path: "/api/rides/active"),
  detailRide(path: "/api/rides/active"),

  login(path: "/api/users/login"),
  logout(path: "/api/users/login"),

  createUser(path: "/api/users/"),
  getUser(path: "/api/users");

  const EApiRoutes({required this.path});
  final String path;
}