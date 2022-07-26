import flatpickr from "flatpickr";

const initFlatpickr = (dreamDate = null) => {
  let iniDate = (dreamDate == null ? new Date() : new Date(Date.parse(dreamDate)))
  console.log(iniDate);
  flatpickr(".datepicker", {  enableTime: false,
                              defaultDate: iniDate,
                              dateFormat: "Y-M-d"
                              // altFormat: "Y-M-d",
                              // altInput: false 
                            });
};

export { initFlatpickr };