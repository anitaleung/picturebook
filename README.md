# Project 6 - PictureBook

**PictureBook** is a photo sharing app using Parse as its backend.

Time spent: **18** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign up to create a new account using Parse authentication
- [x] User can log in and log out of his or her account
- [x] The current signed in user is persisted across app restarts
- [x] User can take a photo, add a caption, and post it to "Instagram"
- [x] User can view the last 20 posts submitted to "Instagram"

The following **optional** features are implemented:

- [ ] Show the username and creation time for each post
- [ ] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse.
- [ ] User Profiles:
- [ ] Allow the logged in user to add a profile photo
- [ ] Display the profile photo with each post
- [ ] Tapping on a post's username or profile photo goes to that user's profile page

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Commenting system
2. Filters

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='https://github.com/anitaleung/picturebook/blob/master/walkthrough.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

The majority of time was taken to figure out how to add/load images + change/save captions on the same view. 

Bugs to fix (or features to add): Relating images to different users, changing the edit button to a "save" button after caption field is populated instead of having the user save by pressing onto the cell, don't allow user to change the description if the "edit" button wasn't clicked, change edit and save buttons to have icon backgrounds 

The code for this assignment is ***incredibly hacky**.

## License

Copyright [2016] [Anita Leung]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.