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
        $arrayFilterActivated = [];

        /* If POST received >>> retrieval of filters in the POST */
        if (!empty($_SERVER['REQUEST_METHOD'] === 'POST')) {
            $arrayFilterActivated = $_POST;
            $_SESSION['pseudoFilterActivated'] = $arrayFilterActivated;
        }

        /* If record present in session >>> retrieval of filters in $_SESSION */
        if (!empty($_SESSION['pseudoFilterActivated'])) {
            $arrayFilterActivated = $_SESSION['pseudoFilterActivated'];
        }

        $filterActivated = implode("', '", $arrayFilterActivated);
        $jumpLogs = $jumpLogManager->selectJumpExit('date_of_jump', 'DESC', $filterActivated);

        $filterActivated = implode("/ ", $arrayFilterActivated);

        return $this->twig->render('JumpLog/index.html.twig', [
            'jumpLogs' => $jumpLogs,
            'pseudoForFilters' => $pseudoForFilters,
            'filterActivated' => $filterActivated,
            'arrayFilterActivated' => $arrayFilterActivated,
            'islogin' => $isLogIn
        ]);
    }

    /**
     * Unset filters
     */
    public function unsetPseudoFilters(): void
    {
        if (isset($_SESSION["pseudoFilterActivated"])) {
            unset($_SESSION['pseudoFilterActivated']);
        }

        header('Location:/jumplog');
    }
}
