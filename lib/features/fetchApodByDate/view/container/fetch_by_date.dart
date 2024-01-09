import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_api/features/fetchTodayApod/bloc/apod_today_bloc.dart';
import 'package:nasa_api/features/fetchTodayApod/bloc/apod_today_event.dart';
import 'package:nasa_api/features/fetchTodayApod/bloc/apod_today_state.dart';
import 'package:nasa_api/features/fetchTodayApod/model/apod.dart';
import 'package:nasa_api/features/fetchTodayApod/view/pages/apod_screen.dart';

class FetchByDateContainer extends StatefulWidget {
  const FetchByDateContainer({Key? key, required this.apod}) : super(key: key);
  final ApodModel apod;

  @override
  State<FetchByDateContainer> createState() => _FetchByDateContainerState();
}

class _FetchByDateContainerState extends State<FetchByDateContainer> {
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
          return const Center(child: CircularProgressIndicator());
        } else if (state is ApodTodayLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ApodTodaySucessState) {
          return ApodScreen(data: widget.apod);
        } else {
          return const Center(child: Text('Erro ao carregar dados'));
        }
      },
    );
  }
}
