destroyFiles = function(){
  $.ajax({
    url: '/destroy',
    type: 'delete'
  })
}

$(document).ready(function(){
  if($('#filename').length == 1){
    window.onbeforeunload = destroyFiles
  }
})
