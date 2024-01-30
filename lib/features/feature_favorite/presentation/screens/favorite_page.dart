import 'package:breezehub/core/assets.dart';
import 'package:breezehub/core/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final List<String> icon = ['clear', 'cloud', 'drizzle', 'rain', 'snow', 'thunder'];

    return Scaffold(
      backgroundColor: const Color(0xff2E335A),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const Gap(8),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(Assets.chevronLeft, width: 18, height: 24),
            ),
            const Gap(16),
            Text('Favorite', style: theme.textTheme.headlineSmall),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(CupertinoIcons.ellipsis_vertical, color: Constants.primary),
          ),
        ],
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: ShapeDecoration(shape: const OvalBorder(), shadows: [
                BoxShadow(
                  color: const Color(0xff612FAB).withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 100,
                ),
              ]),
            ),
            Positioned(
              bottom: 50,
              right: 0,
              child: Container(
                width: 300,
                height: 300,
                decoration: ShapeDecoration(shape: const OvalBorder(), shadows: [
                  BoxShadow(
                    color: const Color(0xff612FAB).withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 100,
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: size.height,
              width: size.width,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: icon.length,
                padding: const EdgeInsets.only(top: 27),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: SizedBox(
                      height: 184,
                      width: 342,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(Assets.regtangle1),
                          Positioned(
                            right: 60,
                            bottom: 60,
                            child: SvgPicture.asset('assets/icon/${icon[index]}.svg', width: 100, height: 100),
                          ),
                          Positioned(
                            left: 60,
                            bottom: 25,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  '19°',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 64,
                                    fontWeight: FontWeight.w400,
                                    height: 0.01,
                                    letterSpacing: 0.37,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: Row(
                                    children: [
                                      Text('H:24\u00b0', style: theme.textTheme.labelMedium!.apply(fontSizeFactor: 1.1)),
                                      const Gap(8),
                                      Text('L:18\u00b0', style: theme.textTheme.labelMedium!.apply(fontSizeFactor: 1.1)),
                                    ],
                                  ),
                                ),
                                Text('Montreal, Canada', style: theme.textTheme.titleMedium!.apply(color: Constants.primary)),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 25,
                            right: 60,
                            child: Text('Fast Wind', style: theme.textTheme.titleSmall),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
