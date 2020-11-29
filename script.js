document.addEventListener("DOMContentLoaded", () => {
  document.querySelector("nav ul").addEventListener("click", (ev) => {
    const target = ev.target;

    if (target.dataset.name) {
      if (target.classList.contains("selected")) return;

      const last = document.querySelector("button.selected");
      last.classList.remove("selected");
      target.classList.add("selected");

      document
        .getElementById(last.dataset.name)
        .classList.remove("display-content");
      document
        .getElementById(target.dataset.name)
        .classList.add("display-content");
    }
  });
});

console.log(
  "Hey! I am looking for an internship from 04-06-21 :)\nFeel free to contact me!"
);
