import flatpickr from "flatpickr";

const initFlatpickr = () => {
  flatpickr(".datepicker", {  enableTime: false,
                              defaultDate: new Date(),
                              dateFormat: "Y-M-d"
                              // altFormat: "Y-M-d",
                              // altInput: false 
                            });
};

export { initFlatpickr };