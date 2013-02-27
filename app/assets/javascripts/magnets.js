

var saveMagnets = function (poemWordID, top, left, callback) {

  $.ajax({
    type: "POST",
    url: "/poem_words/" + poemWordID,
    data: { _method:'PUT', poem_word : { "top": top + "%", "left": left + "%" } },
    dataType: 'json',
    success: function(msg) {
      console.log(msg);
    }
  })

}

// GETS AND SETS VARIABLES BASED ON WINDOW SIZE
// SETS PAGE HEIGHT
var getSetVariableWidth = function() {
  magnetsWidth = $(".magnets").width();
  pageWidth = $(window).width();
  pageHeight = $(window).height();

  // dynamically setting the height to 80% of the window
  $('.magnets').height(pageHeight * 0.8)

  magnetsHeight = $(".magnets").height();
  magnetsOffset = $('.magnets').offset();
}

// RANDOM ROTATION OF MAGNETS
var rotateAllMagnets = function() {
  $.each($('.magnet'), function(key, value){
    var posNeg = function(){
      if ( Math.random() > .5 ) {
        return -1
      } else {
        return 1
      }
    }
    var randDeg = posNeg() * (Math.random() * 10)
    $(value).css({ WebkitTransform: 'rotate(' + randDeg + 'deg)'});
  });
}



$(document).ready(function() {


    // INSTANTIATING GLOBAL VARIABLES
    var $dragging = null;
    var magnetsWidth, magnetsHeight, magnetsOffset, pageWidth, pageHeight;


    getSetVariableWidth();

    // CHANGING VARIABLES BASED ON WINDOW RESIZE
    $(window).resize(function(){
      getSetVariableWidth();
    });


    // Instantiating new magnets from an array of JSON stuff
    _.each(poemData, function(wordObject){
      $('.magnets').append(
        $('<div/>')
          .addClass('magnet')
          .html(wordObject.word)
          .css({top: wordObject.top, left: wordObject.left})
          .data("poem-word-id", wordObject.id)
      );
    });

});