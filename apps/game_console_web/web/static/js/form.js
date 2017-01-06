
document.addEventListener("turbolinks:load", function() {
  let elem = document.querySelector('form[ujs-remote]')
  elem.addEventListener('ajax:success', function (e) { eval(e.data.xhr.response) }, false);
  // elem.addEventListener('ajax:success', function (e) {
  //   Turbolinks.clearCache()
  //   console.log(e.data.xhr.response)
  // }, false);
})
