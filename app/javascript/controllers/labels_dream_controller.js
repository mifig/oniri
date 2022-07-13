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
  static targets = [ "addlabel", "removesign", "labelsBtn" ]

  showLabels(event) {
    console.log(this.removesignTarget);
    let label = this.addlabelTarget;
    let clickedBtn = event.currentTarget;
    let siblingBtn = clickedBtn.previousElementSibling;

    siblingBtn.classList.remove("add-input-btn-clicked");
    label.classList.remove("d-none");
    label.classList.remove("visuallyhidden");
    clickedBtn.classList.add("add-input-btn-clicked");

    this.removesignTarget.classList.add("d-none");
    this.removesignTarget.classList.add("visuallyhidden");
  }

  closeLabels() {
    let label = this.addlabelTarget;
    let tab = document.querySelector(".add-input-btn-clicked");

    label.classList.add("d-none");
    label.classList.add("visuallyhidden");
    tab.classList.remove("add-input-btn-clicked");
  }
}
