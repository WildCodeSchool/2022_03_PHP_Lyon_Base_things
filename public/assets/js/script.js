function is_checked(checkbox_name) {
//avec cette fonction, on boucle chaque case et retourne true si ya une case cochée
let checkbox = document.querySelectorAll('input[name="'+checkbox_name+'"]');
for (let i = 0; i < checkbox.length; i++) {
if(checkbox[i].checked)
return true;
}
document.getElementById('error_messages').innerHTML  = "Vous devez choisir au moins un Type de saut";
//sinon on retourne false
return false;
}

