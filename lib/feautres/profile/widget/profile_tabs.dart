import 'package:audio_school/feautres/profile/widget/empty_tabs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../api/api.dart';
import '../../authentication/provider/login_helper.dart';
import '../../authentication/view/login_page.dart';
import '../../theme/theme_data.dart';
import '../view/profile_details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileTabs extends StatefulWidget {
  const ProfileTabs({Key? key}) : super(key: key);
  @override
  _ProfileTabsState createState() => _ProfileTabsState();
}

class _ProfileTabsState extends State<ProfileTabs> {
  int _selectedIndex = 0;
  bool _switchValue = false;
  IconData _darkModeIcon = Icons.nightlight_outlined;
  String _darkModeText = 'Нічна тема';

  final List<Map<String, dynamic>> _tabs = [
    {
      'icon': Icons.person_outline,
      'text': 'Деталі профілю',
      'hasSwitch': false,
      'routeName': '/details',
    },
    {
      'icon': Icons.add_card,
      'text': 'Оплата',
      'hasSwitch': false,
      'routeName': '/payment',
    },
    {
      'icon': Icons.star_border,
      'text': 'Підписка',
      'hasSwitch': false,
      'routeName': '/subscription',
    },
    {
      'icon': Icons.theater_comedy_outlined,
      'text': 'Стати частиною команди',
      'hasSwitch': false,
      'routeName': '/team',
    },
    {
      'icon': Icons.contact_support_outlined,
      'text': 'Підтримка',
      'hasSwitch': false,
      'routeName': '/support',
    },
    {
      'icon': Icons.nightlight_outlined,
      'text': 'Нічна тема',
      'hasSwitch': true,
      'routeName': '/dark_mode',
    },
    {
      'icon': Icons.logout,
      'text': 'Вийти',
      'hasSwitch': false,
      'routeName': '/logout',
    },
  ];

void _logout() async {
  try {
    await FirebaseAuth.instance.signOut(); // Sign out with Firebase

    // Optionally clear any other local user data here...
    // For example, clear API tokens and set the user as not logged in
    await LoginHelper().removeApiToken();
    await LoginHelper().setIsUserLoggedIn(false);

    // Then navigate to the login page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,  // remove all previous routes
    );
  } catch (e) {
    // Handle any errors signing out
    print('Error while signing out: $e');
  }
}

  void _toggleTheme(BuildContext context, bool value) {
    Provider.of<ThemeNotifier>(context, listen: false).setTheme(value);
  }

  void _toggleThemes(BuildContext context) {
    Provider.of<ThemeModel>(context, listen: false).toggleTheme();
  }

// Inside onPressed function:

  @override
  Widget build(BuildContext context) {
    bool isThemeDark = isDark(context);
    bool _switchValue = Provider.of<ThemeNotifier>(context).isDarkTheme;
    if (_switchValue) {
      _darkModeIcon = Icons.light_mode_outlined;
      _darkModeText = 'Денна тема';
    } else {
      _darkModeIcon = Icons.nightlight_outlined;
      _darkModeText = 'Нічна тема';
    }
    return Column(
      children: [
        for (int i = 0; i < _tabs.length; i++)
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedIndex = i;
                if (_tabs[i]['routeName'] == '/logout') {
                  _logout();
                } else if (_tabs[i]['routeName'] == '/details') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileDetailsPage(
                        // userData: userData,
                        // token: token as String,
                      ),
                    ),
                  );
                } else if (_tabs[i]['routeName'] == '/support') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmptyTabs(
                        tabName: Text('Підтримка',
                            style: TextStyle(
                                fontSize: 24.0,
                                color: isThemeDark ? lightBG : blueMainDark)),
                      ),
                    ),
                  );
                } else if (_tabs[i]['routeName'] == '/payment') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmptyTabs(
                        tabName: Text('Оплата',
                            style: TextStyle(
                                fontSize: 24.0,
                                color: isThemeDark ? lightBG : blueMainDark)),
                      ),
                    ),
                  );
                } else if (_tabs[i]['routeName'] == '/team') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmptyTabs(
                        tabName: Text('Команда',
                            style: TextStyle(
                                fontSize: 24.0,
                                color: isThemeDark ? lightBG : blueMainDark)),
                      ),
                    ),
                  );
                } else if (_tabs[i]['routeName'] == '/subscription') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmptyTabs(
                        tabName: Text('Підписка',
                            style: TextStyle(
                                fontSize: 24.0,
                                color: isThemeDark ? lightBG : blueMainDark)),
                      ),
                    ),
                  );
                } else {
                  _switchValue = !_switchValue;
                  if (_switchValue) {
                    _darkModeIcon = Icons.light_mode_outlined;
                    _darkModeText = 'Денна тема';
                  } else {
                    _darkModeIcon = Icons.nightlight_outlined;
                    _darkModeText = 'Нічна тема';
                  }
                  _toggleTheme(context, _switchValue);
                }
              });
            },
            style: ElevatedButton.styleFrom(
              primary: isThemeDark ? darkBG : lightBG,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
            ),
            child: Row(
              children: [
                Icon(
                  i == 5 ? _darkModeIcon : _tabs[i]['icon'] as IconData,
                  size: 24.0,
                  color: isThemeDark ? yellowMain : blueMain,
                ),
                SizedBox(width: 24.0),
                Text(
                  i == 5 ? _darkModeText : _tabs[i]['text'] as String,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: isThemeDark ? lightBG : blueMainDark),
                ),
                Spacer(),
                if (_tabs[i]['hasSwitch'] as bool)
                  Switch(
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value;
                        if (value) {
                          _tabs[i]['icon'] = Icons.light_mode_outlined;
                          _tabs[i]['text'] = 'Денна тема';
                        } else {
                          _tabs[i]['icon'] = Icons.nightlight_outlined;
                          _tabs[i]['text'] = 'Нічна тема';
                        }
                      });
                      _toggleTheme(context, value);
                    },
                    activeColor: isThemeDark ? yellowMain : blueMain,
                  )
                else
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16.0,
                    color: isThemeDark ? greyNavLight : greyNavLight,
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
