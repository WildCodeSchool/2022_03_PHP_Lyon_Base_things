/* Script pour faire disparaitre le message de confirmation de suppression au bout de 5 secs */

if (document.getElementById('deleteMessage')) {
  setTimeout(function () {
    const deleteMessage = document.getElementById('deleteMessage');
    deleteMessage.classList.remove('alert', 'alert-success', 'd-flex', 'align-items-center');
    deleteMessage.classList.add("hiddenMessage")
  }, 5000);
}
