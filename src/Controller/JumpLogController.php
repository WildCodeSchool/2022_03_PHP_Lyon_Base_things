<?php

/* creation of the ExitController class to pass requests to the database */
namespace App\Controller;

use App\Model\JumpLogManager;
use App\Controller\AdminController;

class JumpLogController extends AbstractController
{
    /**
     * List jump_log
     */
    public function index(): string
    {
        $jumpLogManager = new JumpLogManager();
        $jumpLogs = $jumpLogManager->selectJumpExit('date_of_jump');
        $isLogIn = AdminController::isLogIn();

        return $this->twig->render('JumpLog/index.html.twig', ['jumpLogs' => $jumpLogs,'islogin' => $isLogIn]);
    }
}
