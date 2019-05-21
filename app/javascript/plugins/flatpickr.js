import flatpickr from "flatpickr"
import "flatpickr/dist/themes/airbnb.css" // Note this is important!


flatpickr(".datepicker", {
  enableTime: true,
  allowInput: true,
  time_24hr: true,
  inline: true
})
