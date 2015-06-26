window.getNumberInNormalDistribution = (mean, std_dev)->
  mean + uniform2NormalDistribution() * std_dev

window.uniform2NormalDistribution = ->
  sum = 0.0
  for i in [0..11]
    sum = sum + Math.random()
  sum - 6.0

_build = (klass)->
  return jQuery('<div>').addClass klass

jQuery.fn.fill_span_text = (text)->
  for str in text.split('')
    $span = jQuery('<span>').text str
    this.append $span

  return this


class DataFiller
  constructor: (data)->
    @$box = jQuery('.page-box')

    console.log data

    for cookbook in data
      @fill_cookbook cookbook

  fill_cookbook: (cookbook)->
    $cookbook = _build 'cookbook'
      .appendTo @$box

    @fill_meal cookbook.breakfast, '早餐', 'breakfast', $cookbook
    @fill_meal cookbook.meal_a, '小食', 'refreshments', $cookbook
    @fill_meal cookbook.lunch, '午餐', 'lunch', $cookbook
    @fill_meal cookbook.meal_b, '小食', 'refreshments', $cookbook
    @fill_meal cookbook.dinner, '晚餐', 'dinner', $cookbook

  fill_meal: (meal, chname, engname, $cookbook)->
    $meal = _build 'meal'
      .appendTo $cookbook

    $chname = _build 'chname'
      .fill_span_text chname
      .appendTo $meal

    $engname = _build 'engname'
      .fill_span_text engname
      .appendTo $meal

    for food in meal
      @fill_food food, $meal

  fill_food: (food, $meal)->
    $food = _build('food')
      .appendTo $meal

    $fname = _build 'fname'
      .text food.name
      .appendTo $food

    rotate = getNumberInNormalDistribution(0, 3)
    top = getNumberInNormalDistribution(0, 5)
    left = getNumberInNormalDistribution(0, 5)
    $fimg = _build 'fimg'
      .css
        'transform': "rotate(#{rotate}deg) translate(#{top}px, #{left}px)"
      .appendTo $food

    $fimgbox = _build 'fibox'
      .appendTo $fimg

    $fimgbox1 = _build 'fibox1'
      .css
        'background-image': "url(#{food.img}@100w_100h_1e_1c)"
      .appendTo $fimgbox

    rotate = getNumberInNormalDistribution(0, 1)
    top = getNumberInNormalDistribution(0, 5)
    left = getNumberInNormalDistribution(0, 5)
    $power = _build 'power'
      .css
        'transform': "rotate(#{rotate}deg) translate(#{top}px, #{left}px)"
      .appendTo $food

    $pbox = _build 'pbox'
      .appendTo $power

    $cal = _build 'cal'
      .html "<span>#{food.cal}</span>"
      .appendTo $pbox

    $rank = _build 'rank'
      .html "<span>#{food.rank}</span>"
      .addClass food.rank.replace('+', '')
      .appendTo $pbox

jQuery ->
  jQuery.get "yaml/index2.yaml", (res)->
    data = jsyaml.load res
    new DataFiller data