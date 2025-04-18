# Flutter 테스트 가이드

Flutter 앱의 테스트 방법에 대한 종합 가이드입니다. 다양한 테스트 타입과 실행 방법을 안내합니다.

## 목차

- [테스트 종류](#테스트-종류)
- [유닛 테스트 (Unit Tests)](#유닛-테스트-unit-tests)
- [위젯 테스트 (Widget Tests)](#위젯-테스트-widget-tests)
- [통합 테스트 (Integration Tests)](#통합-테스트-integration-tests)
- [성능 테스트 (Performance Tests)](#성능-테스트-performance-tests)
- [테스트 실행 팁](#테스트-실행-팁)
- [참고 자료](#참고-자료)

## 테스트 종류

Flutter에서는 다음과 같은 테스트 방법을 제공합니다:

| 테스트 종류 | 주요 대상 | 속도 | 의존성 |
|------------|----------|-----|-------|
| 유닛 테스트 | 비즈니스 로직, 단일 기능 | 빠름 | 최소 |
| 위젯 테스트 | UI 컴포넌트 | 중간 | 중간 |
| 통합 테스트 | 전체 앱 흐름 | 느림 | 높음 |
| 성능 테스트 | 앱 성능 측정 | 느림 | 높음 |

## 유닛 테스트 (Unit Tests)

애플리케이션의 가장 작은 단위인 클래스, 메소드 등을 테스트합니다.

### 설정 방법

`pubspec.yaml`에 의존성 추가:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  test: ^1.24.9
```

### 실행 방법

#### 특정 유닛 테스트 실행:

```bash
flutter test test/models/favorites_test.dart
```

#### 모든 유닛 테스트 실행:

```bash
flutter test
```

### 예시

```dart
// models/favorites_test.dart
test('A new item should be added', () {
  var number = 35;
  favorites.add(number);
  expect(favorites.items.contains(number), true);
});
```

## 위젯 테스트 (Widget Tests)

UI 컴포넌트와 위젯을 테스트합니다.

### 설정 방법

`pubspec.yaml`에 의존성 추가:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
```

### 실행 방법

```bash
flutter test test/home_test.dart
```

### 실제 기기에서 위젯 테스트 실행

```bash
flutter run test/home_test.dart
```

### 예시

```dart
testWidgets('Testing IconButtons', (tester) async {
  await tester.pumpWidget(createHomeScreen());
  expect(find.byIcon(Icons.favorite), findsNothing);
  await tester.tap(find.byIcon(Icons.favorite_border).first);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  expect(find.text('Added to favorites.'), findsOneWidget);
});
```

## 통합 테스트 (Integration Tests)

전체 애플리케이션의 기능 흐름을 테스트합니다.

### 설정 방법

`pubspec.yaml`에 의존성 추가:

```yaml
dev_dependencies:
  integration_test:
    sdk: flutter
```

### 실행 방법

```bash
flutter test integration_test/app_test.dart
```

### 예시

```dart
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
});
```

## 성능 테스트 (Performance Tests)

앱의 성능을 측정하는 테스트입니다.

### 설정 방법

`pubspec.yaml`에 의존성 추가:

```yaml
dev_dependencies:
  integration_test:
    sdk: flutter
  flutter_driver:
    sdk: flutter
```

### 성능 테스트 파일 구조

성능 테스트는 두 파일로 구성됩니다:
1. `integration_test/perf_test.dart` - 실제 성능 테스트 코드
2. `test_driver/perf_driver.dart` - 성능 데이터 수집용 드라이버

### 실행 방법

```bash
flutter drive --driver=test_driver/perf_driver.dart --target=integration_test/perf_test.dart
```

### 결과 확인

테스트 실행 후 프로젝트 루트의 `build` 폴더에 `scrolling_summary.timeline_summary.json` 파일이 생성됩니다.

### 예시

```dart
// integration_test/perf_test.dart
testWidgets('Scrolling test', (tester) async {
  await tester.pumpWidget(const TestingApp());
  final listFinder = find.byType(ListView);

  await binding.traceAction(() async {
    await tester.fling(listFinder, const Offset(0, -500), 10000);
    await tester.pumpAndSettle();
  }, reportKey: 'scrolling_summary');
});
```

## 테스트 실행 팁

### IDE에서 실행하기
대부분의 테스트는 코드 좌측에 표시되는 초록색 ▶️ 버튼을 클릭하여 실행할 수 있습니다.

### 테스트 재실행 단축키
- 테스트 코드 변경 후 재실행: `r` 또는 `R` 키 입력
- 코드 변경 없이 재실행: 현재 실행 중인 테스트 종료 후 처음부터 다시 실행

### 모든 테스트 실행
```bash
flutter test
```

## 참고 자료

- [Flutter 유닛 테스트 가이드](https://codelabs.developers.google.com/codelabs/flutter-app-testing#4)
- [Flutter 위젯 테스트 가이드](https://codelabs.developers.google.com/codelabs/flutter-app-testing#5)
- [Flutter 통합 테스트 가이드](https://codelabs.developers.google.com/codelabs/flutter-app-testing#6)
- [Flutter 성능 테스트 가이드](https://codelabs.developers.google.com/codelabs/flutter-app-testing#7)
- [Flutter 공식 테스트 문서](https://docs.flutter.dev/testing)
