destroyFiles = function(){
  $filename = $('#filename').html()
  $.ajax({
    url: '/destroy/' + $filename,
    type: 'delete'
  })
}

$(document).ready(function(){
  if($('#filename').length == 1){
    window.onbeforeunload = destroyFiles
  }
})
