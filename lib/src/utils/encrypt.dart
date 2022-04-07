
import 'package:encrypt/encrypt.dart' as s;

class Encriptar{

  final _key = s.Key.fromUtf8('C4b2ZRywjo8oTBvkE18YSvoHAA8lbAca');
  final _iv = s.IV.fromUtf8('PTk6KaVZxN04SXz0');
    
  encriptar(String plainText){
    
    final encrypter = s.Encrypter(s.AES(_key, mode: s.AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: _iv);

    return encrypted.base64;
  }

  desencriptar(String encriptedPlainText){

    final encrypter = s.Encrypter(s.AES(_key, mode: s.AESMode.cbc));
    final textEnc = s.Encrypted.from64(encriptedPlainText);
    final decrypted = encrypter.decrypt(textEnc, iv: _iv);

    return decrypted;
  }
}