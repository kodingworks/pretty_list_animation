## 
[![flutter][]][web flutter] <br>
[![cover][]][github kodingworks] <br>
A flutter package that will simplify the creation of animated lists for you, replete with refresh and infiniteLoading, of course.

---

## Example
```dart
    PrettyListAnimation(
      onRefresh: () async {
        // TODO: Function for refresh data
      },
      padding: const EdgeInsets.all(16),
      items: numbers,
      itemBuilder: (context, number, index, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: SizedBox(
            height: 80.0,
            child: Card(
              color: Color.fromRGBO(
                Random().nextInt(256),
                Random().nextInt(256),
                Random().nextInt(256),
                1,
              ),
              child: Center(
                child: Text('Item $number'),
              ),
            ),
          ),
        );
      },
      isInfinite: true,
      isTextIndicator: false,
      indicatorType: IndicatorType.pacman,
      size: 30,
    );
```
### Output
[![output][]][output]

### Indicator Type
[![indicator][]][indicator]

| Type | Type | Type | Type |
|---|---|---|---|
|1. ballPulse | 2. ballGridPulse | 3. ballClipRotate | 4. squareSpin|
|5. ballClipRotatePulse | 6. ballClipRotateMultiple | 7. ballPulseRise | 8. ballRotate|
|9. cubeTransition | 10. ballZigZag | 11. ballZigZagDeflect | 12. ballTrianglePath|
|13. ballTrianglePathColored | 14.ballTrianglePathColoredFilled | 15. ballScale | 16. lineScale|
|17. lineScaleParty | 18. ballScaleMultiple | 19. ballPulseSync | 20. ballBeat|
|21. lineScalePulseOut | 22. lineScalePulseOutRapid |23. ballScaleRipple | 24. ballScaleRippleMultiple|
|25. ballSpinFadeLoader | 26. lineSpinFadeLoader | 27. triangleSkewSpin | 28. pacman|
|29. ballGridBeat | 30. semiCircleSpin| 31. ballRotateChase | 32. orbit|
|33. audioEqualizer | 34. circleStrokeSpin|


---

[![flutter][]][web flutter]

[cover]: https://avatars.githubusercontent.com/u/57176505?s=200&v=4
[output]: https://raw.githubusercontent.com/kodingworks/pretty_list_animation/master/assets/example.gif
[indicator]: https://raw.githubusercontent.com/kodingworks/pretty_list_animation/master/assets/indicator.gif
[flutter]: https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter
[web flutter]: https://flutter.dev
[github kodingworks]: https://github.com/kodingworks