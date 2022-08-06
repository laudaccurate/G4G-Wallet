// ignore_for_file: prefer_const_constructors
// @dart=2.9

import 'package:flutter/material.dart';
import 'package:gfg_wallet/provider/globals.dart';
import 'package:gfg_wallet/provider/phoneDetails.dart';
import 'package:gfg_wallet/provider/userProvider.dart';
import 'package:gfg_wallet/services/serviceLocator.dart';
import 'package:gfg_wallet/utils/connection_service.dart';
import 'package:gfg_wallet/utils/themes.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart' as path;
import 'package:provider/provider.dart';

import 'screens/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  // await Firebase.initializeApp();
  await setupLocator();
  final settings = await Hive.openBox('settings');
  bool isLightTheme = settings.get('isLightTheme') ?? false;

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              details.exceptionAsString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  };

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<Globals>.value(value: Globals()),
    ChangeNotifierProvider<PhoneInfo>.value(value: PhoneInfo()),
    ChangeNotifierProvider<UserProvider>.value(value: UserProvider()),
    ChangeNotifierProvider<ThemeProvider>.value(
        value: ThemeProvider(isLightTheme: isLightTheme)),
  ], child: AppStart()));
}

// to ensure we have the themeProvider before the app starts lets make a few more changes.
// ignore: use_key_in_widget_constructors
class AppStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MyApp(
      themeProvider: themeProvider,
    );
  }
}

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  final ThemeProvider themeProvider;
  const MyApp({Key key, @required this.themeProvider}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
        initialData: ConnectivityStatus.offline,
        create: (context) =>
            ConnectivityService().connectionStatusController.stream,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'G4G Wallet',
          theme: widget.themeProvider.themeData(),
          // home: LogoLoader(),
          home: SplashScreen(),
        ));
  }
}
