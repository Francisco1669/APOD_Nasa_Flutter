import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_api/features/fetchTodayApod/bloc/apod_today_bloc.dart';
import 'package:nasa_api/features/fetchTodayApod/bloc/apod_today_event.dart';
import 'package:nasa_api/features/fetchTodayApod/bloc/apod_today_state.dart';
import 'package:nasa_api/features/fetchTodayApod/model/apod.dart';
import 'package:nasa_api/features/fetchTodayApod/view/pages/apod_screen.dart';

class FetchDateContainer extends StatefulWidget {
  const FetchDateContainer({Key? key, required this.apod}) : super(key: key);
  final ApodModel apod;

  @override
  State<FetchDateContainer> createState() => _FetchDateContainerState();
}

class _FetchDateContainerState extends State<FetchDateContainer> {
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


// FutureBuilder(
//       future: widget.repository.getTodayApod(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasData) {
//             return ApodScreen(data: snapshot.data!);
//           } else {
//             return Center(child: Text('Dados não disponíveis'));
//           }
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );