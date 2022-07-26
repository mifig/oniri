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
  static targets = [ "addsign", "removelabels", "signBtn", "signInput", "checkbox" ]

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

  closeSign() {
    let sign = this.addsignTarget;

    sign.classList.add("d-none");
    sign.classList.add("visuallyhidden");
    
    this.signInputTarget.querySelectorAll(".form-check").forEach((check) => {
      if (check.querySelector(".check_boxes").checked == true) {
        this.signBtnTarget.innerHTML = check.querySelector("label").innerHTML;
      };
    });
  }

  checkOneOnly(event) {
    this.checkboxTargets.forEach((checkbox) => {
      if(event.target.checked == false)
        event.target.checked = false
      else
        checkbox.checked = (checkbox == event.target)
    })
  }
}
