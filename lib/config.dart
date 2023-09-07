import 'package:flutter/material.dart';

enum ColorPalette {
  app,
  appDarker,
  appLighter,
  secondApp,
  secondAppPrimary,
  secondAppMain,
  main,
  primary,
  generate
}

extension ColorSet on ColorPalette {
  Color get color {
    switch (this) {
      case ColorPalette.app:
        return const Color(0xFFE4F4FD);

      case ColorPalette.appDarker:
        return const Color(0xffc2cfd7);

      case ColorPalette.appLighter:
        return const Color(0xffffffff);

      case ColorPalette.primary:
        return const Color(0xff4CB648);

      case ColorPalette.main:
        return const Color(0xFF083C5A);

      case ColorPalette.secondApp:
        return const Color(0xffE3F6FF);

      case ColorPalette.secondAppMain:
        return const Color(0xff4CB648);

      case ColorPalette.secondAppPrimary:
        return const Color(0xFF083C5A);

      default:
        return const Color(0xffffffff);
    }
  }

  MaterialColor materialColor(Color color) {
    Map<int, Color> colorCodes = {
      50: color.withOpacity(.1),
      100: color.withOpacity(.2),
      200: color.withOpacity(.3),
      300: color.withOpacity(.4),
      400: color.withOpacity(.5),
      500: color.withOpacity(.6),
      600: color.withOpacity(.7),
      700: color.withOpacity(.8),
      800: color.withOpacity(.9),
      900: color.withOpacity(1)
    };

    return MaterialColor(color.value, colorCodes);
  }
}

enum MyElements {
  welcomeText,
  searchbar,
  suggestionList,
  mainLoadingIndicator,
  detailsLoadingIndicator,
  mountainSvg,
  birdSvg,
  sunSvg
}

extension Position on MyElements {
  double get top {
    switch (this) {
      case MyElements.welcomeText:
        return 0.26;

      case MyElements.suggestionList:
        return 0.1;

      default:
        return 0;
    }
  }

  double get right {
    switch (this) {
      case MyElements.mountainSvg:
        return -0.05;

      default:
        return 0;
    }
  }

  double get left {
    switch (this) {
      case MyElements.sunSvg:
        return 0.05;

      default:
        return 0;
    }
  }
}

extension AnimationDuration on MyElements {
  Duration get duration {
    switch (this) {
      case MyElements.mountainSvg:
        return const Duration(milliseconds: 800);

      case MyElements.searchbar:
        return const Duration(milliseconds: 800);

      case MyElements.sunSvg:
        return const Duration(milliseconds: 800);

      case MyElements.birdSvg:
        return const Duration(milliseconds: 800);

      default:
        return const Duration(seconds: 0);
    }
  }
}

extension Timing on MyElements {
  TimingToPositioning get before {
    switch (this) {
      case MyElements.searchbar:
        return TimingToPositioning.searchbarBefore;

      case MyElements.mountainSvg:
        return TimingToPositioning.mountainSvgBefore;

      case MyElements.sunSvg:
        return TimingToPositioning.sunSvgBefore;

      case MyElements.birdSvg:
        return TimingToPositioning.birdSvgBefore;

      case MyElements.mainLoadingIndicator:
        return TimingToPositioning.mainLoadingIndicatorBefore;

      default:
        return TimingToPositioning.nothing;
    }
  }

  TimingToPositioning get after {
    switch (this) {
      case MyElements.searchbar:
        return TimingToPositioning.searchbarAfter;

      case MyElements.mountainSvg:
        return TimingToPositioning.mountainSvgAfter;

      case MyElements.sunSvg:
        return TimingToPositioning.sunSvgAfter;

      case MyElements.birdSvg:
        return TimingToPositioning.birdSvgAfter;

      case MyElements.mainLoadingIndicator:
        return TimingToPositioning.mainLoadingIndicatorAfter;

      default:
        return TimingToPositioning.nothing;
    }
  }
}

enum TimingToPositioning {
  searchbarBefore,
  searchbarAfter,
  mountainSvgBefore,
  mountainSvgAfter,
  sunSvgBefore,
  sunSvgAfter,
  birdSvgBefore,
  birdSvgAfter,
  mainLoadingIndicatorBefore,
  mainLoadingIndicatorAfter,
  nothing
}

extension Positioning on TimingToPositioning {
  double get top {
    switch (this) {
      case TimingToPositioning.searchbarBefore:
        return 0.5;

      case TimingToPositioning.searchbarAfter:
        return 0.03;

      case TimingToPositioning.sunSvgBefore:
        return 0.05;

      case TimingToPositioning.sunSvgAfter:
        return -0.4;

      // case TimingToPositioning.birdSvgBefore:
      //   return 0.205;

      // case TimingToPositioning.birdSvgAfter:
      //   return -0.5;

      case TimingToPositioning.mainLoadingIndicatorBefore:
        return 0.13;

      case TimingToPositioning.mainLoadingIndicatorAfter:
        return -1;

      default:
        return 0;
    }
  }

  double get bottom {
    switch (this) {
      case TimingToPositioning.mountainSvgBefore:
        return -0.47;

      case TimingToPositioning.mountainSvgAfter:
        return -0.02;

      default:
        return 0;
    }
  }

  // double get left {
  //   switch (this) {
  //     case TimingToPositioning.birdSvgBefore:
  //       return 0.5;

  //     case TimingToPositioning.birdSvgAfter:
  //       return 0.2;

  //     default:
  //       return 0;
  //   }
  // }
}

extension Variables on MyElements {
  double get searchbarDistance => 7;
  double get searchBarShadowOpacity => 0.9;
}
