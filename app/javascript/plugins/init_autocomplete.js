import places from 'places.js';


// autocomplete when creating
const initAutocompleteCreate = () => {
  const addressInput = document.getElementById('station_address');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocompleteCreate };

// autocomplete on landing page
const initAutocompleteLanding = () => {
  const addressInput = document.getElementById('search_address');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocompleteLanding };
