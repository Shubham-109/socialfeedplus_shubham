import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:social/features/create_post/presentation/bloc/create_post_bloc.dart';
import 'di/injector.dart' as di;
import 'di/injector.dart';
import 'features/feeds/presentation/bloc/feeds_bloc.dart';
import 'features/feeds/presentation/bloc/feeds_event.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'firebase_options.dart';
import 'routes/app_router.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load();
  await di.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (_) => sl<LoginBloc>()),
        BlocProvider<FeedBloc>(create: (_) => sl<FeedBloc>()..add(FetchFeedsEvent())),
        BlocProvider<CreatePostBloc>(create: (_) => sl<CreatePostBloc>()),
      ],
      child: Social(),
    ),
  );
}

class Social extends StatelessWidget {
  const Social({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: generateRoute,
    );
  }
}
