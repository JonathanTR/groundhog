# Groundhog

Groundhog is a Sinatra app that converts your videos to gifs so you can experience those few seconds over and over and over and over and ov...

### Dependencies:
This app uses the
[streamio-ffmpeg gem](https://github.com/streamio/streamio-ffmpeg )
as a wrapper for ffmpeg.

### How it works:
The real workhorse here is ffmpeg, which is nicely wrapped in Streamio's streamio-ffmpeg gem. At the moment, there are only two routes: one to get the home page, and one to upload a file.

Here is a breakdown of that '/upload' route:

```Ruby
post '/upload' do
  filetype = params["video"][:type]
  unless filetype.include?("/mp4")
    status 406
    erb :error_406
  else
    file_source = params["video"][:tempfile]
    filename = params["video"][:filename]
    video_storage_path = "public/temp_video/#{filename}"
    VideoConverter.copy_to_temp_video(video_storage_path, file_source.path)

    gif_storage_path = "public/temp_gif/#{strip_filetype(filename)}.gif"
    gif_start_point = params["start-time"].to_i
    gif_duration = params["end-time"].to_i - gif_start_point
    VideoConverter.convert_to_gif(gif_storage_path, video_storage_path, gif_start_point, gif_duration)

    @gif_path = gif_storage_path.gsub!("public/", "")
    @gif_title = "#{strip_filetype(filename)}.gif"
    erb :download
  end
end
```

The upload process begins with a validation on the filetype uploaded. If it hasn't been whitelisted, it shouldn't go any further.

`file_source` refers to a tempfile created upon upload. To keep things easy to work with, it gets copied to the `temp_storage` folder. In a future release, this should be sent back to the user to preview.

The next four lines run the gif conversion. At the moment, it takes for arguments, a path where the new gif will be stored, a path for the source video, a point to start recording the gif, and a total duration for the gif.

After that, the gif in the `temp_gif` folder is linked to in a download template for the user. In a future release, I envision setting a session when the user visits the page, and destroying the temp files when the session expires.

### To run locally:
Fork the repo, then<br/>
`$ git clone <forked_repository_name>`, then<br/>
`$ bundle install`, then run:<br/>
`shotgun groundhog_app.rb`

#### Commits

Commits are tagged with a ticket code from a trello board I put together for the project: [Groundhog](https://trello.com/b/adBaKvdJ/wistia-gif-converter).

The number (ie 02) represents a user story, while the letter (ie -b) represents a goal inside that user story.

### Some Bill Murray for you:
This image was created with groundhog.
<br/>
![Groundhog's Day](http://i.minus.com/ibrcrAqRoxhfAV.gif)
