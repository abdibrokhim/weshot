import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:weshot/components/shared/toast.dart';
import 'package:weshot/screens/auth/forgotpassword/forgot_password_screen.dart';
import 'package:weshot/screens/auth/signin/signin_screen.dart';
import 'package:weshot/screens/auth/signup/signup_screen.dart';
import 'package:weshot/screens/explore/explore_screen.dart';
import 'package:weshot/screens/explore/single_post/single_post_screen.dart';
import 'package:weshot/screens/filters/filter_screen.dart';
import 'package:weshot/screens/home/home_screen.dart';
import 'package:weshot/screens/profile/profile_screen.dart';
import 'package:weshot/screens/profile/profile_screen_reducer.dart';
import 'package:weshot/screens/settings/settings_screen.dart';
import 'package:weshot/screens/user/user_reducer.dart';
import 'package:weshot/store/app/app_state.dart';
import 'package:weshot/store/app/app_store.dart';
import 'package:weshot/utils/logs.dart';


class MainLayout extends StatefulWidget {

  const MainLayout({
    Key? key,
  }) : super(key: key);

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  bool _isNavigationVisible = false;


  @override
  void initState() {
    super.initState();
  }

  Future<bool> hasInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }


  Widget _getContent(BuildContext context) {
    
    var state = StoreProvider.of<GlobalState>(context);

    AppLog.log().i('Test print from MainLayout');
    if (state.state.appState.userState.showSinglePostScreen && state.state.appState.userState.selectedPostId != null) {
      return const SinglePostScreen();
    }
    if (state.state.appState.profileScreenState.showUserProfileScreen && (state.state.appState.profileScreenState.selectedUserId != null || state.state.appState.userState.userId != null)) {
      return const ProfileScreen();
    }

    if (!state.state.appState.userState.isLoggedIn) {
      if (state.state.appState.userState.showSignUpScreen) {
        return const SignUpScreen();
      } else if (state.state.appState.userState.showForgotPasswordScreen) {
        return const ForgotPasswordScreen();
      }

      switch (_selectedIndex) {
        case 0:
          return const HomeScreen();
        case 1:
          return const FilterScreen();
        case 2:
          return const ExploreScreen();
        default:
          return const SignInScreen();
      }
    } else {
      switch (_selectedIndex) {
        case 0:
          return const HomeScreen();
        case 1:
          return const FilterScreen();
        case 2:
          return const ExploreScreen();
        case 3:
          return ProfileScreen(userId: store.state.appState.userState.userId);
        case 4:
          return const SettingsScreen();
        default:
          return const HomeScreen();
      }
    }
  }

  void _onTabSelected(int index) {
    store.dispatch(SinglePostBackAction());
    store.dispatch(ResetAuthScreensRequestAction());
    store.dispatch(HideUserProfileRequestAction());
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      if (_selectedIndex == 3 && store.state.appState.userState.userId != null && store.state.appState.userState.isLoggedIn) {
        print('user id: ${store.state.appState.userState.userId}');
        store.dispatch(ShowUserProfileRequestAction(store.state.appState.userState.userId!));
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    // var state = StoreProvider.of<GlobalState>(context);

        return
        Scaffold(
          body: 
                StoreConnector<GlobalState, AppState>(
                  onDidChange: (prev, next) {
                    if (next.profileScreenState.selectedUserId == prev!.userState.userId && next.profileScreenState.showUserProfileScreen && next.userState.isLoggedIn) {
                      // if (next.profileScreenState.selectedUserId != null) {
                      //   store.dispatch(GetUserAction(next.profileScreenState.selectedUserId!));
                      // }
                      Future.microtask(() => 
                        setState(() {
                          _selectedIndex = 3;
                        })
                      );
                    }
                  },
                  onInit: (app) {
                    print('test print from onInit main layout screen');
                    if (store.state.appState.userState.isLoggedIn && store.state.appState.userState.userId != null && store.state.appState.userState.accessToken != null) {
                      print('getting user access token');
                      store.dispatch(GetUserAccessTokenAction());
                    }
                    if (store.state.appState.userState.userId != null) {
                      AppLog.log().i('onInit');
                      print('getting user small ');
                      store.dispatch(GetUserAction(store.state.appState.userState.userId!));
                      AppLog.log().i('User is logged in: ${store.state.appState.userState.user!.username}');
                      AppLog.log().i('User access token: ${store.state.appState.userState.accessToken}');
                      AppLog.log().i('User refresh token: ${store.state.appState.userState.refreshToken}');
                    }
                    hasInternet().then((value) {
                      if (value) {
                        AppLog.log().i('Internet is available');
                      } else {
                        AppLog.log().i('No internet');
                        showToast(message: 'No internet connection', bgColor: Colors.red, webBgColor: 'red',);
                      }
                    });
                  },
                  converter: (store) => store.state.appState,
                  builder: (context, appState) {
                    return
                            _getContent(context);
                  },
                ),
          bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_rounded),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
        type: BottomNavigationBarType.fixed, // Use fixed for 3+ items
      ),
        );
  }
}
