(function() {
  jQuery(function() {
    var over;
    over = jQuery('.page-sample').data('over') || '1s';
    return window.sr = new scrollReveal({
      mobile: true,
      reset: true,
      viewport: jQuery('.page-sample')[0],
      easing: 'ease-in-out',
      enter: 'right',
      over: over,
      move: '100px',
      scale: {
        direction: 'up',
        power: '0%'
      }
    });
  });

}).call(this);
