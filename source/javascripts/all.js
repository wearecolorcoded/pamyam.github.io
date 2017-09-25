//= require bootstrap
//= require_tree .

$(function() {
  $('a[href*="#"]:not([href="#"])').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
        $('html, body').animate({
          scrollTop: target.offset().top
        }, 800);
        return false;
      }
    }
  });
});

$(document).ready(function() {

  var eventDetails = $('body').find('[data-event-nav]');
  eventDetails.on('click', function() {

    var $parent = $(this).parents('[data-event-details]');

    $parent.find('[data-event-show]').toggleClass('showing');
    $parent.find('[data-event-body]').toggleClass('showing');
  })

  $('.m-content__index-carousel').slick({
    accessibility: true,
    dots: true,
    infinite: true,
    speed: 300,
    slidesToShow: 1,
  });

  $('.nav__hamburger-menu').on('click', function(){
    $('.m-content').toggleClass('active');
  });

})
