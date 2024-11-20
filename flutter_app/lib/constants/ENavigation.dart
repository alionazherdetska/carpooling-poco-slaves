enum ENavigation {
  home('/home', 'home'),
  signIn('/signin', 'signin'),
  signUp('/signup', 'signup'),
  createRide('create_ride', 'create_ride'), // Relative path for nested routes
  findRide('find_ride', 'find_ride'); // Relative path for nested routes

  const ENavigation(this.path, this.name);

  final String path;
  final String name;
}