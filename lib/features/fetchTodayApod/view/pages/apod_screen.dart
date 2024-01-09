import 'package:flutter/material.dart';
import 'package:nasa_api/features/fetchTodayApod/model/apod.dart';
import 'package:nasa_api/shared/widgets/custom_appbar.dart';

class ApodScreen extends StatefulWidget {
  ApodScreen({super.key, required this.data});
  final ApodModel data;

  @override
  State<ApodScreen> createState() => _ApodScreenState();
}

class _ApodScreenState extends State<ApodScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
          child: CustomAppBar(data: widget.data),
          preferredSize: Size(width, height * 0.1)),
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
                          image: NetworkImage(
                              widget.data.url!), //TODO Tratar o caso do vídeo
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
                          Flexible(
                            child: Text(
                                widget.data.copyright == null
                                    ? 'Unknown actor'
                                    : 'Actor: ${widget.data.title}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                )),
                          ),
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
                      if (isExpanded)
                        Text(
                          widget.data.explanation ?? '',
                          maxLines: 20,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        )
                      else
                        Text(''),
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
