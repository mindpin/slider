jQuery ->
  window.sr = new scrollReveal {
    mobile: true
    reset: false
    viewport: jQuery('.page-sample')[0]

    easing: 'ease-in-out'
    enter: 'right'
    over: '1s'
    move: '100px'
    scale: {
      direction: 'up'
      power: '0%'
    }
  }

# 禁止横向滚动