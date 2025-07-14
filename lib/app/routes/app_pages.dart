import 'package:get/get.dart';

import '../modules/admin/admin_blogs/bindings/admin_blogs_binding.dart';
import '../modules/admin/admin_blogs/views/admin_blogs_view.dart';
import '../modules/admin/admin_category/bindings/admin_category_binding.dart';
import '../modules/admin/admin_category/views/admin_category_view.dart';
import '../modules/admin/admin_create_blogs/bindings/admin_create_blogs_binding.dart';
import '../modules/admin/admin_create_blogs/views/admin_create_blogs_view.dart';
import '../modules/admin/admin_dashboard/bindings/admin_dashboard_binding.dart';
import '../modules/admin/admin_dashboard/views/admin_dashboard_view.dart';
import '../modules/admin/admin_main/bindings/admin_main_binding.dart';
import '../modules/admin/admin_main/views/admin_main_view.dart';
import '../modules/admin/admin_profile/bindings/admin_profile_binding.dart';
import '../modules/admin/admin_profile/views/admin_profile_view.dart';
import '../modules/admin/admin_update_blogs/bindings/admin_update_blogs_binding.dart';
import '../modules/admin/admin_update_blogs/views/admin_update_blogs_view.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/register/bindings/register_binding.dart';
import '../modules/auth/register/views/register_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/users/detail_blogs/bindings/detail_blogs_binding.dart';
import '../modules/users/detail_blogs/views/detail_blogs_view.dart';
import '../modules/users/home/bindings/home_binding.dart';
import '../modules/users/home/views/home_view.dart';
import '../modules/users/main/bindings/main_binding.dart';
import '../modules/users/main/views/main_view.dart';
import '../modules/users/profile/bindings/profile_binding.dart';
import '../modules/users/profile/views/profile_view.dart';
import '../modules/users/reels/bindings/reels_binding.dart';
import '../modules/users/reels/views/reels_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REELS,
      page: () => ReelsView(),
      binding: ReelsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_BLOGS,
      page: () => const DetailBlogsView(),
      binding: DetailBlogsBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_BLOGS,
      page: () => const AdminBlogsView(),
      binding: AdminBlogsBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_PROFILE,
      page: () => AdminProfileView(),
      binding: AdminProfileBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_MAIN,
      page: () => AdminMainView(),
      binding: AdminMainBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_CATEGORY,
      page: () => const AdminCategoryView(),
      binding: AdminCategoryBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_DASHBOARD,
      page: () => const AdminDashboardView(),
      binding: AdminDashboardBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_CREATE_BLOGS,
      page: () => const AdminCreateBlogsView(),
      binding: AdminCreateBlogsBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_UPDATE_BLOGS,
      page: () => const AdminUpdateBlogsView(),
      binding: AdminUpdateBlogsBinding(),
    ),
  ];
}
