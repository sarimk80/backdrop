import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RangeValues rangeValues = RangeValues(0.2, 0.7);

  @override
  Widget build(BuildContext context) {
    return Backdrop(
      subHeader: 'Decorations',
      appBarTitle: 'Home',
      actions: <Widget>[Icon(Icons.search)],
      backLayer: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          Text(
            "Price Range",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
                inactiveTrackColor: Colors.grey,
                activeTrackColor: Colors.white,
                thumbColor: Colors.white,
                overlayColor: Colors.white),
            child: RangeSlider(
              values: rangeValues,
              onChanged: (value) {
                setState(() {
                  rangeValues = value;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
          ),
          Text("BedRoom",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15)),
          Wrap(
            spacing: 5,
            direction: Axis.horizontal,
            children: <Widget>[
              ChoiceChip(
                selected: true,
                label: Text("Beds"),
              ),
              ChoiceChip(
                selected: false,
                label: Text("Lamps"),
              ),
              ChoiceChip(
                selected: false,
                label: Text("Dressing Table"),
              ),
              ChoiceChip(
                selected: false,
                label: Text("Curtains"),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8),
          ),
          Text("WashRoom",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15)),
          Wrap(
            spacing: 6,
            direction: Axis.horizontal,
            children: <Widget>[
              ChoiceChip(
                selected: false,
                label: Text("Sink"),
              ),
              ChoiceChip(
                selected: false,
                label: Text("Tub"),
              ),
              ChoiceChip(
                selected: false,
                label: Text("Tiles"),
              ),
            ],
          ),
        ],
      ),
      frontLayer: GridView.count(
        crossAxisCount: 2,
        children: List.generate(100, (index) {
          return Center(
            child: Text(
              "Image $index",
              style: Theme.of(context).textTheme.headline,
            ),
          );
        }),
      ),
    );
  }
}
