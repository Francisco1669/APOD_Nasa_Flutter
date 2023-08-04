import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nasa_api/features/fetchTodayApod/model/apod.dart';
import 'package:nasa_api/features/fetchTodayApod/model/apod_repository.dart';

// ignore: must_be_immutable
class ApodScreen extends StatefulWidget {
  ApodScreen({super.key, required this.data});
  ApodModel data;

  @override
  State<ApodScreen> createState() => _ApodScreenState();
}

class _ApodScreenState extends State<ApodScreen> {
  AppBar customAppbar() {
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
                        await repository
                            .getApodByDate(_controller.text.toString())
                            .then((value) {
                          print(value.title);
                        });

                        widget.data = await repository
                            .getApodByDate(_controller.text.toString());

                        setState(() {});
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

  bool isExpanded = false;
  TextEditingController _controller = TextEditingController();
  bool searchActive = false;
  IApodRepository repository = ApodRepository(dio: Dio());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: customAppbar(),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue[800]!, Colors.blueGrey[500]!]),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Center(
                    child: Container(
                      width: width * 0.9,
                      height: height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(widget.data.url!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: height * 0.45,
                left: width * 0.1,
                child: Container(
                  width: width * 0.8,
                  height: height,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        colors: [Colors.blueGrey[800]!, Colors.blue[300]!]),
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.data.title ?? 'No title available',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text('Actor: ${widget.data.copyright}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      Divider(color: Colors.white),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Explanation: ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                          IconButton(
                            color: Colors.white,
                            icon: isExpanded
                                ? Icon(Icons.expand_less)
                                : Icon(Icons.expand_more),
                            onPressed: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        width: width * 0.8,
                        height: isExpanded ? height : height * 0,
                        child: Text(
                          widget.data.explanation ?? 'No explanation available',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
