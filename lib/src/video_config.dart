import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'video_view.dart';

/// @Describe: The config of VideoView.
///
/// @Author: LiWeNHuI
/// @Date: 2023/3/1

class VideoConfig {
  /// Overall configuration for the video view. Including [width], [height],
  /// [useSafe], [backgroundColor] etc.
  VideoConfig({
    this.width,
    this.height,
    this.backgroundColor = Colors.black,
    this.tooltipBackgroundColor = Colors.black54,
    this.foregroundColor = Colors.white,
    this.textSize = 14,
    this.iconSize = 16,
    this.useSafe = true,
    this.maxScale = 2.5,
    this.minScale = 0.8,
    this.panEnabled = false,
    this.scaleEnabled = false,
    this.aspectRatio,
    this.allowedScreenSleep = true,
    this.autoInitialize = false,
    this.autoPlay = false,
    this.startAt,
    this.volume = 1.0,
    this.looping = false,
    this.overlay,
    this.placeholderBuilder,
    this.showBuffering = true,
    this.bufferingBuilder,
    this.finishBuilder,
    this.fullScreenByDefault = false,
    this.useRootNavigator = true,
    this.deviceOrientationsEnterFullScreen,
    this.systemOverlaysExitFullScreen = SystemUiOverlay.values,
    this.deviceOrientationsExitFullScreen = DeviceOrientation.values,
    this.showControlsOnInitialize = true,
    this.showControls,
    this.hideControlsTimer = const Duration(seconds: 3),
    this.controlsBackgroundColor = const <Color>[
      Color.fromRGBO(0, 0, 0, .7),
      Color.fromRGBO(0, 0, 0, .3),
      Color.fromRGBO(0, 0, 0, 0),
    ],
    this.showCenterPlay = true,
    this.centerPlayButton,
    this.canLongPress = true,
    this.canChangeVolumeOrBrightness = true,
    this.canChangeProgress = true,
    this.canBack = true,
    this.title,
    this.titleTextStyle,
    this.topActions,
    this.showLock = false,
    this.centerLeftActions,
    this.centerRightActions,
    this.bottomBuilder,
    this.textPosition,
    this.progressBarGap,
    this.videoViewProgressColors,
  })  : assert(
          maxScale > 0,
          'The maxScale must be greater than zero and greater than minScale.',
        ),
        assert(
          minScale > 0,
          'The minScale must be a finite number greater than zero and less '
          'than maxScale.',
        ),
        assert(
          !hideControlsTimer.isNegative,
          'The duration of the controller disappear must be greater than zero.',
        );

  /// The width of video.
  final double? width;

  /// The height of video.
  final double? height;

  /// The background color of video.
  ///
  /// Defaults to black.
  final Color backgroundColor;

  /// The background color of a widget that displays information about volume,
  /// brightness, speed, playback progress, and so on.
  ///
  /// Defaults to black54.
  final Color tooltipBackgroundColor;

  /// The color for the video's Button` and `Text` widget descendants.
  ///
  /// Defaults to white.
  final Color foregroundColor;

  /// Size of all texts.
  ///
  /// Defaults to 14.
  final double textSize;

  /// Size of all icons.
  ///
  /// Defaults to 16.
  final double iconSize;

  /// Whether to maintain a safe distance from the top.
  ///
  /// Defaults to true.
  final bool useSafe;

  /// The maximum allowed scale.
  ///
  /// Defaults to 2.5.
  final double maxScale;

  /// The minimum allowed scale.
  ///
  /// Defaults to 0.8.
  final double minScale;

  /// Whether or not to allow panning.
  ///
  /// Defaults to false.
  final bool panEnabled;

  /// Whether or not to allow zooming.
  ///
  /// Defaults to false.
  final bool scaleEnabled;

  /// The Aspect Ratio of the Video.
  final double? aspectRatio;

  /// Defines if the player will sleep in fullscreen or not.
  ///
  /// Defaults to true.
  final bool allowedScreenSleep;

  /// Initialize the Video on Startup. This will prep the video for playback.
  ///
  /// Defaults to false.
  final bool autoInitialize;

  /// Play the video as soon as it's displayed.
  ///
  /// Defaults to false.
  final bool autoPlay;

  /// Where does the video start playing when it first plays.
  ///
  /// Defaults to zero.
  final Duration? startAt;

