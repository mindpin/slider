(function() {
  var DataFiller, _build;

  window.getNumberInNormalDistribution = function(mean, std_dev) {
    return mean + uniform2NormalDistribution() * std_dev;
  };

  window.uniform2NormalDistribution = function() {
    var i, j, sum;
    sum = 0.0;
    for (i = j = 0; j <= 11; i = ++j) {
      sum = sum + Math.random();
    }
    return sum - 6.0;
  };

  _build = function(klass) {
    return jQuery('<div>').addClass(klass);
  };

  jQuery.fn.fill_span_text = function(text) {
    var $span, j, len, ref, str;
    ref = text.split('');
    for (j = 0, len = ref.length; j < len; j++) {
      str = ref[j];
      $span = jQuery('<span>').text(str);
      this.append($span);
    }
    return this;
  };

  DataFiller = (function() {
    function DataFiller(data) {
      var cookbook, j, len;
      this.$box = jQuery('.page-box');
      console.log(data);
      for (j = 0, len = data.length; j < len; j++) {
        cookbook = data[j];
        this.fill_cookbook(cookbook);
      }
    }

    DataFiller.prototype.fill_cookbook = function(cookbook) {
      var $cookbook;
      $cookbook = _build('cookbook').appendTo(this.$box);
      this.fill_meal(cookbook.breakfast, '早餐', 'breakfast', $cookbook);
      this.fill_meal(cookbook.meal_a, '小食', 'refreshments', $cookbook);
      this.fill_meal(cookbook.lunch, '午餐', 'lunch', $cookbook);
      this.fill_meal(cookbook.meal_b, '小食', 'refreshments', $cookbook);
      return this.fill_meal(cookbook.dinner, '晚餐', 'dinner', $cookbook);
    };

    DataFiller.prototype.fill_meal = function(meal, chname, engname, $cookbook) {
      var $chname, $engname, $meal, food, j, len, results;
      $meal = _build('meal').appendTo($cookbook);
      $chname = _build('chname').fill_span_text(chname).appendTo($meal);
      $engname = _build('engname').fill_span_text(engname).appendTo($meal);
      results = [];
      for (j = 0, len = meal.length; j < len; j++) {
        food = meal[j];
        results.push(this.fill_food(food, $meal));
      }
      return results;
    };

    DataFiller.prototype.fill_food = function(food, $meal) {
      var $cal, $fimg, $fimgbox, $fimgbox1, $fname, $food, $pbox, $power, $rank, left, rotate, top;
      $food = _build('food').appendTo($meal);
      $fname = _build('fname').text(food.name).appendTo($food);
      rotate = getNumberInNormalDistribution(0, 3);
      top = getNumberInNormalDistribution(0, 5);
      left = getNumberInNormalDistribution(0, 5);
      $fimg = _build('fimg').css({
        'transform': "rotate(" + rotate + "deg) translate(" + top + "px, " + left + "px)"
      }).appendTo($food);
      $fimgbox = _build('fibox').appendTo($fimg);
      $fimgbox1 = _build('fibox1').css({
        'background-image': "url(" + food.img + "@100w_100h_1e_1c)"
      }).appendTo($fimgbox);
      rotate = getNumberInNormalDistribution(0, 1);
      top = getNumberInNormalDistribution(0, 5);
      left = getNumberInNormalDistribution(0, 5);
      $power = _build('power').css({
        'transform': "rotate(" + rotate + "deg) translate(" + top + "px, " + left + "px)"
      }).appendTo($food);
      $pbox = _build('pbox').appendTo($power);
      $cal = _build('cal').html("<span>" + food.cal + "</span>").appendTo($pbox);
      return $rank = _build('rank').html("<span>" + food.rank + "</span>").addClass(food.rank.replace('+', '')).appendTo($pbox);
    };

    return DataFiller;

  })();

  jQuery(function() {
    return jQuery.get("yaml/index2.yaml", function(res) {
      var data;
      data = jsyaml.load(res);
      return new DataFiller(data);
    });
  });

}).call(this);
