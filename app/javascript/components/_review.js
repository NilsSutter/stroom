// button.addEventListener('click', (event) => {
//   event.preventDefault();
//   event.classList.toggle('hide-review-input-field');
// });

// export {buttonReviewForm};


const buttonReviewForm = document.querySelector(".form-botton-display");

const formReview = document.getElementById("review-form-div");


buttonReviewForm.addEventListener('click', (event) => {
  formReview.style.display = "flex";
  formReview.style.transition = "ease 5s"
});
