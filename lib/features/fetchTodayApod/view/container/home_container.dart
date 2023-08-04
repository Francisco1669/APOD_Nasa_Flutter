import 'package:flutter/material.dart';
import 'package:nasa_api/features/fetchTodayApod/bloc/apod_today_bloc.dart';
import 'package:nasa_api/features/fetchTodayApod/bloc/apod_today_event.dart';
import 'package:nasa_api/features/fetchTodayApod/bloc/apod_today_state.dart';
import 'package:nasa_api/features/fetchTodayApod/model/apod_repository.dart';
import 'package:nasa_api/features/fetchTodayApod/view/pages/apod_screen.dart';

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
    bloc.input.add(LoadApodEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.input.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.output,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is ApodTodayLoadingState ||
              snapshot.data is ApodTodayInitialState) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data is ApodTodaySucessState) {
            return ApodScreen(data: snapshot.data!.apod);
          } else {
            return const Center(child: Text('Dados não disponíveis'));
          }
        } else {
          return const Center(child: Text('Dados não disponíveis'));
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