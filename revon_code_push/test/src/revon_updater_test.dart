import 'package:revon_code_push/revon_code_push.dart';
import 'package:test/test.dart';

import '../override_print.dart';

void main() {
  group(RevonUpdater, () {
    test(
      'can be instantiated',
      overridePrint((_) {
        expect(RevonUpdater.new, returnsNormally);
      }),
    );

    group(UpdateException, () {
      test('overrides toString', () {
        const message = 'message';
        const reason = UpdateFailureReason.downloadFailed;
        const exception = UpdateException(message: message, reason: reason);
        expect(
          exception.toString(),
          equals(
            '[RevonUpdater] UpdateException: $message (${reason.name})',
          ),
        );
      });
    });

    group(ReadPatchException, () {
      test('overrides toString', () {
        const message = 'message';
        const exception = ReadPatchException(message: message);
        expect(
          exception.toString(),
          equals('[RevonUpdater] ReadPatchException: $message'),
        );
      });
    });
  });
}
