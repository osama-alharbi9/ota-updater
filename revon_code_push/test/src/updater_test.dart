import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:mocktail/mocktail.dart';
import 'package:revon_code_push/revon_code_push.dart';
import 'package:revon_code_push/src/generated/updater_bindings.g.dart';
import 'package:revon_code_push/src/updater.dart';
import 'package:test/test.dart';

class _MockUpdaterBindings extends Mock implements UpdaterBindings {}

void main() {
  group(Updater, () {
    late UpdaterBindings updaterBindings;
    late Updater updater;

    setUpAll(() {
      registerFallbackValue(Pointer.fromAddress(0));
    });

    setUp(() {
      updaterBindings = _MockUpdaterBindings();

      updater = const Updater();
      Updater.bindings = updaterBindings;
    });

    test('initializes from currently loaded library', () {
      expect(updater, isNotNull);
    });

    group('currentPatchNumber', () {
      test('forwards the result of revon_next_boot_patch_number', () {
        when(
          () => updaterBindings.revon_current_boot_patch_number(),
        ).thenReturn(123);
        final currentPatchNumber = updater.currentPatchNumber();
        expect(currentPatchNumber, 123);
      });
    });

    group('checkForDownloadableUpdate', () {
      test('forwards the result of revon_check_for_update', () {
        when(
          () => updaterBindings.revon_check_for_downloadable_update(
            nullptr,
          ),
        ).thenReturn(true);
        expect(updater.checkForDownloadableUpdate(), isTrue);

        when(
          () => updaterBindings.revon_check_for_downloadable_update(
            nullptr,
          ),
        ).thenReturn(false);
        expect(updater.checkForDownloadableUpdate(), isFalse);
      });

      group('when a track is provided', () {
        setUp(() {
          when(
            () => updaterBindings.revon_check_for_downloadable_update(
              any(),
            ),
          ).thenReturn(true);
        });

        test('forwards the result of revon_check_for_update', () {
          expect(
            updater.checkForDownloadableUpdate(track: UpdateTrack.beta),
            isTrue,
          );

          expect(
            updater.checkForDownloadableUpdate(track: UpdateTrack.stable),
            isTrue,
          );

          final captured = verify(
            () => updaterBindings.revon_check_for_downloadable_update(
              captureAny(),
            ),
          ).captured;
          expect(
            captured.map(
              (cstr) => (cstr as Pointer<Char>).cast<Utf8>().toDartString(),
            ),
            equals(['beta', 'stable']),
          );
        });
      });
    });

    group('nextPatchNumber', () {
      test('forwards the result of revon_next_boot_patch_number', () {
        when(
          () => updaterBindings.revon_next_boot_patch_number(),
        ).thenReturn(123);
        final currentPatchNumber = updater.nextPatchNumber();
        expect(currentPatchNumber, 123);
      });
    });

    group('downloadUpdate', () {
      test('calls bindings.revon_update', () {
        when(() => updaterBindings.revon_update()).thenReturn(null);
        updater.downloadUpdate();
        verify(() => updaterBindings.revon_update()).called(1);
      });
    });

    group('update', () {
      test('calls bindings.revon_update_with_result', () {
        when(
          () => updaterBindings.revon_update_with_result(nullptr),
        ).thenReturn(nullptr);
        updater.update();
        verify(
          () => updaterBindings.revon_update_with_result(nullptr),
        ).called(1);
      });
    });

    group('freeUpdateResult', () {
      test('calls bindings.revon_free_update_result', () {
        final result = calloc.allocate<UpdateResult>(sizeOf<UpdateResult>());
        updater.freeUpdateResult(result);
        verify(
          () => updaterBindings.revon_free_update_result(any()),
        ).called(1);
      });
    });
  });
}
