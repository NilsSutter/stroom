import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('flat_address');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocomplete };


// autocomplete when creating
const initAutocompleteTwo = () => {
  const addressInput = document.getElementById('station_address');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocompleteTwo };

// autocomplete on landing page
// const initAutocompleteThree = () => {
//   const addressInput = document.getElementById('search_address');
//   if (addressInput) {
//     places({ container: addressInput });
//   }
// };

// export { initAutocompleteThree };
