<?php

/* creation of the ExitController class to pass requests to the database */
namespace App\Controller;

use App\Controller\AdminController;

class TutorialsController extends AbstractController
{
    /**
     * List jump_log
     */
    public function index(): ?string
    {
        $isLogIn = AdminController::isLogIn();

        if (!$isLogIn) {
            header('Location: /login');
            return null;
        } else {
            return $this->twig->render('Tutorials/index.html.twig', [
                                        'islogin' => $isLogIn,
                                        ]);
        }
    }
}
