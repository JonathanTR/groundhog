var validateFilePresent = function(){
  var $fileChooser = $("input[name='video']")
  $("#video-uploader").on("submit", function(e){
    e.preventDefault()
    if($fileChooser.val() == ""){
      $(".error").remove()
      $fileChooser.before("<div class='error'>Please choose a file to upload.</div>")
    }
  })
}

var attachValidations = function(){
  this.validateFilePresent()
}

$(document).ready(function(){
  attachValidations()
})