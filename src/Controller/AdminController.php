<?php

/* creation of the AdminController class to verify login and password  */
namespace App\Controller;

class AdminController extends AbstractController
{
    public function logVerification(): ?string
    {
        $errorMessage = '';
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $data = array_map('trim', $_POST);
            if (!empty($data['password']) && !empty($data['loginname'])) {
                if ($data['password'] !== PASSWORD || $data['loginname'] !== LOGIN) {
                    $errorMessage = 'Login ou Mot de passe incorrect !';
                } else {
                    $_SESSION['password'] = PASSWORD;
                    $_SESSION['loginname'] = LOGIN;

                    header('Location: /');
                    return null;
                }
            } else {
                $errorMessage = 'Veuillez renseigner votre login et votre mot de passe !';
            }
        }
        return $this->twig->render('Login/logIn.html.twig', ['error_message' => $errorMessage]);
    }

    public function logout(): void
    {
        if ($this->isLogIn() === true) {
            session_destroy();
        }
        header("location:/");
    }

    public static function isLogIn(): bool
    {
        if (isset($_SESSION['password']) && isset($_SESSION['loginname'])) {
            return true;
        }
        return false;
    }
}
