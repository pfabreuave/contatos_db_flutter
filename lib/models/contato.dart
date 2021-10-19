class Contato {
  late int id;
  late String usergh;
  late String email;
  late String avatar;

  Contato(this.id, this.usergh, this.email, this.avatar);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'usergh': usergh,
      'email': email,
      'avatar': avatar
    };
    return map;
  }

  Contato.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    usergh = map['usergh'];
    email = map['email'];
    avatar = map['avatar'];
  }

  @override
  String toString() {
    return 'Contato => (id: $id, usergh: $usergh, email: $email, avatar: $avatar)';
  }
}
