import 'package:audio_school/feautres/home/widget/book_list.dart';
import 'package:audio_school/feautres/home/widget/class_button.dart';
import 'package:audio_school/feautres/profile/widgets/profile_details.dart';
import 'package:audio_school/feautres/theme/theme_data.dart';
import 'package:audio_school/feautres/library/widgets/library_book.dart';
import 'package:audio_school/feautres/library/widgets/library_button.dart';
import 'package:flutter/material.dart';

import '../widgets/profile_tabs.dart';
import '../widgets/user_status.dart';

class ProfileDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isThemeDark = isDark(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileDetails(),
        ],
      ),
    );
  }
}