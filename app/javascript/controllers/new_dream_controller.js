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
  static targets = [ "form" ]

  connect() {
    if (document.querySelector(".invalid-feedback")) {
      document.querySelector(".add-btn").remove()
      document.querySelector(".save-btn").classList.remove("d-none")
    }
  }

  sendForm() {
    this.formTarget.submit();
  }
}
