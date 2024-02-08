import "dart:async";
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weshot/components/shared/error/custom_error_dialog.dart';
import 'package:weshot/screens/settings/settings_screen.dart';
import 'package:weshot/store/app/app_store.dart';
import 'package:weshot/utils/env.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:weshot/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'package:weshot/utils/extensions.dart';
import 'package:weshot/screens/splash/splash_screen.dart';
import 'package:weshot/utils/payment/stripe/stripe_platform.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';


const Color themeColor = Color(0xff00bc56);

String? packageVersion;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  await StripeInterface.initStripe();

  
  runApp(const MainApp());
  
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
  );
  AssetPicker.registerObserve();
  PhotoManager.setLog(true);
}


class MainApp extends StatelessWidget {

  const MainApp({
    super.key,
  });

  ThemeData _buildTheme(Brightness brightness) {
    return ThemeData(
      brightness: brightness,
      primarySwatch: themeColor.swatch,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: themeColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<GlobalState>(
      store: store,
      child:  RefreshConfiguration(
        child:
        StoreConnector<GlobalState, ThemeMode>(
              onInit: (store) {
              },
              converter: (store) => store.state.appState.settingsState.theme,
              builder: (context, profileScreenState) {
                return
      MaterialApp(
        localizationsDelegates: const [
              RefreshLocalizations.delegate,
            ],
        onGenerateTitle: (context) => 'WeShot',
        theme: ThemeData(),
        darkTheme: _buildTheme(Brightness.dark),
        themeMode: store.state.appState.settingsState.theme,
        initialRoute: AppRoutes.init,
        routes: AppRoutes.getRoutes(),
        title: Environments.appName,
        debugShowCheckedModeBanner: Environments.showDebugBanner == "true",
        home: const SplashScreen(),
        builder: (BuildContext c, Widget? w) {
          return ScrollConfiguration(
            behavior: const NoGlowScrollBehavior(),
            child: w!,
          );
        },
      );
              },
              onDispose: (store) {},
        )
      ),
    );
  }
}

class NoGlowScrollBehavior extends ScrollBehavior {
  const NoGlowScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) =>
      child;
}


Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
}