  /// The volume of the video, not the device volume.
  final double volume;

  /// Whether the video is looped.
  ///
  /// Defaults to false.
  final bool looping;

  /// A widget which is placed between the video and the controls.
  final Widget? overlay;

  /// Widgets in various initialized states.
  final PlaceholderBuilder? placeholderBuilder;

  /// Whether to show placeholders in the buffer.
  ///
  /// Defaults to true.
  final bool showBuffering;

  /// Widget to display when buffered is overlaid above the video.
  final Widget? bufferingBuilder;

  /// Widget to display when video playback is complete.
  final Widget Function(BuildContext context, bool isFullScreen)? finishBuilder;

  /// Whether to play full screen when auto play is enabled.
  /// Valid only if [autoPlay] is true.
  ///
  /// Defaults to false.
  final bool fullScreenByDefault;

  /// Defines if push/pop navigations use the rootNavigator.
  ///
  /// Defaults to true.
  final bool useRootNavigator;

  /// Defines the set of allowed device orientations on entering fullscreen.
  final List<DeviceOrientation>? deviceOrientationsEnterFullScreen;

  /// Defines the system overlays visible after exiting fullscreen.
  final List<SystemUiOverlay> systemOverlaysExitFullScreen;

  /// Defines the set of allowed device orientations after exiting fullscreen.
  final List<DeviceOrientation> deviceOrientationsExitFullScreen;

  /// Whether controls are displayed when initializing the widget.
  ///
  /// Defaults to true.
  final bool showControlsOnInitialize;

  /// Whether to display controls.
  ///
  /// Defaults to true.
  final bool Function(bool isFullScreen)? showControls;

  /// Defines the [Duration] before the video controls are hidden.
  ///
  /// Defaults to three seconds.
  final Duration hideControlsTimer;

  /// The background color of the controller.
  final List<Color> controlsBackgroundColor;

  /// Whether to show the play button in the middle.
  ///
  /// Defaults to true.
  final bool showCenterPlay;

  /// Play button in the middle.
  final Widget? centerPlayButton;

  /// Whether the video can be played at double speed by long pressing.
  ///
  /// Defaults to true.
  final bool canLongPress;

  /// Whether the volume or brightness can be adjusted.
  ///
  /// Defaults to true.
  final bool canChangeVolumeOrBrightness;

  /// Whether the video progress can be adjusted.
  ///
  /// Defaults to true.
  final bool canChangeProgress;

  /// Whether to show [BackButton].
  ///
  /// Defaults to true.
  final bool canBack;

  /// The title of video.
  final String? title;

  /// The textStyle of [title].
  final TextStyle? titleTextStyle;

  /// Widgets placed at the top right.
  final List<Widget> Function(BuildContext context, bool isFullScreen)?
      topActions;

  /// Whether the lockable button is displayed.
  final bool showLock;

  /// Widgets on the middle left.
  ///
  /// `lockButton` is the lockable button, which is used to decide where put it.
  final List<Widget> Function(
    BuildContext context,
    bool isFullScreen,
    bool isLock,
    Widget lockButton,
  )? centerLeftActions;

  /// Widgets on the middle right.
  ///
  /// `lockButton` is the lockable button, which is used to decide where put it.
  final List<Widget> Function(
    BuildContext context,
    bool isFullScreen,
    bool isLock,
    Widget lockButton,
  )? centerRightActions;

  /// It is used to define the control buttons at the bottom and the layout of
  /// the display content.
  final Widget? Function(
    BuildContext context,
    bool isFullScreen,
    Widget playPauseButton,
    Widget progressBar,
    Widget muteButton,
    Widget fullScreenButton,
  )? bottomBuilder;

  /// Enumeration value where the progress information is located on
  /// the progress bar.
  ///
  /// Defaults to TextPosition.ltl.
  final VideoTextPosition Function(bool isFullScreen)? textPosition;

  /// The interval width of the progress bar and time information widget.
  final double Function(bool isFullScreen)? progressBarGap;

  /// The default colors used throughout the indicator.
  ///
  /// See [VideoViewProgressColors] for default values.
  final VideoViewProgressColors? videoViewProgressColors;
}

// ignore: public_member_api_docs
typedef PlaceholderBuilder = Widget? Function(VideoInitStatus status);