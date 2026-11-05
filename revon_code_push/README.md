# Revon code push

[![License: MIT][license_badge]][license_link]

This Dart package talks to the Revon code push updater inside the Revon Flutter
engine, so your app can:

- ✅ Get the currently installed patch version
- ✅ Check whether a new patch is available
- ✅ Download new patches

## Getting started

Release your app with the `revon` CLI first (`revon init`, then
`revon release android`).

## Installation

This package is not published to pub.dev. Add it from a checkout of the Revon
updater repository:

```yaml
dependencies:
  revon_code_push:
    path: <updater checkout>/revon_code_push
```

## Usage

Revon automatically checks for and downloads updates in the background.
Most apps do not need this package. This package is for apps that want
additional control, such as displaying update status to the user or prompting
before downloading.

**Important:** `checkForUpdate()` and `update()` make network calls that may
be slow. Avoid gating app startup on the result (e.g. awaiting in `initState`),
as the app may appear stuck on the splash screen. Use `.then()` instead.

```dart
import 'package:revon_code_push/revon_code_push.dart';

void main() => runApp(const MyApp());

// [Other code here]

class _MyHomePageState extends State<MyHomePage> {
  final updater = RevonUpdater();
  Patch? _currentPatch;
  bool _updateAvailable = false;

  @override
  void initState() {
    super.initState();

    // Read the current patch number (null if no patch is installed).
    updater.readCurrentPatch().then((patch) {
      setState(() => _currentPatch = patch);
    });

    // Check if an update is available to show in the UI.
    updater.checkForUpdate().then((status) {
      setState(() => _updateAvailable = status == UpdateStatus.outdated);
    });
  }

  // [Other code here]
}
```

See the example for a complete working app.

### Tracks

Revon supports publishing patches to different tracks, which can be
used to target different segments of your user base.

You must first publish a patch to a specific track (patches are published to the
`stable` track by default). To publish a patch to a different track, update your
patch command to use the `--track` argument:

```sh
revon patch android --track beta
```

(The Revon toolchain currently supports Android only.)

To check for updates on a given track, pass an `UpdateTrack` to
`checkForUpdate` (and `update` if you use it):

```dart
updater.checkForUpdate(track: UpdateTrack.beta);
```

You can also use custom track names. When creating a patch, specify a track name
like this:

```sh
revon patch android --track my-custom-track
```

And:

```dart
updater.checkForUpdate(track: UpdateTrack('my-custom-track'));
```

**Note:** Updating to a specific track does not uninstall patches from other
tracks (upstream issue 3484).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
