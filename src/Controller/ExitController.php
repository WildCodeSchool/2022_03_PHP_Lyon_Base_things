<?php

/* creation of the ExitController class to pass requests to the database */
namespace App\Controller;

use App\Model\ExitManager;

class ExitController extends AbstractController
{
    public function index(): string
    {
        $exitManager = new ExitManager();
        $exits = $exitManager->selectall('name');

        return $this->twig->render('Exit/index.html.twig', ['exits' => $exits]);
    }
}
