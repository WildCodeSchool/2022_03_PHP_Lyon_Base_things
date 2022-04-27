<?php

/* creation of the ExitController class to pass requests to the database */
namespace App\Controller;

use App\Model\JumpLogManager;
/* use App\Controller\AdminController; */

class JumpLogController extends AbstractController
{
    /**
     * List jump_log
     */
    public function index(): string
    {
        $jumpLogManager = new JumpLogManager();
        $jumpLogs = $jumpLogManager->selectAll('date_of_jump');
        $typeJumpByExit = $exitManager->selectTypeJumpByExitId($id);

        return $this->twig->render('JumpLog/index.html.twig', ['jumpLogs' => $jumpLogs,
                                                                'typeJumpByExit' => $typeJumpByExit]);
    }

    /**
    * Show informations for a specific exit
    */
    public function show(int $id): string
    {
        $adminController = new AdminController();
        $exitManager = new ExitManager();
        $exit = $exitManager->selectOneById($id);
        $isLogIn = $adminController->isLogIn();
        $typeJumpByExit = $exitManager->selectTypeJumpByExitId($id);

        return $this->twig->render('Exit/show.html.twig', ['exit' => $exit,
                                                            'typeJumpByExit' => $typeJumpByExit,
                                                            'islogin' => $isLogIn]);
    }


}
