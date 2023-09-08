class UserIDGenerator {
  int _currentUserID = 0;
  static final UserIDGenerator _instance = UserIDGenerator._internal();

  factory UserIDGenerator() {
    return _instance;
  }

  UserIDGenerator._internal();

  int generateUserID() {
    _currentUserID++;
    return _currentUserID;
  }
}
