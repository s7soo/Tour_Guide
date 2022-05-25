import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
class SlideShow extends StatefulWidget {
  final imageArray;

  const SlideShow({this.imageArray});
  @override
  State<SlideShow> createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  late PageController _pageController;
  int activePage = 0;
  final _transformationController = TransformationController();
  late TapDownDetails _doubleTapDetails;

  List<String> images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
    "https://wallpaperaccess.com/full/2637581.jpg",
    "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(viewportFraction: 0.8,initialPage: 0);
     images = array() as List<String>;
  }
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: PageView.builder(
              itemCount: images.length,
              pageSnapping: true,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (context, pagePosition) {
                bool active = pagePosition == activePage;
                return slider(images,pagePosition,active);
              }),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicators(images.length,activePage))
      ],
    );
  }
  List<Widget> indicators(imagesLength,currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }
  List<String> array() {
    images = widget.imageArray;
    return images;
  }
  AnimatedContainer slider(images,pagePosition,active){
    double margin = active ? 10 : 20;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(images[pagePosition]))
      ),
    );
  }
  // void _handleDoubleTapDown(TapDownDetails details) {
  //   _doubleTapDetails = details;
  // }
  // void _handleDoubleTap() {
  //   if (_transformationController.value != Matrix4.identity()) {
  //     _transformationController.value = Matrix4.identity();
  //   } else {
  //     final position = _doubleTapDetails.localPosition;
  //     // For a 3x zoom
  //     _transformationController.value = Matrix4.identity()
  //       ..translate(-position.dx * 2, -position.dy * 2)
  //       ..scale(3.0);
  //     // Fox a 2x zoom
  //     // ..translate(-position.dx, -position.dy)
  //     // ..scale(2.0);
  //   }
  // }
}