<?php

namespace App\Controller;

class HomeController extends AbstractController
{
    /**
     * Display home page
     */
    public function index(): string
    {
        $isLogIn = AdminController::isLogIn();
        return $this->twig->render('Home/index.html.twig', ['islogin' => $isLogIn]);
    }
}
