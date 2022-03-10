import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "sign" ]

  showSign() {
    this.signTarget.innerHTML = "";
    
    document.querySelectorAll(".radio_buttons").forEach( radio => {
      if (radio.checked) {
        let sign = radio.parentElement.innerText;
        this.signTarget.innerHTML= `<i class="fas fa-cog"></i> ${sign}`;
      } 
    })
  }
}
