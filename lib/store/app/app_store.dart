import 'package:redux/redux.dart' as redux;
import 'package:redux_epics/redux_epics.dart';
import 'package:weshot/screens/auth/auth_epics.dart';
import 'package:weshot/screens/category/category_epics.dart';
import 'package:weshot/screens/category/category_reducer.dart';
import 'package:weshot/screens/explore/explore_screen_epics.dart';
import 'package:weshot/screens/explore/single_post/single_post_epics.dart';
import 'package:weshot/screens/filters/post_filters/post_filters_epics.dart';
import 'package:weshot/screens/filters/user_filters/user_filters_epics.dart';
import 'package:weshot/screens/mainlayout/components/notification_reducer.dart';
import 'package:weshot/screens/profile/profile_screen_epics.dart';
import 'package:weshot/screens/home/home_screen_epics.dart';
import 'package:weshot/screens/post/post_epics.dart';
import 'package:weshot/screens/settings/settings_reducer.dart';
import 'package:weshot/store/app/app_state.dart';
import 'package:weshot/screens/user/user_reducer.dart';
import 'package:weshot/screens/user/user_epics.dart';
import 'package:weshot/screens/home/home_screen_reducer.dart';
import 'package:weshot/screens/post/update_post_reducer.dart';
import 'package:weshot/screens/post/create_post_reducer.dart';
import 'package:weshot/screens/post/post_reducer.dart';
import 'package:weshot/screens/explore/explore_screen_reducer.dart';
import 'package:weshot/screens/explore/single_post/single_post_reducer.dart';
import 'package:weshot/screens/filters/post_filters/post_filters_reducer.dart';
import 'package:weshot/screens/filters/user_filters/user_filters_reducer.dart';
import 'package:weshot/screens/profile/profile_screen_reducer.dart';


GlobalState appStateReducer(GlobalState state, action) => GlobalState(
  appState: AppState(
    userState: userReducer(state.appState.userState, action),
    homeScreenState: homeScreenReducer(state.appState.homeScreenState, action),
    postState: postReducer(state.appState.postState, action),
    exploreScreenState: exploreScreenReducer(state.appState.exploreScreenState, action),
    singlePostScreenState: singlePostScreenReducer(state.appState.singlePostScreenState, action),
    createPostState: createPostReducer(state.appState.createPostState, action),
    updatePostState: updatePostReducer(state.appState.updatePostState, action),
    postFiltersState: postFiltersReducer(state.appState.postFiltersState, action),
    userFiltersState: userFiltersReducer(state.appState.userFiltersState, action),
    profileScreenState: profileScreenReducer(state.appState.profileScreenState, action),
    awesomeNotificationState: awesomeNotificationReducer(state.appState.awesomeNotificationState, action),
    categoryState: categoryReducer(state.appState.categoryState, action),
    settingsState: settingsReducer(state.appState.settingsState, action),
  ));

class GlobalState {
  AppState appState;

  GlobalState({required this.appState});
}

final epic = combineEpics<GlobalState>([
  ...userEffects,
  ...homeScreenEffects,
  ...postEffects,
  ...exploreScreenEffects,
  ...singlePostEffects,
  ...filterUsersEffects,
  ...filterPostsEffects,
  ...authEffects,
  ...profileScreenEffects,
  ...categoryEffects,
]);

final epicMiddleware = EpicMiddleware<GlobalState>(epic);

final initialState = GlobalState(
  appState: AppState(
    userState: UserState(),
    homeScreenState: HomeScreenState(),
    postState: PostState(),
    exploreScreenState: ExploreScreenState(),
    singlePostScreenState: SinglePostScreenState(),
    createPostState: CreatePostState.initial(),
    updatePostState: UpdatePostState(),
    postFiltersState: PostFiltersState(),
    userFiltersState: UserFiltersState(),
    profileScreenState: ProfileScreenState(),
    awesomeNotificationState: AwesomeNotificationState.initialState(),
    categoryState: CategoryState(),
    settingsState: SettingsState(),
));

var store = redux.Store<GlobalState>(appStateReducer,
  middleware: [epicMiddleware], initialState: initialState);