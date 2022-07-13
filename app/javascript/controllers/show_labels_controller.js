import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "labelcontainer" ]

  showLabels() {
    this.labelcontainerTarget.innerHTML = "";
    
    document.querySelectorAll(".check_boxes").forEach( check => {
      if (check.checked) {
        let label = check.parentElement.innerText;
        this.labelcontainerTarget.insertAdjacentHTML("beforeend",`<p class="labels">${label}</p>`)
      } 
    })
  }
}
