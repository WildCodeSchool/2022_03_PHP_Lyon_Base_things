<?php

namespace App\Controller;

use App\Model\JumpManager;

class JumpController extends AbstractController
{
    /**
     * List jumps
     */
    public function index(): string
    {
        $jumpManager = new JumpManager();
        $jumps = $jumpManager->selectAll('date_of_jump');

        return $this->twig->render('Jump/index.html.twig', ['jumps' => $jumps]);
    }
}
