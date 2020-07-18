import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:music_recommendation/src/common/global_bloc.dart';
import 'package:music_recommendation/src/ui/recommendation/recommendation_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _emotionList = [
    "Happy",
    "Neutral",
    "Meh",
    "Down",
    "Frustrated"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0075ff),
        elevation: 0.0,
      ),
      backgroundColor: Color(0xFF0075ff),
      body: Container(
        color: Color(0xFF0075ff),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                child: Center(
                  child: Text(
                    "How are you feeling?",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Flexible(
            //   flex: 8,
            //   child: Stack(
            //     children: [
            //       Container(
            //         child: ListWheelScrollView.useDelegate(
            //           childDelegate: ListWheelChildLoopingListDelegate(
            //             children: List<Widget>.generate(
            //               5,
            //               (index) {
            //                 return EmotionBox(
            //                   emotion: _emotionList[index],
            //                 );
            //               },
            //             ),
            //           ),
            //           controller: _scrollController,
            //           physics: BouncingScrollPhysics(),
            //           overAndUnderCenterOpacity: 0.4,
            //           useMagnifier: true,
            //           magnification: 1.5,
            //           itemExtent: 100,
            //         ),
            //       ),
            //       Align(
            //         alignment: Alignment.center,
            //         child: GestureDetector(
            //           behavior: HitTestBehavior.opaque,
            //           onTap: () {
            //             print(5656);
            //           },
            //           child: Container(
            //             color: Colors.transparent,
            //             width: double.infinity,
            //             height: 150,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
            Flexible(
              flex: 8,
              child: Container(
                color: Colors.transparent,
                height: double.infinity,
                child: Swiper(
                  scrollDirection: Axis.horizontal,
                  itemCount: _emotionList.length,
                  viewportFraction: 0.55,
                  scale: 0.05,
                  fade: 0.01,
                  itemBuilder: (context, index) {
                    return EmotionBox(emotion: _emotionList[index]);
                  },
                  physics: BouncingScrollPhysics(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmotionBox extends StatelessWidget {
  final String emotion;

  const EmotionBox({Key key, this.emotion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);

    return GestureDetector(
      onTap: () {
        _globalBloc.getRecommendations(emotion);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecommendationPage(
              emotion: emotion,
            ),
          ),
        );
      },
      child: Container(
        // decoration: BoxDecoration(
        //   border: Border.all(color: Color(0xFF0075ff)),
        //   borderRadius: BorderRadius.circular(15),
        //   color: Colors.transparent,
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.black.withOpacity(0.3),
        //       spreadRadius: 2,
        //       blurRadius: 2,
        //       offset: Offset(0, 2),
        //     )
        //   ],
        // ),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              child: Image.asset(
                "assets/images/" + emotion + ".png",
                fit: BoxFit.fill,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                emotion,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
