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
  static targets = [ "form", "dreamslist", "filterInput", "filterColInput", "filterOrderInput" ]

  connect() {
    console.log("Hello from filter_labels controller!")
  }
  
  filter() {
    const url = `${this.formTarget.action}?search[title]=${this.filterInputTarget.value}&search[column]=${this.filterColInputTarget.value}&search[order]=${this.filterOrderInputTarget.value}`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.dreamslistTarget.outerHTML = data;
      })
  }
}
