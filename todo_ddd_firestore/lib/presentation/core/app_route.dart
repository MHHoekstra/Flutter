import 'package:auto_route/annotations.dart';

import '../auth/pages/sign_in_form_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SignInFormPage, initial: true),
  ],
)
class $AppRouter {}
