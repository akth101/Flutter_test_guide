import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/favorites.dart';
import 'package:test_app/screens/favorites.dart';

/*
 * ===================================================
 * 🔍 위젯 테스트 가이드 (Widget Test)
 * ===================================================
 * 
 * 📱 테스트 실행 방법
 * -----------------------------------------------------
 * 1️⃣ 터미널에서 실행하기:
 *    프로젝트 루트 디렉토리에서 다음 명령어 실행
 *    $ flutter test test/favorites_test.dart
 * 
 * 2️⃣ IDE에서 실행하기:
 *    코드 좌측에 표시되는 초록색 ▶️ 버튼 클릭
 * 
 * 📲 실제 기기에서 테스트 보기
 * -----------------------------------------------------
 * • 기기 연결 후 명령어 입력:
 *   $ flutter run test/home_test.dart
 * 
 * • (혹시 기기 선택 창이 나타나면 원하는 기기 선택하면 됨)
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

late Favorites favoritesList;

Widget createFavoritesScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) {
        favoritesList = Favorites();
        return favoritesList;
      },
      child: const MaterialApp(
        home: FavoritesPage(),
      ),
    );

void addItems() {
  for (var i = 0; i < 10; i += 2) {
    favoritesList.add(i);
  }
}

void main() {
  group('Favorites Page Widget Tests', () {
    testWidgets('Test if ListView shows up', (tester) async {
      await tester.pumpWidget(createFavoritesScreen());
      addItems();
      await tester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Testing Remove Button', (tester) async {
      await tester.pumpWidget(createFavoritesScreen());
      addItems();
      await tester.pumpAndSettle();
      var totalItems = tester.widgetList(find.byIcon(Icons.close)).length;
      await tester.tap(find.byIcon(Icons.close).first);
      await tester.pumpAndSettle();
      expect(tester.widgetList(find.byIcon(Icons.close)).length,
          lessThan(totalItems));
      expect(find.text('이런 메시지는 표시되지 않음'), findsOneWidget);
    });
  });
}