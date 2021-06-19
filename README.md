##  SaProgressBar
A simple progress bar controller

# Screenshot

[<img src="/screenshot.png" height="450" alt="Progressbar">](https://github.com/lau1944/sa_progress_bar/blob/main/screenshot.png)


# How To Use

```dart
SaProgressBar(
  controller: _controller,
  onMoved: (value) {
    // progress on moved callback
    _controller.moveTo(value);
    //print('onMove: $value');
  },
  onTap: (value) {
    // progress on tap callback
    _controller.moveTo(value);
    print('onTap: $value');
  },
)
```

`ProgressController`: responsible for control the progress on main stream and buffer stream

please check out `controller.moveTo()` `controller.moveBufferTo()`


note that if you don't call these methods on callback function, the indicator would not response.

`onMoved` : indicator's drag action callback.

`onTap` : user tap on the progress bar. (This can make your indicator jump to the following position)
