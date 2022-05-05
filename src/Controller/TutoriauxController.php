<?php

/* creation of the ExitController class to pass requests to the database */
namespace App\Controller;

class TutoriauxController extends AbstractController
{
    /**
     * List jump_log
     */
    public function index(): string
    {
        return $this->twig->render('Tutoriaux/index.html.twig');
    }
}
