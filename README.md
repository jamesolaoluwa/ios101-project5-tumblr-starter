# Project 5 - *Tumblr Feed App*

Submitted by: **Olaoluwa James-Owolabi**

**Tumblr Feed App** is an iOS application that fetches and displays real photo posts from the Tumblr API.  
The app uses a custom `UITableView` to show photos alongside their captions, styled to match a Tumblr-like layout.  
Users can pull to refresh the feed, automatically load new posts, and explore content from any Tumblr blog by changing the blog name in the API endpoint.

Time spent: **8** hours spent in total  

---

## Required Features

The following **required** functionality is completed:

- [x] Setup Table view UI  
- [x] Setup Custom table view cell UI  
- [x] Table view data source  
- [x] Polish and tweak the UI to make it look great!  

---

## Stretch Features

The following **stretch** features are implemented:

- [x] Fetch posts from a different blog  
- [x] Pull to refresh the feed  

---

## Video Walkthrough

![](TableViewDemoVideo.gif)

---

## Notes and Challenges

- One challenge was ensuring the Auto Layout constraints correctly aligned the image and text label side by side within the table view cell.  
- Debugging the cell reuse identifier and reconnecting the storyboard after a reset was crucial to make the posts display correctly.  
- Used **Nuke** for efficient image loading and caching.

---

## License

    Copyright 2025 Olaoluwa James-Owolabi

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
