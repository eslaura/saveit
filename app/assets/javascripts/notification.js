
const notifications = document.getElementById("notification-navbar");
notification.addEventListener("click", (event) => {
  fetch(`${notifications.dataset.url}`, {
    method: 'POST'
  });
});

const notification = document.getElementById("notification-unread");
notification.addEventListener("click", (event) => {
  console_log("Hello World please work!!");
  fetch(`${notification.dataset.url}`, {
    method: 'POST'
  });
});
