var fileNotPresent = function(){
  var $file = $("input[name='video']").val()
  return $file == ""
}

var timeSpanIsNilOrNegative = function(){
  var $start = $('input[name="start-time"]').val()
  var $end = $('input[name="end-time"]').val()
  return $start >= $end
}

var displayError = function(errorMessage){
  $(".error").remove()
  $("input[type='submit']").after("<div class='error'>" + errorMessage + "</div>")
}

var runValidations = function(){
  var $form = $("#video-uploader")
  $form.on("submit", function(e){
    switch(true){
      case fileNotPresent():
        e.preventDefault()
        displayError("Please choose a file to upload.")
        break
      case timeSpanIsNilOrNegative():
        e.preventDefault()
        displayError("Please choose a time span that is greater than zero.")
        break
    }
  })
}

$(document).ready(function(){
  runValidations()
})