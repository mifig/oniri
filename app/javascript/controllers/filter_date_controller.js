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
  static targets = [ "form", "dreamstats", "filterInput" ]
  
  filter() {
    if(this.filterInputTargets[0].value != '' && this.filterInputTargets[1].value != '') {
      let beginDate = new Date(Date.parse(this.filterInputTargets[0].value)).toUTCString();
      let endDate = new Date(Date.parse(this.filterInputTargets[1].value)).toUTCString();
      const url = `${this.formTarget.action}?search[begin_date]='${beginDate}'&search[end_date]='${endDate}'`
      fetch(url, { headers: { 'Accept': 'text/plain' } })
        .then(response => response.text())
        .then((data) => {
          console.log(this.dreamstatsTarget)
          this.dreamstatsTarget.outerHTML = data
          
          // Rerun (=recreate) Chartkick scripts, since outerHTML substitution doesn't
          // run the script functions of chatkcik.js:
          Array.from(this.dreamstatsTarget.querySelectorAll("script")).forEach( oldScript => {
            const newScript = document.createElement("script");
            Array.from(oldScript.attributes).forEach( attr => 
              newScript.setAttribute(attr.name, attr.value) 
            );
  
            newScript.appendChild(document.createTextNode(oldScript.innerHTML));
            oldScript.parentNode.replaceChild(newScript, oldScript);
          });
        }
      )
    }
  }
}
