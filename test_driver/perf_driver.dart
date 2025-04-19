import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:integration_test/integration_test_driver.dart';

/*
 * ===================================================
 * 🔍 성능 테스트 드라이버 가이드 (Performance driver)
 * ===================================================
 * 
 * 📱 테스트 실행 방법
 * -----------------------------------------------------
 * 1️⃣ 기기를 연결하고 다음 명령어 실행:
 *    $ flutter drive --driver=test_driver/perf_driver.dart --target=integration_test/app_test.dart
 * 
 * 📊 성능 데이터
 * -----------------------------------------------------
 * • 테스트 실행 후 프로젝트 루트의 build 폴더에 scrolling_summary.timeline_summary.json 파일 생성
 * • 이 파일에는 스크롤 성능에 대한 타임라인 데이터가 포함되어 있음
 * 
 * 📚 참고 자료
 * -----------------------------------------------------
 * • Flutter Driver 공식 문서:
 *   https://codelabs.developers.google.com/codelabs/flutter-app-testing#7
 * ===================================================
 */

Future<void> main() {
  return integrationDriver(
    responseDataCallback: (data) async {
      if (data != null) {
        final timeline = driver.Timeline.fromJson(
            data['scrolling_summary'] as Map<String, dynamic>);

        final summary = driver.TimelineSummary.summarize(timeline);

        await summary.writeTimelineToFile(
          'scrolling_summary',
          pretty: true,
          includeSummary: true,
        );
      }
    },
  );
}