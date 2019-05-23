import "bootstrap";
import "../plugins/flatpickr";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';

import { initMapbox } from '../plugins/init_mapbox';
import { initAutocompleteCreate } from '../plugins/init_autocomplete';
import { initAutocompleteLanding } from '../plugins/init_autocomplete';

initMapbox();
initAutocompleteCreate();
initAutocompleteLanding();
