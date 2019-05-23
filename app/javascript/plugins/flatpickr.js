import flatpickr from "flatpickr"
import "flatpickr/dist/themes/material_orange.css" // Note this is important!
import "flatpickr/dist/flatpickr.min.css"
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"

// On booking page
flatpickr("#range_start", {
  enableTime: true,
  time_24hr: true,
  minDate: "today"
})

flatpickr("#range_end", {
  enableTime: true,
  time_24hr: true,
  minDate: "today"
})

// on home page
flatpickr(".datepicker", {
  enableTime: true,
  allowInput: true,
  time_24hr: true,
  inline: true,
  minDate: "today"
})
