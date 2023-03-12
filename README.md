## 
[![flutter][]][web flutter] <br>
[![cover][]][github kodingworks] <br>
A flutter package that will simplify the creation of animated lists for you, replete with refresh and infiniteLoading, of course.

---

## Example
```dart
    PrettyListAnimation(
      onRefresh: () async {},
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
    );
```
### Output
[![output][]][output]

---

[![flutter][]][web flutter]

[cover]: https://avatars.githubusercontent.com/u/57176505?s=200&v=4
[output]: assets/example.gif
[flutter]: https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter
[web flutter]: https://flutter.dev
[github kodingworks]: https://github.com/kodingworks