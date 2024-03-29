// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "chartkick/chart.js"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "controllers"
import "bootstrap"

// Internal imports:
import { initFlatpickr } from '../plugins/init_flatpickr';


document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  if(document.querySelector(".edit-dream-date") != null) {
    let dreamDate = document.querySelector(".edit-dream-date").value;
    initFlatpickr(dreamDate);
  } else {
    initFlatpickr();
  };
});
