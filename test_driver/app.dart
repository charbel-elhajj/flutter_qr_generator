import 'package:flutter_driver/driver_extension.dart';

import 'package:flutter_qr_generator/main.dart' as app;

void main() {
  // This line enables the flutter driver extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
