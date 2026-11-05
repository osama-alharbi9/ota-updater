import 'package:revon_code_push/src/revon_updater.dart';
import 'package:revon_code_push/src/revon_updater_web.dart';
import 'package:test/test.dart';

import '../override_print.dart';

void main() {
  group(RevonUpdaterImpl, () {
    late RevonUpdaterImpl revonUpdater;

    test(
      'logs unavailable error',
      overridePrint((logs) {
        revonUpdater = RevonUpdaterImpl();
        expect(
          logs,
          contains(
            isA<String>().having(
              (s) => s,
              'message',
              contains(
                '''The Revon Updater is unavailable in the current environment.''',
              ),
            ),
          ),
        );
      }),
    );

    group('isAvailable', () {
      test(
        'returns false',
        overridePrint((_) {
          revonUpdater = RevonUpdaterImpl();
          expect(revonUpdater.isAvailable, isFalse);
        }),
      );
    });

    group('readPatch', () {
      test(
        'returns null',
        overridePrint((_) async {
          await expectLater(
            revonUpdater.readCurrentPatch(),
            completion(isNull),
          );
          await expectLater(
            revonUpdater.readNextPatch(),
            completion(isNull),
          );
        }),
      );
    });

    group('checkForUpdate', () {
      test(
        'returns UpdateStatus.unavailable',
        overridePrint((_) async {
          await expectLater(
            revonUpdater.checkForUpdate(),
            completion(equals(UpdateStatus.unavailable)),
          );
        }),
      );
    });

    group('update', () {
      test(
        'does nothing',
        overridePrint((_) async {
          await expectLater(revonUpdater.update(), completes);
        }),
      );
    });
  });
}
