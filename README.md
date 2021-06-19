##  SaProgressBar
A simple progress bar controller

# Screenshot

<img src="/screenshot.png" height="450" alt="Progressbar">


# How To Use

```dart
SaProgressBar(
  progress: progress,
  bufferProgress: 0.5,
  onTap: (value) {
    setState(() {
       progress = value;
      });
  }
  onMoved: (value) {
    setState(() {
       progress = value;
      });
    },
 )

```

`progress` : The indicator position ( 0.0 - 1.0)

`bufferProgress` : If progressbar needs buffer range, you can set buffer progress. 

`onMoved` : indicator's drag action callback.

`onTap` : user tap on the progress bar. (This can make your indicator jump to the following position)
