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
        $isLogIn = AdminController::isLogIn();
        $jumpLogManager = new JumpLogManager();
        $jumpLogs = $jumpLogManager->selectJumpExit('date_of_jump');

        return $this->twig->render('JumpLog/index.html.twig', ['jumpLogs' => $jumpLogs, 'islogin' => $isLogIn]);
    }

        /**
     * Delete a specific item
     */
    public function deleteJump(): void
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id = trim($_POST['id']);
            $jumpLogManager = new JumpLogManager();
            $jumpLogManager->deleteJump((int)$id);

            header('Location:/jumplog');
        }
    }
}
