import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social/features/create_post/data/datasources/create_post_remote_data_source.dart';
import 'package:social/features/feeds/data/datasources/feeds_remote_data_source.dart';
import 'package:social/features/feeds/domain/repositories/feeds_repository.dart';
import 'package:social/features/feeds/domain/usecases/get_comments_usecase.dart';
import 'package:social/features/login/data/datasources/auth_local_data_source.dart';
import 'package:social/features/login/domain/usecases/login_usecase.dart';
import 'package:social/features/login/presentation/bloc/login_bloc.dart';

import '../features/create_post/data/repositories/create_post_repository_impl.dart';
import '../features/create_post/domain/repositories/create_post_repository.dart';
import '../features/create_post/domain/usecases/generate_captions_usecase.dart';
import '../features/create_post/domain/usecases/upload_image_usecase.dart';
import '../features/create_post/domain/usecases/upload_post_usecase.dart';
import '../features/create_post/presentation/bloc/create_post_bloc.dart';
import '../features/feeds/data/repositories/feeds_repository_impl.dart';
import '../features/feeds/domain/usecases/add_comment_usecase.dart';
import '../features/feeds/domain/usecases/fetch_posts_usecase.dart';
import '../features/feeds/domain/usecases/like_posts_usescase.dart';
import '../features/feeds/presentation/bloc/feeds_bloc.dart';
import '../features/login/data/repositories/auth_repository_impl.dart';
import '../features/login/domain/repositories/auth_repository.dart';
import '../features/login/domain/usecases/check_login_status_usecase.dart';
import '../features/login/domain/usecases/logout_usecase.dart';

final sl = GetIt.instance; // sl = service locator

Future<void> init() async {
  // 🔹 Firebase Core Services
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  sl.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());

  sl.registerLazySingleton<CreatePostRemoteDataSource>(() => CreatePostRemoteDataSourceImpl(firestore: sl(), storage: sl()));
  sl.registerLazySingleton<FeedRemoteDataSource>(() => FeedRemoteDataSourceImpl(firestore: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(storage: sl()));

  // 🔹 Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<CreatePostRepository>(() => CreatePostRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<FeedRepository>(() => FeedRepositoryImpl(remoteDataSource: sl(), authRepository: sl()));

  // 🔹 Use Cases
  sl.registerLazySingleton(() => CheckLoginStatusUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  sl.registerLazySingleton(() => GenerateCaptionUseCase(sl()));
  sl.registerLazySingleton(() => UploadImageUseCase(sl()));
  sl.registerLazySingleton(() => UploadPostUseCase(sl(), sl()));

  sl.registerLazySingleton(() => FetchFeedsUseCase(sl()));
  sl.registerLazySingleton(() => LikeFeedUseCase(sl()));
  sl.registerLazySingleton(() => FetchCommentsUseCase(sl()));
  sl.registerLazySingleton(() => AddCommentUseCase(sl()));

  // 🔹 BLoC
  sl.registerFactory(() => LoginBloc(loginUseCase: sl(), checkLoginStatusUseCase: sl(), logoutUseCase: sl()));
  sl.registerFactory(() => CreatePostBloc(generateCaptionUseCase: sl(), uploadPostUseCase: sl(), uploadImageUseCase: sl()));
  sl.registerFactory(() => FeedBloc(fetchFeedsUseCase: sl(), likeFeedUseCase: sl(), addCommentUseCase: sl(), fetchCommentsUseCase: sl()));
}
