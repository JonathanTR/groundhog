# Groundhog

Groundhog is a Sinatra app that converts your videos to gifs so you can experience those few seconds over and over and over and over and ov...

### Dependencies:
streamio-ffmpeg gem
[a link](https://github.com/streamio/streamio-ffmpeg )

### How it works:
The real workhorse here is ffmpeg, which is nicely wrapped in Streamio's streamio-ffmpeg gem. At the moment, there are only two routes: one to get the home page, and one to upload a file.

The upload route does more than it really should right now. It posts a video file, which is validated to be in mp4 format (ffmpeg works with other formats, but for the moment I am whitelisting them in). It then calls a method from the VideoConverter class to copy the file to a local temp_video directory. That video is then passed into a method called convert_to_gif, which outputs into a temp_gif directory.

From there, the gif's path is passed to the user in a downloads page.

### To run locally:
Fork the repo.
`$ git clone <forked_repository_name>`
`$ bundle install`
Then run:
`shotgun groundhog_app.rb`

#### Commits

Commits are tagged with a ticket code from a trello board I put together for the project: [a link](https://trello.com/b/adBaKvdJ/wistia-gif-converter).

The number (ie 02) represents a user story, while the letter (ie -b) represents a goal inside that user story.

### Some Bill Murray for you:
![Groundhog's Day](http://img.pandawhale.com/post-38185-dont-drive-angry-gif-Bill-Murr-du2W.gif)