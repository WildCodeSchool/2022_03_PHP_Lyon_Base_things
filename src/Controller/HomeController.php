<?php

namespace App\Controller;

use App\Controller\AdminController;

class HomeController extends AbstractController
{
    /**
     * Display home page
     */
    public function index(): string
    {
        $adminController = new AdminController();
        $isLogIn = $adminController->isLogIn();
        return $this->twig->render('Home/index.html.twig', ['islogin' => $isLogIn]);
    }
}
