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
        $jumpLogs = $jumpLogManager->selectJumpExit('date_of_jump', 'DESC');
        $pseudoForFilters = JumpLogFilterService::retrievePseudoForFilters($jumpLogs);
        $filterActivated = '';

        if (!empty($_SERVER['REQUEST_METHOD'] === 'POST')) {
            $filterActivated = implode("', '", $_POST);
            $jumpLogs = $jumpLogManager->selectJumpExit('date_of_jump', 'DESC', $filterActivated);
        }

        return $this->twig->render('JumpLog/index.html.twig', [
            'jumpLogs' => $jumpLogs,
            'pseudoForFilters' => $pseudoForFilters,
            'filterActivated' => $filterActivated,
            'islogin' => $isLogIn
        ]);
    }
}
