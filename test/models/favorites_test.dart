import 'package:test/test.dart';
import 'package:test_app/models/favorites.dart';


/*
 * ===================================================
 * 🔍 유닛 테스트 가이드 (Unit Test)
 * ===================================================
 * 
 * 📱 테스트 실행 방법
 * -----------------------------------------------------
 * 1️⃣ 터미널에서 실행하기:
 *    프로젝트 루트 디렉토리에서 다음 명령어 실행
 *    $ flutter test test/models/favorites_test.dart
 * 
 * 2️⃣ IDE에서 실행하기:
 *    코드 좌측에 표시되는 초록색 ▶️ 버튼 클릭
 * 
 * 📝 유닛 테스트 특징
 * -----------------------------------------------------
 * • 애플리케이션의 가장 작은 단위(클래스, 메소드 등)를 테스트
 * • UI나 외부 의존성 없이 비즈니스 로직만 검증
 * • 빠르게 실행되며 디버깅이 용이함
 * 
 * 📚 참고 자료
 * -----------------------------------------------------
 * • Flutter unit test in google codelab:
 *   https://codelabs.developers.google.com/codelabs/flutter-app-testing#4
 * ===================================================
 */


void main() {
  group('Testing App Provider', () {
    var favorites = Favorites();

    test('A new item should be added', () {
      var number = 35;
      favorites.add(number);
      expect(favorites.items.contains(number), true);
    });    
    test('An item should be removed', () {
      var number = 45;
      favorites.add(number);
      expect(favorites.items.contains(number), true);
      favorites.remove(number);
      expect(favorites.items.contains(number), false);
    });

  });

}