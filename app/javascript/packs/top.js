/*global Swiper*/

const swiper = new Swiper(".swiper", {
  loop: true, 
  speed: 1500, 
  autoplay: { 
    delay: 8000, 
    disableOnInteraction: false, 
  },

  pagination: {
    el: ".swiper-pagination",
    clickable: true,
  },

  navigation: {
    nextEl: ".swiper-button-next",
    prevEl: ".swiper-button-prev",
  },
});

swiper.el.style.height = "400px";
