# Mav Farm iOS Coding Challenge

Submission from Christopher Truman

## Demo iPhone X [(video link here)](https://github.com/jstart/MavFarm_SpaceX/blob/master/Demo_Movies/iPhoneX.mov?raw=true):
![Demo GIF iPhoneX](https://github.com/jstart/MavFarm_SpaceX/blob/master/Demo_Movies/iPhoneX.gif)

## Demo iPad [(video link here)](https://github.com/jstart/MavFarm_SpaceX/blob/master/Demo_Movies/iPad.mov?raw=true):
![Demo GIF iPad](https://github.com/jstart/MavFarm_SpaceX/blob/master/Demo_Movies/iPad.gif)

## Commit History:
Broke work down into individual commits to show my process. Used a lazy version of TDD. Wrote a few unit tests at the beginning, mostly to make testing the network serialization easier. Once I had the tests passing, I started building out the UI. Had to add a few fields to the network model as I re-read the project requirements. Completed work on the list of launches first, then built the countdown view to the next launch. Played around with making the table cell adapt to different size classes as can be seen in the iPad demo above. Captured video of the behavior to make it easy to verify I met the requirements.

1.  [Project Structure. Initial Files. Carthage setup (Alamofire & SnapKit). Convenience Extensions.](https://github.com/jstart/MavFarm_SpaceX/commit/a877cbe55ca925b746b6a152a76ab8d678d1bf76)
2. [Passing decoding tests, failing network client tests](https://github.com/jstart/MavFarm_SpaceX/commit/c4555bcb9c8acf811b3d7534a7d0b2bb529a863d)
3. [Network tests green](https://github.com/jstart/MavFarm_SpaceX/commit/06685da3f3ca68f828b696392773cf15aa74bb0b)
4. [Basic display of upcoming launches. Parse full launch data.](https://github.com/jstart/MavFarm_SpaceX/commit/a1a59d650806f9a53fe09e3432f78f7f70317dd3)
5. [Countdown View. Demo Videos/GIFs](https://github.com/jstart/MavFarm_SpaceX/commit/8ad5ca16d7c022ad6a5ada3230ab2eb917993179)
