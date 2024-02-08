import 'package:weshot/screens/category/category_reducer.dart';
import 'package:weshot/screens/filters/post_filters/post_filters_reducer.dart';
import 'package:weshot/screens/filters/user_filters/user_filters_reducer.dart';
import 'package:weshot/screens/mainlayout/components/notification_reducer.dart';
import 'package:weshot/screens/settings/settings_reducer.dart';
import 'package:weshot/screens/user/user_reducer.dart';
import 'package:weshot/screens/home/home_screen_reducer.dart';
import 'package:weshot/screens/post/update_post_reducer.dart';
import 'package:weshot/screens/post/create_post_reducer.dart';
import 'package:weshot/screens/post/post_reducer.dart';
import 'package:weshot/screens/explore/explore_screen_reducer.dart';
import 'package:weshot/screens/explore/single_post/single_post_reducer.dart';
import 'package:weshot/screens/profile/profile_screen_reducer.dart';

class AppState {
  final UserState userState;
  final HomeScreenState homeScreenState;
  final PostState postState;
  final ExploreScreenState exploreScreenState;
  final SinglePostScreenState singlePostScreenState;
  final CreatePostState createPostState;
  final UpdatePostState updatePostState;
  final PostFiltersState postFiltersState;
  final UserFiltersState userFiltersState;
  final ProfileScreenState profileScreenState;
  final AwesomeNotificationState awesomeNotificationState;
  final CategoryState categoryState;
  final SettingsState settingsState;
  

  AppState({
    required this.userState,
    required this.homeScreenState,
    required this.postState,
    required this.exploreScreenState,
    required this.singlePostScreenState,
    required this.createPostState,
    required this.updatePostState,
    required this.postFiltersState,
    required this.userFiltersState,
    required this.profileScreenState,
    required this.awesomeNotificationState,
    required this.categoryState,
    required this.settingsState,
  });
}