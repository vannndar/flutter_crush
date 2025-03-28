//import 'dart:io';

//import 'package:firebase_admob/firebase_admob.dart';
import 'package:scafold/animations/shine_effect.dart';
import 'package:scafold/bloc/bloc_provider.dart';
import 'package:scafold/bloc/game_bloc.dart';
import 'package:scafold/game_widgets/double_curved_container.dart';
import 'package:scafold/game_widgets/game_level_button.dart';
import 'package:scafold/game_widgets/shadowed_text.dart';
import 'package:scafold/model/level.dart';
import 'package:scafold/pages/game_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  /*   final String appId = Platform.isAndroid 
  ? "ca-app-pub-9541831517245687~1206632744"
  : "ca-app-pub-9541831517245687~1206632744";   // TO BE ADAPTED WITH APPLE

  final String screenUnitId = Platform.isAndroid
  ? "ca-app-pub-9541831517245687/1249605591"
  : "ca-app-pub-9541831517245687/1249605591";   // TO BE ADAPTED WITH APPLE

  InterstitialAd myInterstitial;
 */
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..addListener(() {
      setState(() {});
    });

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.6, 1.0, curve: Curves.easeInOut),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();

      // show the ads
      //      myInterstitial
      //        ..load()
      //        ..show(
      //          anchorOffset: 0.0,
      //          anchorType: AnchorType.bottom,
      //        );
    });

    // Initialize the Ads
    //    myInterstitial = InterstitialAd(
    //      adUnitId: BannerAd.testAdUnitId,
    //    );
  }

  @override
  void dispose() {
    _controller.dispose();
    //    myInterstitial?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GameBloc gameBloc = BlocProvider.of<GameBloc>(context)!.bloc;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Size screenSize = mediaQueryData.size;
    double levelsWidth =
        -100.0 +
        ((mediaQueryData.orientation == Orientation.portrait)
            ? screenSize.width
            : screenSize.height);

    return Scaffold(
      body: PopScope(
        // No way to get back
        canPop: false,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background/background2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ShadowedText(
                  text: 'by Didier Boelens',
                  color: Colors.white,
                  fontSize: 12.0,
                  offset: Offset(1.0, 1.0),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  width: levelsWidth,
                  height: levelsWidth,
                  child: GridView.builder(
                    itemCount: gameBloc.numberOfLevels,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.01,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GameLevelButton(
                        width: 80.0,
                        height: 60.0,
                        borderRadius: 50.0,
                        text: 'Level ${index + 1}',
                        onTap: () async {
                          Level newLevel = await gameBloc.setLevel(index + 1);

                          // Open the Game page
                          Navigator.of(context).push(GamePage.route(newLevel));
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              top: _animation.value * 250.0 - 150.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: DoubleCurvedContainer(
                  width: screenSize.width - 60.0,
                  height: 150.0,
                  outerColor: Colors.blue[700]!,
                  innerColor: Colors.blue,
                  child: Stack(
                    children: <Widget>[
                      ShineEffect(offset: Offset(100.0, 100.0)),
                      Align(
                        alignment: Alignment.center,
                        child: ShadowedText(
                          text: 'Flutter Crush',
                          color: Colors.white,
                          fontSize: 26.0,
                          shadowOpacity: 1.0,
                          offset: Offset(1.0, 1.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
