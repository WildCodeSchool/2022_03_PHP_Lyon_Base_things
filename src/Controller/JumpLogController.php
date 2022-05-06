<?php

/* creation of the ExitController class to pass requests to the database */

namespace App\Controller;

use App\Model\JumpLogManager;
use App\Controller\AdminController;
use App\Service\JumpLogFilterService;
use App\Service\AddFormService;
use App\Model\ExitManager;

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

    /**
     * Créer nouveau saut
     */
    public function add(): ?string
    {
        $isLogIn = AdminController::isLogIn();
        $jumpLogManager = new JumpLogManager();
        $exits = $jumpLogManager->selectExits();
        $errorMessages = [];
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $uploadDir = 'assets/images/';
            $jumpLog = [];
            foreach ($_POST as $key => $val) {
                $jumpLog[$key] = trim($val);
            }
            $errorMessages = AddFormService::checkLengthDataJump($jumpLog, $errorMessages);
            $errorMessages = AddFormService::isEmptyDataJump($jumpLog, $errorMessages);
            $pseudo = $_POST['pseudo'];
            $uploadFile = '';
            if (!empty($_FILES['image']['name'])) {
                $explodeName = explode('.', basename($_FILES['image']['name']));
                $name = $explodeName[0];
                $extension = strToLower(pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION));
                $uniqName = $name . uniqid('', true) . "." . $extension;
                $uploadFile = $uploadDir . $uniqName;
                $errorMessages = AddFormService::validateExtension($errorMessages);
                $errorMessages = AddFormService::validateMaxFileSize($errorMessages);
            }
            if (empty($errorMessages)) {
                move_uploaded_file($_FILES['image']['tmp_name'], $uploadFile);
                $jumpLog['image'] = $uploadFile;
                $idUser = $jumpLogManager->insertPseudo($pseudo);
                $jumpLogManager->insertJumpLog($idUser, $jumpLog);
                header('Location:/jumplog');
                return null;
            }
        }
        return $this->twig->render('JumpLog/add.html.twig', [
            'error_messages' => $errorMessages,
            'exits' => $exits,
            'islogin' => $isLogIn
        ]);
    }

        /**
     * Delete a specific item
     */
    public function deleteJump(): void
    {
        $isLogIn = AdminController::isLogIn();

        if (!$isLogIn) {
            header('Location: /login');
        } elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id = trim($_POST['id']);
            $jumpLogManager = new JumpLogManager();
            $jumpLogManager->deleteJump((int)$id);

            header('Location:/jumplog');
        }
    }
}
