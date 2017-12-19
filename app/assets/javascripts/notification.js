
const notification = document.getElementById("notification-navbar");
notification.addEventListener("click", (event) => {
  console.log("Is this working?");
  fetch(`${notification.dataset.url}`, {
    method: 'POST'
  });
  console.log(event);
  console.log(event.currentTarget);
});
