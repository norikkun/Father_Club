// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// ヘッダーのスクロール動作
document.addEventListener('turbolinks:load', () => {
  const header = document.querySelector('header');
  let prevY = window.scrollY;

  function handleScroll() {
    const currentY = window.scrollY;
    if (currentY < prevY) {
      header.classList.remove('hidden');
    } else {
      if (currentY > 0) {
        header.classList.add('hidden');
      }
    }
    prevY = currentY;
  }

  window.addEventListener('scroll', handleScroll);

  document.addEventListener('turbolinks:before-render', () => {
    window.removeEventListener('scroll', handleScroll);
  });
});