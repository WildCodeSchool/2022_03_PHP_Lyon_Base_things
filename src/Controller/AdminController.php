<?php

/* creation of the AdminController class to verify login and password  */
namespace App\Controller;

class AdminController extends AbstractController
{
    public function logVerification(): ?string
    {
        $errorMessage = '';

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $_SESSION['password'] = array_map('trim', $_POST);
            if (!empty($_POST['password'])) {
                if ($_POST['password'] !== PASSWORD || $_POST['loginname'] !== LOGIN) {
                    $errorMessage = 'Login ou Mot de passe incorrect !';
                } else {
                    $_SESSION['password'] = PASSWORD;

                    $_SESSION['loginname'] = LOGIN;

                    header('Location: /');
                    return null;
                }
            } else {
                $errorMessage = 'Veuillez inscrire vos identifiants svp !';
            }
        }

        return $this->twig->render('Exit/logIn.html.twig', ['errormessage' => $errorMessage]);
    }
}
