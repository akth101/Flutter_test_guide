import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/favorites.dart';
import 'package:test_app/screens/home.dart';

/*
 * ===================================================
 * 🔍 위젯 테스트 가이드 (Widget Test)
 * ===================================================
 * 
 * 📱 테스트 실행 방법
 * -----------------------------------------------------
 * 1️⃣ 터미널에서 실행하기:
 *    프로젝트 루트 디렉토리에서 다음 명령어 실행
 *    $ flutter test test/home_test.dart
 * 
 * 2️⃣ IDE에서 실행하기:
 *    코드 좌측에 표시되는 초록색 ▶️ 버튼 클릭
 * 
 * 📲 실제 기기에서 테스트 보기
 * -----------------------------------------------------
 * • 기기 연결 후 명령어 입력:
 *   $ flutter run test/home_test.dart
 * 
 * • 기기 선택 창이 나타나면 원하는 기기 선택
 * 
 * 🔄 테스트 재실행 단축키
 * -----------------------------------------------------
 * • 테스트 코드 변경 후 재실행: r 또는 R 키 입력
 *   (터미널에 단축키 목록이 표시됨)
 * 
 * • 코드 변경 없이 재실행하려면: 
 *   현재 실행 중인 테스트 종료 후 처음부터 다시 실행
 * 
 * 📚 참고 자료
 * -----------------------------------------------------
 * • Flutter widget test in google codelab:
 *   https://codelabs.developers.google.com/codelabs/flutter-app-testing#5
 * ===================================================
 */

Widget createHomeScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) => Favorites(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );

void main() {
  group('Home Page Widget Tests', () {

    testWidgets('Testing if ListView shows up', (tester) async {  
    await tester.pumpWidget(createHomeScreen());
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Testing Scrolling', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.text('Item 0'), findsOneWidget);
      await tester.fling(
        find.byType(ListView),
        const Offset(0, -200),
        3000,
      );
      await tester.pumpAndSettle();
      expect(find.text('Item 0'), findsNothing);
    });

    testWidgets('Testing IconButtons', (tester) async {
  await tester.pumpWidget(createHomeScreen());
  expect(find.byIcon(Icons.favorite), findsNothing);
  await tester.tap(find.byIcon(Icons.favorite_border).first);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  expect(find.text('Added to favorites.'), findsOneWidget);
  expect(find.byIcon(Icons.favorite), findsWidgets);
  await tester.tap(find.byIcon(Icons.favorite).first);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  expect(find.text('Removed from favorites.'), findsOneWidget);
  expect(find.byIcon(Icons.favorite), findsNothing);
});
  });

  
}