import "package:myflow_mini_companion_app/domain/models/user/user.dart";

class UserRepository {
  User getUser() {
    return User(name: "Joana", picture: "https://avatar.iran.liara.run/public/55");
  }
}