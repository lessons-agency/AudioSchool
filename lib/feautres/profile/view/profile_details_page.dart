import 'package:audio_school/feautres/authentication/widget/login_widget.dart';
import 'package:audio_school/feautres/navigation/nav.dart';
import 'package:audio_school/feautres/profile/profile.dart';
import 'package:audio_school/feautres/profile/view/profile_details_view.dart';
import 'package:audio_school/feautres/theme/theme_data.dart';

import 'package:flutter/material.dart';

import '../../../api/api.dart';

class ProfileDetailsPage extends StatelessWidget {
  final Map<String, dynamic> userData;
  final String authToken;
  ProfileDetailsPage({required this.userData, required this.authToken});

  // final Widget accountIcon;

  @override
  Widget build(BuildContext context) {
    final bool isThemeDark = isDark(context);
    return Scaffold(
      // // bottomNavigationBar: MyBottomNavigationBar(),
      backgroundColor: isThemeDark ? darkBG : lightBG,

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            int _currentIndex = 3;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NavPage(
                      userData: userData,
                      apiToken: token as String,
                    )));
          },
        ),
        iconTheme: IconThemeData(color: isThemeDark ? lightBG : blueMainDark),
        backgroundColor: isThemeDark ? darkBG : lightBG,
        elevation: 0.0,
        centerTitle: false,
        title: Text(
          'Назад',
          style: TextStyle(color: isThemeDark ? lightBG : darkBG),
        ),
      ),
      body: ProfileDetailsView(
        userData: userData,
        authToken: authToken,
      ),
    );
  }
}
