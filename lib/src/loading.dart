import 'package:flutter/material.dart';

import 'decorate/decorate.dart';
import 'indicators/audio_equalizer.dart';
import 'indicators/ball_beat.dart';
import 'indicators/ball_clip_rotate.dart';
import 'indicators/ball_clip_rotate_multiple.dart';
import 'indicators/ball_clip_rotate_pulse.dart';
import 'indicators/ball_grid_beat.dart';
import 'indicators/ball_grid_pulse.dart';
import 'indicators/ball_pulse.dart';
import 'indicators/ball_pulse_rise.dart';
import 'indicators/ball_pulse_sync.dart';
import 'indicators/ball_rotate.dart';
import 'indicators/ball_rotate_chase.dart';
import 'indicators/ball_scale.dart';
import 'indicators/ball_scale_multiple.dart';
import 'indicators/ball_scale_ripple.dart';
import 'indicators/ball_scale_ripple_multiple.dart';
import 'indicators/ball_spin_fade_loader.dart';
import 'indicators/ball_triangle_path.dart';
import 'indicators/ball_triangle_path_colored.dart';
import 'indicators/ball_zig_zag.dart';
import 'indicators/ball_zig_zag_deflect.dart';
import 'indicators/circle_stroke_spin.dart';
import 'indicators/cube_transition.dart';
import 'indicators/line_scale.dart';
import 'indicators/line_scale_party.dart';
import 'indicators/line_scale_pulse_out.dart';
import 'indicators/line_scale_pulse_out_rapid.dart';
import 'indicators/line_spin_fade_loader.dart';
import 'indicators/orbit.dart';
import 'indicators/pacman.dart';
import 'indicators/semi_circle_spin.dart';
import 'indicators/square_spin.dart';
import 'indicators/triangle_skew_spin.dart';
import 'pretty_list_animation_base.dart';

/// Entrance of the loading.
class LoadingIndicator extends StatelessWidget {
  /// Indicate which type.
  final IndicatorType indicatorType;

  /// The color you draw on the shape.
  final List<Color>? colors;
  final Color? backgroundColor;

  /// The stroke width of line.
  final double? strokeWidth;

  /// Applicable to which has cut edge of the shape
  final Color? pathBackgroundColor;

  /// Animation status, true will pause the animation, default is false
  final bool pause;

  const LoadingIndicator({
    Key? key,
    required this.indicatorType,
    this.colors,
    this.backgroundColor,
    this.strokeWidth,
    this.pathBackgroundColor,
    this.pause = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (indicatorType == IndicatorType.circleStrokeSpin && pause) {
      debugPrint(
          "LoadingIndicator: it will not take any effect when set pause:true on ${IndicatorType.circleStrokeSpin}");
    }
    List<Color> safeColors = colors == null || colors!.isEmpty
        ? [Theme.of(context).primaryColor]
        : colors!;
    return DecorateContext(
      decorateData: DecorateData(
        indicator: indicatorType,
        colors: safeColors,
        strokeWidth: strokeWidth,
        pathBackgroundColor: pathBackgroundColor,
        pause: pause,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          color: backgroundColor,
          child: _buildIndicator(),
        ),
      ),
    );
  }

  /// return the animation indicatorType.
  _buildIndicator() {
    switch (indicatorType) {
      case IndicatorType.ballPulse:
        return const BallPulse();
      case IndicatorType.ballGridPulse:
        return const BallGridPulse();
      case IndicatorType.ballClipRotate:
        return const BallClipRotate();
      case IndicatorType.squareSpin:
        return const SquareSpin();
      case IndicatorType.ballClipRotatePulse:
        return const BallClipRotatePulse();
      case IndicatorType.ballClipRotateMultiple:
        return const BallClipRotateMultiple();
      case IndicatorType.ballPulseRise:
        return const BallPulseRise();
      case IndicatorType.ballRotate:
        return const BallRotate();
      case IndicatorType.cubeTransition:
        return const CubeTransition();
      case IndicatorType.ballZigZag:
        return const BallZigZag();
      case IndicatorType.ballZigZagDeflect:
        return const BallZigZagDeflect();
      case IndicatorType.ballTrianglePath:
        return const BallTrianglePath();
      case IndicatorType.ballTrianglePathColored:
        return const BallTrianglePathColored();
      case IndicatorType.ballTrianglePathColoredFilled:
        return const BallTrianglePathColored(isFilled: true);
      case IndicatorType.ballScale:
        return const BallScale();
      case IndicatorType.lineScale:
        return const LineScale();
      case IndicatorType.lineScaleParty:
        return const LineScaleParty();
      case IndicatorType.ballScaleMultiple:
        return const BallScaleMultiple();
      case IndicatorType.ballPulseSync:
        return const BallPulseSync();
      case IndicatorType.ballBeat:
        return const BallBeat();
      case IndicatorType.lineScalePulseOut:
        return const LineScalePulseOut();
      case IndicatorType.lineScalePulseOutRapid:
        return const LineScalePulseOutRapid();
      case IndicatorType.ballScaleRipple:
        return const BallScaleRipple();
      case IndicatorType.ballScaleRippleMultiple:
        return const BallScaleRippleMultiple();
      case IndicatorType.ballSpinFadeLoader:
        return const BallSpinFadeLoader();
      case IndicatorType.lineSpinFadeLoader:
        return const LineSpinFadeLoader();
      case IndicatorType.triangleSkewSpin:
        return const TriangleSkewSpin();
      case IndicatorType.pacman:
        return const Pacman();
      case IndicatorType.ballGridBeat:
        return const BallGridBeat();
      case IndicatorType.semiCircleSpin:
        return const SemiCircleSpin();
      case IndicatorType.ballRotateChase:
        return const BallRotateChase();
      case IndicatorType.orbit:
        return const Orbit();
      case IndicatorType.audioEqualizer:
        return const AudioEqualizer();
      case IndicatorType.circleStrokeSpin:
        return const CircleStrokeSpin();
      default:
        throw Exception("no related indicator type:$indicatorType found");
    }
  }
}
