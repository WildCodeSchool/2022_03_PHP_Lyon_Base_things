<?php

namespace App\Controller;

use App\Model\ExitManager;

class ExitController extends AbstractController
{
    public function index(): string
    {
        $exitManager = new ExitManager();
        $exits = $exitManager->selectall('name');

        return $this->twig->render('exit/index.html.twig', ['exits' => $exits]);
    }
}
