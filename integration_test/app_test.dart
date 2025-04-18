import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/main.dart';

/*
 * ===================================================
 * 🔍 통합 테스트 가이드 (Integration Test)
 * ===================================================
 * 
 * 📱 테스트 설정 방법
 * -----------------------------------------------------
 * 1️⃣ pubspec.yaml에 다음 의존성 추가:
 *    dev_dependencies:
 *      integration_test:
 *        sdk: flutter
 * 
 * 📱 테스트 실행 방법
 * -----------------------------------------------------
 * 1️⃣ 터미널에서 실행하기:
 *    프로젝트 루트 디렉토리에서 다음 명령어 실행
 *    $ flutter test integration_test/app_test.dart
 * 
 * 2️⃣ IDE에서 실행하기:
 *    코드 좌측에 표시되는 초록색 ▶️ 버튼 클릭
 * 
 * 📝 통합 테스트 특징
 * -----------------------------------------------------
 * • 위젯 테스트와 유사하지만, 실제 기기에서 전체 앱을 실행
 * • 여러 화면과 상호작용을 포함한 end-to-end 테스트 가능
 * • 앱의 전체 기능 흐름을 테스트할 수 있음
 * 
 * 📚 참고 자료
 * -----------------------------------------------------
 * • Flutter integration test in google codelab:
 * https://codelabs.developers.google.com/codelabs/flutter-app-testing#6
 * ===================================================
 */

void main() {
  group('Testing App', () {
    testWidgets('Favorites operations test', (tester) async {
      await tester.pumpWidget(const TestingApp());

      final iconKeys = [
        'icon_0',
        'icon_1',
        'icon_2',
      ];

      for (var icon in iconKeys) {
        await tester.tap(find.byKey(ValueKey(icon)));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text('Added to favorites.'), findsOneWidget);
      }

      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();

      final removeIconKeys = [
        'remove_icon_0',
        'remove_icon_1',
        'remove_icon_2',
      ];

      for (final iconKey in removeIconKeys) {
        await tester.tap(find.byKey(ValueKey(iconKey)));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text('Removed from favorites.'), findsOneWidget);
      }
    });
  });
}