library backdrop;

import 'package:flutter/material.dart';

class Backdrop extends StatefulWidget {
  final String appBarTitle;
  final String subHeader;
  final Widget backLayer;
  final Widget frontLayer;
  final List<Widget> actions;
  final bool centerTitle;

  Backdrop(
      {@required this.appBarTitle,
      this.subHeader = '',
      @required this.backLayer,
      @required this.frontLayer,
      this.centerTitle,
      this.actions});

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop> with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _sizeController;
  bool isPlaying = true;
  double height = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _sizeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: WillPopScope(
        onWillPop: () async {
          if (_sizeController.isCompleted) {
            _animationController.reverse();
            height = 0;
            _sizeController.reverse();
            return false;
          }
          return true;
        },
        child: Wrap(
          children: <Widget>[
            AppBar(
              centerTitle: widget.centerTitle,
              actions: widget.actions,
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(
                widget.appBarTitle,
                style: TextStyle(color: Theme.of(context).primaryTextTheme.headline6.color),
              ),
              leading: IconButton(
                  icon: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: _animationController),
                  onPressed: () {
                    if (_animationController.isCompleted) {
                      _animationController.reverse();
                      height = 0;
                      _sizeController.reverse();
                    } else {
                      _animationController.forward();
                      height = MediaQuery.of(context).size.height / 2;
                      _sizeController.forward();
                    }
                  }),
            ),
            AnimatedBuilder(
              animation: _sizeController,
              builder: (context, child) {
                return AnimatedSize(
                  curve: Curves.easeInOut,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: height,
                    child: Center(child: widget.backLayer),
                  ),
                  vsync: this,
                  duration: Duration(milliseconds: 300),
                );
              },
            ),
            Container(
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                primary: true,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      widget.subHeader,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height -
                        2 * AppBar().preferredSize.height,
                    child: widget.frontLayer,
                    // child: Center(
                    //   child: Text("Hello"),
                    // ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _sizeController.dispose();
  }
}
