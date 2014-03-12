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
  file_source = params["video"][:tempfile].path
  filetype = return_filetype(params["video"][:type])
  filename = strip_filetype(params["video"][:filename])
  session[:filename] = filename
  session[:type] = filetype
  unless ["mp4"].include?(filetype)
    status 406
    erb :error_406
  else
    video_storage_path = "public/temp_video/#{filename}.#{filetype}"
    VideoConverter.copy_to_temp_video(video_storage_path, file_source)
    @video_storage_link = "temp_video/#{filename}.#{filetype}"
    erb :preview
  end
end
```

The upload process begins with a validation on the filetype uploaded. If it hasn't been whitelisted, it shouldn't go any further.

Session variables are set for the `filename` and `filetype`, to track the file through the rest of the user's visit.

`file_source` refers to a tempfile created upon upload. To keep things easy to work with, it gets copied to the `temp_video` folder.

The user is then directed to a preview page where they can review their video, and choose start and end points for their gif.


```Ruby
post '/convert' do
  filename = session[:filename]
  filetype = session[:type]

  video_storage_path = "public/temp_video/#{filename}.#{filetype}"
  gif_storage_path = "public/temp_gif/#{filename}.gif"
  gif_start_point = params["start-time"].to_i
  gif_duration = params["end-time"].to_i - gif_start_point
  VideoConverter.convert_to_gif(gif_storage_path, video_storage_path, gif_start_point, gif_duration)

  @gif_path = "temp_gif/#{filename}.gif"
  @gif_title = "#{filename}.gif"
  erb :download
end
```

When the form with those start and end points is submitted, the '/convert' route runs a `convert_to_gif` method from the `Video` class, copying that gif into a `temp_gif` folder.

```JavaScript
destroyFiles = function(){
  $filename = $('#filename').html()
  $.ajax({
    url: '/destroy/' + $filename,
    type: 'delete'
  })
}
```

```Ruby
delete '/destroy' do
  filename = session[:filename]
  filetype = session[:type]
  File.delete("public/temp_video/#{filename}.#{filetype}")
  File.delete("public/temp_gif/#{filename}.gif")
  session.clear
  "complete"
end
```

When the user leaves, an ajax call to the '/destroy' route is called. This method deletes the files and clears the session.


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
