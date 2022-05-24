import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'themes.dart';
import 'routes.dart';
import '/login/login.dart';

class App extends StatelessWidget {

  const App({
    required this.loginRepository
  });

  final LoginRepository loginRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: loginRepository)
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AuthBloc(loginRepository: loginRepository)..add(AppStarted())
            )
          ],
          child: AppView(),
        )
    );
  }

}

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noteday',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routes: AppRouter.routes,
      initialRoute: AppRouter.initialRoute,
      onUnknownRoute: AppRouter.unknownRoute,
    );
  }
}