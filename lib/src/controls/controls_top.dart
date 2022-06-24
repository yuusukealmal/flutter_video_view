import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_view/src/inside.dart';

import 'base_controls.dart';

/// @Describe: Top action bar
///
/// @Author: LiWeNHuI
/// @Date: 2022/6/16

class ControlsTop extends StatefulWidget {
  /// Externally provided
  const ControlsTop({Key? key}) : super(key: key);

  @override
  State<ControlsTop> createState() => _ControlsTopState();
}

class _ControlsTopState extends BaseVideoViewControls<ControlsTop> {
  @override
  Widget build(BuildContext context) {
    Widget child = Row(
      children: <Widget>[
        if (Navigator.canPop(context))
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: foregroundColor,
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            onPressed: () async => Navigator.maybePop(context),
          ),
        Expanded(
          child: videoViewConfig.title != null &&
                  videoViewController.isFullScreen &&
                  !videoViewController.isPortrait
              ? _AnimatedText(
                  child: Text(
                    videoViewConfig.title!,
                    style: videoViewConfig.titleTextStyle ??
                        TextStyle(color: foregroundColor),
                    maxLines: 1,
                  ),
                )
              : const SizedBox.shrink(),
        ),
        Row(
          children: videoViewConfig.topActions
                  ?.call(context, videoViewController.isFullScreen) ??
              <Widget>[],
        ),
      ],
    );

    if (isShowDevice) {
      child = Column(
        children: <Widget>[
          _DeviceInfoRow(
            height: deviceRowHeight,
            foregroundColor: foregroundColor,
          ),
          SizedBox(height: barHeight, child: child),
        ],
      );
    }

    return Container(
      height: barHeight + deviceRowHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: videoViewConfig.controlsBackgroundColor,
        ),
      ),
      child: child,
    );
  }

  double get deviceRowHeight => isShowDevice ? 20 : 0;

  bool get isShowDevice =>
      videoViewConfig.canShowDevice &&
      videoViewController.isFullScreen &&
      !videoViewController.isPortrait;

  Color get foregroundColor => videoViewConfig.foregroundColor;
}

class _AnimatedText extends StatefulWidget {
  const _AnimatedText({
    Key? key,
    required this.child,
    this.scrollSpeed = 40,
    this.stayDuration = const Duration(seconds: 1),
  })  : assert(child is Text, 'Must be Text.'),
        super(key: key);

  // ignore: public_member_api_docs
  final Widget child;

  /// Length of stride
  final double scrollSpeed;

  /// Length of stay
  final Duration stayDuration;

  @override
  State<_AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends BaseState<_AnimatedText> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    _animation();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      scrollDirection: Axis.horizontal,
      child: widget.child,
    );
  }

  Future<void> _animation() async {
    await Future<void>.delayed(Duration.zero);

    while (true) {
      await Future<void>.delayed(widget.stayDuration);
      if (controller.positions.isNotEmpty) {
        controller.jumpTo(0);
      }

      await Future<void>.delayed(widget.stayDuration);
      if (controller.positions.isNotEmpty) {
        await controller.animateTo(
          controller.position.maxScrollExtent,
          duration: Duration(
            seconds: (controller.position.maxScrollExtent / widget.scrollSpeed)
                .floor(),
          ),
          curve: Curves.easeIn,
        );
      }
    }
  }
}

class _DeviceInfoRow extends StatefulWidget {
  const _DeviceInfoRow({
    Key? key,
    this.height = 20,
    this.foregroundColor = Colors.white,
  }) : super(key: key);

  final double height;
  final Color foregroundColor;

  @override
  State<_DeviceInfoRow> createState() => _DeviceInfoRowState();
}

class _DeviceInfoRowState extends BaseState<_DeviceInfoRow> {
  Timer? _timer;
  String _nowTime = '';

  final Connectivity _connectivity = Connectivity();
  String _connectivityResult = '检测中';

  final Battery _battery = Battery();
  int _batteryLevel = 0;
  Color _batteryColor = Colors.white;

  @override
  void initState() {
    _init();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: <Widget>[
          Center(
            child: Text(
              _nowTime,
              style: TextStyle(color: foregroundColor, fontSize: 12),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _connectivityWidget(),
                const SizedBox(width: 5),
                _batteryWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _connectivityWidget() {
    return Container(
      height: height / 3 * 2,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: foregroundColor),
        borderRadius: BorderRadius.circular(height),
      ),
      child: Text(
        _connectivityResult,
        style: TextStyle(color: foregroundColor, fontSize: 8),
      ),
    );
  }

  Widget _batteryWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            border: Border.all(color: foregroundColor),
            borderRadius: BorderRadius.circular(3),
          ),
          child: SizedBox(
            width: height,
            height: height / 3,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                LinearProgressIndicator(
                  value: _batteryLevel / 100,
                  color: _batteryColor,
                  backgroundColor: Colors.transparent,
                  minHeight: height / 3,
                ),
                Text(
                  '$_batteryLevel',
                  style: TextStyle(color: foregroundColor, fontSize: 8),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 1.5,
          height: height / 4,
          decoration: BoxDecoration(
            color: foregroundColor,
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(1),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _init() async {
    await _setData();

    _timer =
        Timer.periodic(const Duration(seconds: 1), (_) async => _setData());
  }

  Future<void> _setData() async {
    if (mounted) {
      final DateTime now = DateTime.now();
      _nowTime = '${now.hour.toString().padLeft(2, '0')}'
          ' : '
          '${now.minute.toString().padLeft(2, '0')}';

      _batteryLevel = await _battery.batteryLevel;
      final BatteryState batteryState = await _battery.batteryState;
      switch (batteryState) {
        case BatteryState.full:
        case BatteryState.discharging:
        case BatteryState.unknown:
          _batteryColor = foregroundColor.withOpacity(.4);
          break;
        case BatteryState.charging:
          _batteryColor = Colors.green.withOpacity(.8);
          break;
      }

      final ConnectivityResult result = await _connectivity.checkConnectivity();
      switch (result) {
        case ConnectivityResult.bluetooth:
          _connectivityResult = '蓝牙';
          break;
        case ConnectivityResult.wifi:
          _connectivityResult = 'WIFI';
          break;
        case ConnectivityResult.ethernet:
          _connectivityResult = '以太网';
          break;
        case ConnectivityResult.mobile:
          _connectivityResult = '移动网络';
          break;
        case ConnectivityResult.none:
          _connectivityResult = '无连接';
          break;
      }
    }

    setState(() {});
  }

  Color get foregroundColor => widget.foregroundColor;

  double get height => widget.height;
}