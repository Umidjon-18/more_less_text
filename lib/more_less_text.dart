library more_less_text;

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'scale_animation.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MoreLessText(
      text: "This is a new package for using text easily, you can collapce and expand texts",
      moreKeyWord: "...more",
      lessKeyWord: "less",
      lessLength: 30,
    );
  }
}

class MoreLessText extends StatefulWidget {
  const MoreLessText({
    super.key,
    required this.text,
    required this.moreKeyWord,
    required this.lessKeyWord,
    this.lessLength = 250,
    this.textStyle = const TextStyle(fontSize: 14),
    this.keyWordStyle = const TextStyle(fontSize: 14),
  });

  final String text;
  final String moreKeyWord;
  final String lessKeyWord;
  final int lessLength;
  final TextStyle textStyle;
  final TextStyle keyWordStyle;

  @override
  State<MoreLessText> createState() => _MoreLessTextState();
}

class _MoreLessTextState extends State<MoreLessText> {
  final ExpandableController controller = ExpandableController();
  late String subComment =
      widget.text.substring(0, widget.text.length > widget.lessLength ? widget.lessLength : widget.text.length);

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      controller: controller,
      collapsed: Text.rich(
        TextSpan(
          text: subComment,
          style: widget.textStyle,
          children: [
            if (widget.text.length > widget.lessLength) ...{
              const WidgetSpan(child: SizedBox(width: 2)),
              WidgetSpan(
                  child: ScaleAnimation(
                onTap: () {
                  controller.toggle();
                },
                child: Transform.translate(
                  offset: const Offset(0, 1),
                  child: Text(
                    widget.moreKeyWord,
                    style: widget.keyWordStyle,
                  ),
                ),
              )),
            }
          ],
        ),
      ),
      expanded: Text.rich(
        TextSpan(
          text: widget.text,
          style: widget.textStyle,
          children: [
            if (widget.text.length > widget.lessLength) ...{
              const WidgetSpan(
                alignment: PlaceholderAlignment.bottom,
                child: SizedBox(width: 2),
              ),
              WidgetSpan(
                  alignment: PlaceholderAlignment.bottom,
                  child: GestureDetector(
                    onTap: () {
                      controller.toggle();
                    },
                    child: Transform.translate(
                      offset: const Offset(0, 1),
                      child: Text(
                        widget.lessKeyWord,
                        style: widget.keyWordStyle,
                      ),
                    ),
                  )),
            }
          ],
        ),
      ),
    );
  }
}
