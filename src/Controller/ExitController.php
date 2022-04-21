<?php

/* creation of the ExitController class to pass requests to the database */
namespace App\Controller;

use App\Model\ExitManager;
use App\Controller\AdminController;

class ExitController extends AbstractController
{
    public function index(): string
    {
        $exitManager = new ExitManager();
        $exits = $exitManager->selectall('name');

        $isLoggedIn = $this->isLogIn();

        return $this->twig->render('Exit/index.html.twig', ['exits' => $exits, 'isLoggedIn' => $isLoggedIn]);
    }
    public function isLogIn(): bool
    {
        if (isset($_SESSION['password']) && isset($_SESSION['loginname'])) {
            return true;
        }
        return false;
    }
}
