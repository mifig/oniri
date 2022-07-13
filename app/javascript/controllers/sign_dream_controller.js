// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "addsign", "removelabels", "signBtn", "signInput" ]

  showSigns(event) {
    let sign = this.addsignTarget;
    let clickedBtn = event.currentTarget;
    let siblingBtn = clickedBtn.nextElementSibling;

    siblingBtn.classList.remove("add-input-btn-clicked");
    sign.classList.remove("d-none");
    sign.classList.remove("visuallyhidden");
    clickedBtn.classList.add("add-input-btn-clicked");

    this.removelabelsTarget.classList.add("d-none");
    this.removelabelsTarget.classList.add("visuallyhidden");
  }

  closeSign(event) {
    let sign = this.addsignTarget;
    let tab = document.querySelector(".add-input-btn-clicked");

    sign.classList.add("d-none");
    sign.classList.add("visuallyhidden");
    tab.classList.remove("add-input-btn-clicked");
    
    this.signInputTarget.querySelectorAll(".form-check").forEach((check) => {
      if (check.querySelector(".radio_buttons").checked == true) {
        this.signBtnTarget.innerHTML = check.querySelector("label").innerHTML;
      };
    });
  }
}
