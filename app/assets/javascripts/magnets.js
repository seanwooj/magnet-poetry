
var Magnet = ( function () {

  var Controller = function (magnetData) {
    var that = this;
    var $dragging = null;
    var magnetsWidth, magnetsHeight, magnetsOffset, pageWidth, pageHeight;

    this.updateMagnets = function (poemWordID, top, left, callback) {
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

    this.refreshData = function(poemID) {
      $.get( poemID + '/refresh_words', function(newData) {
        poemData = newData;
        _.each(newData, function(newDatum) { console.log(newDatum)});
      });
    }

    // GETS AND SETS VARIABLES BASED ON WINDOW SIZE
    // SETS PAGE HEIGHT
    this.getSetVariableWidth = function() {
      magnetsWidth = $(".magnets").width();
      pageWidth = $(window).width();
      pageHeight = $(window).height();

      // dynamically setting the height to 80% of the window
      $('.magnets').height(pageHeight * 0.6)

      magnetsHeight = $(".magnets").height();
      magnetsOffset = $('.magnets').offset();
    }

    // RANDOM ROTATION OF MAGNETS
    this.rotateAllMagnets = function() {
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

    // Magnet Movement

    this.magnetMove = function(target, event) {
      if (target) {
        var left = ((event.pageX - magnetsOffset.left) / magnetsWidth) * 100;
        var top = ((event.pageY - magnetsOffset.top) / magnetsHeight) * 100;
        target.css({
            top: top + "%",
            left: left + "%"
        });
      }
    }

    this.magnetMouseUp = function() {
      if ($dragging) {
        var poemWordID = $dragging.data("poem-word-id");
        var top = parseInt($dragging.css("top")) / $dragging.parent().height() * 100;
        var left = parseInt($dragging.css("left")) / $dragging.parent().width() * 100;
        that.updateMagnets(poemWordID, top, left)
        $dragging = null;
      }
    }

    // Magnet DOM creation

    this.dataToMagnet = function(magnetData) {
      $('.magnets').empty();
      _.each(magnetData, function(wordObject){
        $('.magnets').append(
          $('<div/>')
            .addClass('magnet')
            .html(wordObject.word)
            .css({top: wordObject.top, left: wordObject.left})
            .data("poem-word-id", wordObject.id)
        );
      });
    }

    this.start = function() {
      that.getSetVariableWidth();

      // CHANGING VARIABLES BASED ON WINDOW RESIZE
      $(window).resize(function(){
        that.getSetVariableWidth();
      });

      $('.magnets').on("mousemove", function(e) {
        that.magnetMove($dragging, e)
      });

      $('.magnets').on("mousedown", "div", function (e) {
        $dragging = $(e.target);
      });

      $(document.body).on("mouseup", function (e) {
        that.magnetMouseUp();
      });

      // Instantiating new magnets from an array of JSON stuff
      that.dataToMagnet(magnetData)
      that.rotateAllMagnets();

      // barely know why this works. should learn more abt it
      $('.add-more').bind('ajax:success', function(event, data) {
        magnetData = $.parseJSON(data);
        magnet.dataToMagnet(magnetData);
        magnet.rotateAllMagnets();
      });
    }

  }

  return { Controller: Controller }

})();