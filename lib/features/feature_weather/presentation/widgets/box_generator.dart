import 'package:breezehub/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BoxGenerator extends StatelessWidget {
  final IconData boxIcon1;
  final IconData boxIcon2;
  final String boxTitle1;
  final String boxTitle2;
  final Widget content1;
  final Widget content2;

  const BoxGenerator({
    super.key,
    required this.boxIcon1,
    required this.boxIcon2,
    required this.boxTitle1,
    required this.boxTitle2,
    required this.content1,
    required this.content2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        children: [
          MyBox(boxIcon: boxIcon1, boxTitle: boxTitle1, content: content1),
          const Gap(14),
          MyBox(boxIcon: boxIcon2, boxTitle: boxTitle2, content: content2),
        ],
      ),
    );
  }
}

class MyBox extends StatelessWidget {
  final IconData boxIcon;
  final String boxTitle;
  final Widget content;

  const MyBox({super.key, required this.boxIcon, required this.boxTitle, required this.content});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Expanded(
      child: Container(
        height: 164,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: Constants.itemColor,
          borderRadius: const BorderRadius.all(Radius.circular(22)),
          border: Border.all(color: Constants.quaternary),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(boxIcon, size: 18, color: Constants.secondary),
                const Gap(5),
                Text(boxTitle, style: theme.textTheme.labelLarge!.copyWith(color: Constants.secondary)),
              ],
            ),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}
