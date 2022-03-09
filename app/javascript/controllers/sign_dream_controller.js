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
  static targets = [ "addsign" ]

  showSigns() {
    console.log("Hello from signs")
    let sign = this.addsignTarget;

    if (sign.classList.contains('d-none')) {
      sign.classList.remove('d-none');
      setTimeout(function () {
        sign.classList.remove('visuallyhidden');
      }, 0);
    } else {
      sign.classList.add('visuallyhidden');    
      sign.addEventListener('transitionend', function(e) {
        sign.classList.add('d-none');
      }, {
        capture: false,
        once: true,
        passive: false
      });
    }
  }
}
