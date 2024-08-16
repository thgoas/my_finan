import 'package:flutter/material.dart';

class ShowButtonSheetWidget extends StatelessWidget {
  final Widget component;
  final String title;
  final String subTitle;
  final dynamic icon;
  final int height;
  const ShowButtonSheetWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.icon,
      this.height = 500,
      required this.component});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        leading: icon,
        title: Text(title),
        subtitle: Text(subTitle),
        trailing: Icon(
          Icons.edit,
          color: Colors.purple[800],
        ),
        onTap: () {
          Scaffold.of(context).showBottomSheet(
            (BuildContext context) {
              return SingleChildScrollView(
                child: SizedBox(
                  height: height.toDouble(),
                  child: Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close)),
                      SizedBox(
                        height: height.toDouble() - 50,
                        child: component,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
