import flatpickr from "flatpickr";

const initFlatpickr = () => {
  flatpickr(".datepicker", {  enableTime: true,
                              altInput: true });
};

export { initFlatpickr };