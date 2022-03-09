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
  static targets = [ "addlabel" ]

  showLabels() {
    // console.log(this.addlabelTarget);
    // this.addlabelTarget.classList.toggle("d-none-transition")
    let label = this.addlabelTarget;

    if (label.classList.contains('d-none')) {
      label.classList.remove('d-none');
      setTimeout(function () {
        label.classList.remove('visuallyhidden');
      }, 0);
    } else {
      label.classList.add('visuallyhidden');    
      label.addEventListener('transitionend', function(e) {
        label.classList.add('d-none');
      }, {
        capture: false,
        once: true,
        passive: false
      });
    }
  }
}
