var currentCategory = null;
var grid = null;

var routes = {
  'category/:categoryId': function(categoryId) {
    currentCategory = parseInt(categoryId);
    setCategoryActive();
    reshuffle();
  },
  '/': function(){
    currentCategory = null;
    setCategoryActive();
    reshuffle();
  }
};

var reshuffle = function() {
  grid.shuffle('shuffle', function(el, shuffle) {
    if (currentCategory === null) {
      return true;
    }
    var data = el.data('item');
    return data.categories.indexOf(currentCategory) != -1;
  });
};

var setCategoryActive = function() {
  var currentPath = window.location.hash.replace('#','');
  $('[data-active-on]').each(function() {
    var el = $(this);
    el.removeClass('active');
    if(el.data('active-on') === currentPath) {
      el.addClass('active');
    }
  });
};

$(document).on("ready page:load", () => {
  grid = $('.js-grid');
  grid.shuffle('sort', {
    itemSelector: '.js-grid-item'
  });
  var router = Router(routes);
  router.init();
  window.router = router;
});
