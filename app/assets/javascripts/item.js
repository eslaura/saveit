document.querySelectorAll(".favorite-icon i").forEach((icon) => {
  icon.addEventListener("click", (event) => {
    event.preventDefault()
    event.currentTarget.classList.toggle("fa-heart-o");
     event.currentTarget.classList.toggle("fa-heart");
  });
});

// to set:
// item.favorite = true;
