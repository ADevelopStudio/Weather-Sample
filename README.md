# Weather-Sample CodeChallenge for XXXXXXX

by _Dmitrii Zverev_. 7 Feb 2021


<h2>Coding Assignment</h2>
<h3>Implement an iOS native app using Swift 5.2 to demonstrate your skills, ability to write clean and maintainable code and attention to details.</h3>


<h2>Given Instructions:</h2>

Use a UITableViewController to display weather information of Sydney, Melbourne and Brisbane as start.
- [x] Provide a way to add more cities using another modal view controller which includes a search functionality to find a city by name or location.
- [x] City IDs
o Sydney, Melbourne and Brisbane are: 4163971, 2147714, 2174003 o More city can be found from the following link:
http://bulk.openweathermap.org/sample
- [x] Each cell should display at least two pieces of info: Name of city on the left, temperature on the right.
- [x] Get real time weather information using https://openweathermap.org/current - You can register and get your API key for free.
- [x]  A sample request to get weather info for one city:
o http://api.openweathermap.org/data/2.5/weather?id=4163971&units=metri
c&APPID=your_registered_API_key
- [x] Weather should be automatically updated periodically.
- [x] Use Storyboard and Autolayouts.
- [x] It is fine to use 3rd party libraries via CocoaPods or by other means, but try to avoid
using 3rd party library for Networking.
- [x] Please commit your code as you proceed with appropriate commit message.

<h2>Brownie Points:</h2>

- [ ] MVVM architectural pattern is preferred with unit tests and try to avoid using 3rd library like RxSwift.
- [x] Use an activity indicator to provide some feedback to user while waiting for network response.
- [x] Allow user to tap on a cell to open a new “Detail view”, to show more information about the city such as current weather summary, min and max temperature, humidity, etc.
- [x] Try to use table view or collection view to display details.
- [x] In the “Detail view”, implement animations to enhance the user experience.
- [x] Support all different dimensions of the devices.
- [x] Support landscape and portrait view together.
