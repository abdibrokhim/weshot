import 'package:flutter/material.dart';
import 'package:weshot/screens/auth/forgotpassword/forgot_password_screen.dart';
import 'package:weshot/screens/auth/signin/signin_screen.dart';
import 'package:weshot/screens/auth/signup/signup_screen.dart';
import 'package:weshot/screens/explore/explore_screen.dart';
import 'package:weshot/screens/filters/filter_screen.dart';
import 'package:weshot/screens/home/home_screen.dart';
import 'package:weshot/screens/profile/profile_screen.dart';
import 'package:weshot/screens/explore/single_post/single_post_screen.dart';


class AppRoutes {
  static const String init = '/';
  static const String home = '/home';
  static const String explore = '/explore';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String signOut = '/signOut';
  static const String profile = '/profile';
  static const String filter = '/filter';
  static const String singlePost = '/singlePost';
  static const String forgotPassword = '/forgotPassword';

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      home: (context) => const HomeScreen(),
      signIn: (context) => const SignInScreen(),
      signUp: (context) => const SignUpScreen(),
      explore: (context) => const ExploreScreen(),
      profile: (context) => const ProfileScreen(),
      filter: (context) => const FilterScreen(),
      singlePost: (context) => const SinglePostScreen(),
      forgotPassword:(context) => const ForgotPasswordScreen(),
    };
  }
}
