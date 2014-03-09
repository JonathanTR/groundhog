var validateFilePresent = function(){
  var $fileChooser = $("input[name='video']")
  var $form = $("#video-uploader")
  $form.on("submit", function(e){
    if($fileChooser.val() == ""){
      e.preventDefault()
      $(".error").remove()
      $fileChooser.before("<div class='error'>Please choose a file to upload.</div>")
    }
  })
}

$(document).ready(function(){
  validateFilePresent()
})