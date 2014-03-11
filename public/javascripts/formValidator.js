var fileNotPresent = function(){
  var $file = $("input[name='video']").val()
  return $file == ""
}

var timeSpanIsNilOrNegative = function(){
  var $start = $('input[name="start-time"]').val()
  var $end = $('input[name="end-time"]').val()
  return $start == "" || $end == "" || parseInt($start) >= parseInt($end)
}

var displayError = function(errorMessage){
  $(".error").remove()
  $("input[type='submit']").after("<div class='error'>" + errorMessage + "</div>")
}

var runUploadValidations = function(){
  var $uploadForm = $("#video-uploader")
  $uploadForm.on("submit", function(e){
    switch(true){
      case fileNotPresent():
        e.preventDefault()
        displayError("Please choose a file to upload.")
        break
      default:
        $(".error").remove()
        $("input[type='submit']").after("<progress>")
    }
  })
}

var runGifConvertValidations = function(){
  console.log("run gif validations")
  var $convertGifForm = $("#gif-converter")
  $convertGifForm.on("submit", function(e){
    switch(true){
      case timeSpanIsNilOrNegative():
        e.preventDefault()
        displayError("Please choose a valid start and end time.")
        break
      default:
        $(".error").remove()
        $("input[type='submit']").after("<progress>")
    }
  })
}

$(document).ready(function(){
  runUploadValidations()
  runGifConvertValidations()
})