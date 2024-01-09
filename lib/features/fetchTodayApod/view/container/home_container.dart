import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nasa_api/features/fetchTodayApod/bloc/apod_today_bloc.dart';
import 'package:nasa_api/features/fetchTodayApod/bloc/apod_today_event.dart';
import 'package:nasa_api/features/fetchTodayApod/bloc/apod_today_state.dart';
import 'package:nasa_api/features/fetchTodayApod/model/apod_repository.dart';
import 'package:nasa_api/features/fetchTodayApod/view/pages/apod_screen.dart';
import 'package:nasa_api/features/fetchTodayApod/view/pages/splash/loading_splash_screen.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key, required this.repository}) : super(key: key);
  final IApodRepository repository;

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  late final ApodBloc bloc;

  @override
  void initState() {
    bloc = ApodBloc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is ApodTodayInitialState) {
          bloc.add(LoadApodEvent());
          if (mounted) {
            return SplashLoadingScreen();
          }
          return const Center(child: Text('Erro ao carregar dados'));
        } else if (state is ApodTodayLoadingState) {
          if (mounted) {
            return SplashLoadingScreen();
          }
          return const Center(child: Text('Erro ao carregar dados'));
        } else if (state is ApodTodaySucessState) {
          return ApodScreen(data: state.apod);
        } else {
          return const Center(child: Text('Erro ao carregar dados'));
        }
      },
    );
  }
}
