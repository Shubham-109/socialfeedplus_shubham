import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/core/constants/app_strings.dart';
import '../../../../routes/app_router.dart';
import '../../../login/presentation/bloc/login_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<LoginBloc>().add(CheckLoginStatus());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, AppRoutes.feeds);
          }
          if (state is LoginInitial) {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          }
        },
        child: Center(child: Text(AppStrings.appName)),
      ),
    );
  }
}
