##  SaProgressBar
A simple progress bar controller

# Screenshot

[<img src="/screenshot.png" height="450" alt="Progressbar">](https://github.com/lau1944/sa_progress_bar/blob/main/screenshot.png)


# How To Use

```dart
SaProgressBar(
  controller: _controller,
  onMoved: (value) {
    print('onMove: $value');
  },
  onTap: (value) {
    print('onTap: $value');
  },
)
```

`ProgressController`: responsible for control the progress on main stream and buffer stream

please check out `controller.moveTo()` `controller.moveBufferTo()`

`onMoved` : indicator's drag action callback.

`onTap` : user tap on the progress bar. (This can make your indicator jump to the following position)
