import 'package:flutter/material.dart';

Future<bool?> confirmDialog(
  BuildContext context,
  String title,
  String content,
  String okButtonText,
  Color color,
) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),),
        content: Text(content),
        actions: <Widget>[
          Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(false);
                },
                child: Container(
                    padding: const EdgeInsets.only(top:10, right: 25, bottom: 10, left: 25),
                    decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black, 
                      width: 2.0,         
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  child: const Text(
                    "Cancel", 
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(true);
                },
                child: Container(
                    padding: const EdgeInsets.only(top:12, right: 25, bottom: 12, left: 25),
                    decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  child: Text(
                    okButtonText, 
                    style: const TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              )
                ],
              )
        ],
      );
    },
  );
}