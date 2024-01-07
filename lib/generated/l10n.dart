// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello World`
  String get helloWorld {
    return Intl.message(
      'Hello World',
      name: 'helloWorld',
      desc: '',
      args: [],
    );
  }

  /// `Click to upload or drag a Lottie file to preview here.`
  String get openTips {
    return Intl.message(
      'Click to upload or drag a Lottie file to preview here.',
      name: 'openTips',
      desc: '',
      args: [],
    );
  }

  /// `The selected file is not a Lottie file, please select again.`
  String get openLottieError {
    return Intl.message(
      'The selected file is not a Lottie file, please select again.',
      name: 'openLottieError',
      desc: '',
      args: [],
    );
  }

  /// `reverse`
  String get animReverse {
    return Intl.message(
      'reverse',
      name: 'animReverse',
      desc: '',
      args: [],
    );
  }

  /// `play`
  String get animPlay {
    return Intl.message(
      'play',
      name: 'animPlay',
      desc: '',
      args: [],
    );
  }

  /// `pause`
  String get animPause {
    return Intl.message(
      'pause',
      name: 'animPause',
      desc: '',
      args: [],
    );
  }

  /// `stop`
  String get animStop {
    return Intl.message(
      'stop',
      name: 'animStop',
      desc: '',
      args: [],
    );
  }

  /// `Play speed`
  String get animSpeed {
    return Intl.message(
      'Play speed',
      name: 'animSpeed',
      desc: '',
      args: [],
    );
  }

  /// `Animation info`
  String get animInfo {
    return Intl.message(
      'Animation info',
      name: 'animInfo',
      desc: '',
      args: [],
    );
  }

  /// `Animation name`
  String get animName {
    return Intl.message(
      'Animation name',
      name: 'animName',
      desc: '',
      args: [],
    );
  }

  /// `Animation duration`
  String get animDuration {
    return Intl.message(
      'Animation duration',
      name: 'animDuration',
      desc: '',
      args: [],
    );
  }

  /// `Frames`
  String get frameCount {
    return Intl.message(
      'Frames',
      name: 'frameCount',
      desc: '',
      args: [],
    );
  }

  /// `Frame rate`
  String get frameRate {
    return Intl.message(
      'Frame rate',
      name: 'frameRate',
      desc: '',
      args: [],
    );
  }

  /// `Animation size`
  String get animBoundsSize {
    return Intl.message(
      'Animation size',
      name: 'animBoundsSize',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
