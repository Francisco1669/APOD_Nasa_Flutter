import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nasa_api/features/fetchTodayApod/model/apod.dart';
import 'package:nasa_api/features/fetchTodayApod/model/apod_repository.dart';
import 'package:nasa_api/features/fetchTodayApod/view/pages/apod_screen.dart';

class CustomAppBar extends StatefulWidget {
  CustomAppBar({super.key, required this.data});

  final ApodModel data;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  TextEditingController _controller = TextEditingController();

  bool searchActive = false;
  bool isExpanded = false;
  IApodRepository repository = ApodRepository(dio: Dio());

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
            'Picture of the day: ${widget.data.date?.day}/${widget.data.date?.month}/${widget.data.date?.year}',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 3,
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.blueGrey, Colors.blue]),
                border: Border.all(color: Colors.black, width: 1))),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  searchActive = !searchActive;
                });
              }),
          searchActive
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200,
                    child: TextField(
                      onSubmitted: (value) async {
                        var newApod = await repository
                            .getApodByDate(_controller.text.toString());

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ApodScreen(data: newApod)));
                      },
                      controller: _controller,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(top: 6, left: 6, right: 4),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Ex: 2021-08-01',
                        hintStyle: TextStyle(color: Colors.blueGrey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink()
        ]);
  }
}
