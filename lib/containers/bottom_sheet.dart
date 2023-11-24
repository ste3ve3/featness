import 'package:featnessapp/containers/add_user_form.dart';
import 'package:flutter/material.dart';

class BottomSheetContainer extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;

  const BottomSheetContainer({
    super.key,
    required this.child,
    this.padding,
    this.decoration,
  });

  @override
  State<BottomSheetContainer> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheetContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      decoration: widget.decoration,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            showDragHandle: true,
            useSafeArea: true,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return addUserForm(context);
            });
        },
        child: widget.child,
      ),
    );
  }
}
