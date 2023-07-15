# Voice Angry Meter
The VoiceEmoMerter (VEM) sofware is designed to measure the degree of emotionality of a person's voice on a scale from 0 to 100.

VEM is adapted to analyze the emotionality of male and female voices.
Measurement of the degree of emotionality of the voice can be carried out both directly from the microphone by the user, and from pre-recorded audio files from various sources.

It's part of Intontrainer project
https://intontrainer.by/

## Installation

Currently on our website (see https://intontrainer.by ) the SRM prototype is uploaded, available for free download.

## Build from source

Use QT Creator or CMake to build Voice Angry Meter.
You need to build Inton Core library first.

```bash
git clone 

cd voice-angry-meter
git clone https://github.com/zhitko/inton-core.git

cmake --build . --target all
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## Authors

Development:
* [Zhitko Vladimir](https://www.linkedin.com/in/zhitko-vladimir-92662255/)

Scientific:
* [Boris Lobanov](https://www.linkedin.com/in/boris-lobanov-50628384/)

## License
[MIT](https://choosealicense.com/licenses/mit/)
