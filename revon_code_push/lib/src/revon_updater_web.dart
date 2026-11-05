import 'package:revon_code_push/src/revon_updater.dart';

/// {@template revon_updater_web}
/// The Revon web updater.
/// {@endtemplate}
class RevonUpdaterImpl implements RevonUpdater {
  /// {@macro revon_updater_web}
  RevonUpdaterImpl() {
    logRevonEngineUnavailableMessage();
  }

  @override
  bool get isAvailable => false;

  @override
  Future<Patch?> readCurrentPatch() async => null;

  @override
  Future<Patch?> readNextPatch() async => null;

  @override
  Future<UpdateStatus> checkForUpdate({UpdateTrack? track}) async =>
      UpdateStatus.unavailable;

  @override
  Future<void> update({UpdateTrack? track}) async {}
}
