
$(window).scroll(function() {
  var scroll = $(window).scrollTop();
  console.log(scroll)
  if (scroll >= 50) {
    $('.floating-logo').removeClass('hidden');
  }
    if (scroll < 50) {
    $('.floating-logo').addClass('hidden');
  }
});
