/* function pour verifier si une checkbox a été cocher et empecher l'envoi du formulaire de création*/
function is_checked(checkbox_name) {
//on boucle sur chaque checkbox et retourne true si il y a une case cochée
let checkbox = document.querySelectorAll('input[name="'+checkbox_name+'"]');
for (let i = 0; i < checkbox.length; i++) {
if(checkbox[i].checked)
return true;
}
document.getElementById('error_messages').innerHTML  = "Vous devez choisir au moins un Type de saut";
//sinon on retourne false pour empecher la soumission 
return false;
}

/* Script pour faire disparaitre le message de confirmation de suppression au bout de 5 secs */

if (document.getElementById('deleteMessage')) {
  setTimeout(function () {
    const deleteMessage = document.getElementById('deleteMessage');
    deleteMessage.classList.remove('alert', 'alert-success', 'd-flex', 'align-items-center');
    deleteMessage.classList.add("hiddenMessage")
  }, 5000);
}
