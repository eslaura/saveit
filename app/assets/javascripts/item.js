document.querySelectorAll("div.favorite-icon").forEach((icon) => {
  icon.addEventListener("click", (event) => {
    event.currentTarget.classList.toggle("favorite-icon");
  });
});

// to set:
// item.favorite = true;
