const cards = document.querySelectorAll(".card");

function post_to_url(path, params, method) {
  method = method || "post";
  var form = document.createElement("form");
  form.setAttribute("method", method);
  form.setAttribute("action", path);
  for (var key in params) {
    var hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("name", key);
    hiddenField.setAttribute("value", params[key]);
    form.appendChild(hiddenField);
  }
  document.body.appendChild(form);
  form.submit();
}

function cardSelect(e) {
  const index = e.target.getAttribute("data-index");
  const value = e.target.innerHTML;
  console.log(index, value);
  post_to_url("cardUpdate.jsp", { index: index }, "post");
}

cards.forEach(function (item, index, next) {
  item.addEventListener("click", cardSelect);
});
