setTimeout(function() {
  const deleteMessage = document.getElementById('deleteMessage');
  deleteMessage.classList.remove('alert', 'alert-success', 'd-flex', 'align-items-center');
  deleteMessage.classList.add("hiddenMessage")
  }, 5000);
  