<?php

/* creation of the ExitController class to pass requests to the database */

namespace App\Controller;

use App\Model\JumpLogManager;
use App\Controller\AdminController;
use App\Service\JumpLogFilterService;

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
        $pseudoForFilters = JumpLogFilterService::retrievePseudoForFilters($jumpLogs);

        return $this->twig->render('JumpLog/index.html.twig', [
            'jumpLogs' => $jumpLogs,
            'pseudoForFilters' => $pseudoForFilters,
            'islogin' => $isLogIn
        ]);
    }
}
