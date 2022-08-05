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
  static targets = [ "button", "year" ]
  
  toggleDreams(event) {
    const btnId = event.currentTarget.id
    if(btnId.length == 4) {
      document.getElementById(`year-${btnId}`).classList.toggle("d-none")
    } else {
      document.querySelectorAll(`.dream-${btnId.substring(0,4)}-${btnId.substr(5, btnId.length)}`).forEach( elm => {
        elm.classList.toggle("d-none")
      })
    }
  }
}
