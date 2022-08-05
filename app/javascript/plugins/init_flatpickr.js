import flatpickr from "flatpickr";

const initFlatpickr = (dreamDate = null) => {
  var iniDate = new Date()
  if(dreamDate != null) {
    var iniDate = new Date(dreamDate.split(/[-\s]/)[0], dreamDate.split(/[-\s]/)[1] - 1, dreamDate.split(/[-\s]/)[2]);
  }

  flatpickr(".datepicker", {  defaultDate: iniDate,
                              disableMobile: true,
                              dateFormat: "d M Y"
                            });
};

export { initFlatpickr };