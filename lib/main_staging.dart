import 'package:flutter/widgets.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/view/app.dart';
import 'bootstrap.dart';
import 'feautres/authentication/provider/auth_provider.dart';
import 'feautres/theme/theme_data.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  bootstrap(() async {
    return ChangeNotifierProvider(
      create: (context) => ThemeNotifier(false),
      child: App(),
    );
  });
}
