import 'package:adlokal/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given UserModel data When toJson() is used Then Map<> is displayed',
      () {
    //ARRANGE
    UserModel user = UserModel(
        uid: '123',
        email: 'test@test.com',
        name: 'tyrone',
        photoUrl: 'https://img.com/myimg.png');

    // ACT

    // ASSERT
    expect({"uid": "123", "email": 'test@test.com', "name": 'tyrone', "photoUrl": 'https://img.com/myimg.png'}, user.toJson());
  });
}
