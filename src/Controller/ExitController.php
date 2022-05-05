<?php

/* creation of the ExitController class to pass requests to the database */

namespace App\Controller;

use App\Model\ExitManager;
use App\Model\TypeJumpManager;
use App\Controller\AdminController;
use App\Service\ExitFilterService;
use Doctrine\Common\Collections\Expr\Value;
use App\Service\AddFormService;

class ExitController extends AbstractController
{
    /**
     * List exits
     */
    public function index(): string
    {
        $exitManager = new ExitManager();
        $isFilterActive = ExitFilterService::isFilterActive();
        $isLogIn = AdminController::isLogIn();
        $isFilterActive = ExitFilterService::isFilterActive();
        $jumpFiltersList = [];
        $depFiltersList = [];
        $deleteExitName = '';
        if (isset($_GET['deleteExitName'])) {
            $deleteExitName = $_GET['deleteExitName'];
        }
        if (!empty(ExitFilterService::retrieveFilters())) {
            $filter = ExitFilterService::retrieveFilters();
            $depFiltersList = ExitFilterService::depFiltersList($filter);
            $jumpFiltersList = ExitFilterService::jumpFiltersList($filter);
            $exits = $exitManager->exitsFiltered($filter);
            header('location: /exits');
        } elseif (!empty(ExitFilterService::sessionRetrieveFilters())) {
            $filter = ExitFilterService::sessionRetrieveFilters();
            $jumpFiltersList = ExitFilterService::jumpFiltersList($filter);
            $depFiltersList = ExitFilterService::depFiltersList($filter);
            $exits = $exitManager->exitsFiltered($filter);
        } else {
            $exits = $exitManager->selectAllExit('name');
            $filter = null;
        }
        return $this->twig->render('Exit/index.html.twig', [
            'exits' => $exits,
            'islogin' => $isLogIn,
            'filters' => $filter,
            'isFilterActive' => $isFilterActive,
            'depFiltersList' => $depFiltersList,
            'jumpFiltersList' => $jumpFiltersList,
            'deleteExitName' => $deleteExitName,
            ]);
    }

    /**
     * Show informations for a specific exit
     */
    public function show(int $id): string
    {
        $exitManager = new ExitManager();
        $exit = $exitManager->selectOneById($id);
        $isLogIn = AdminController::isLogIn();
        $typeJumpByExit = $exitManager->selectTypeJumpByExitId($id);

        return $this->twig->render('Exit/show.html.twig', [
            'exit' => $exit,
            'typeJumpByExit' => $typeJumpByExit,
            'islogin' => $isLogIn
        ]);
    }

    /**
     * Edit a specific exit
     */
    public function edit(int $id): ?string
    {

        $isLogIn = AdminController::isLogIn();
        $exitManager = new ExitManager();
        $exit = $exitManager->selectOneById($id);
        $typeJumpByExitId = $exitManager->selectTypeJumpByExitId($id);
        $typeJumpManager = new TypeJumpManager();
        $typeJump = $typeJumpManager->selectAll();
        $errorMessages = [];

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $exit = AddFormService::trimPostData(); // nettoyage des données
            // verifié si certain champ sont vide
            $errorMessages = AddFormService::isEmpty($exit, $errorMessages);
            $errorMessages = AddFormService::checkLengthData($exit, $errorMessages);
            $uploadDir = 'assets/images/'; // definir le dossier de stockage de l'image
            // on renvoi l'ancien chemin pour mettre en BDD
            $uploadFile = $exit['image'];
            if (!empty($_FILES['image']['name'])) { // on ajoute un uniqid au nom de l'image
                $explodeName = explode('.', basename($_FILES['image']['name']));
                $name = $explodeName[0];
                $extension = strToLower(pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION));
                $uniqName = $name . uniqid('', true) . "." . $extension;
                $uploadFile = $uploadDir . $uniqName;
                $errorMessages = AddFormService::validateExtension($errorMessages);
                $errorMessages = AddFormService::validateMaxFileSize($errorMessages);
            } if (empty($errorMessages)) {
                move_uploaded_file($_FILES['image']['tmp_name'], $uploadFile);
                $exit['image'] = $uploadFile;
                // if validation is ok, update and redirection
                $exitManager->update($exit);
                if (!empty($exit['jumpTypes'])) {
                    $exit['value'] = $exit['jumpTypes'];
                    $exitManager->updateExitHasTypeJump($id, $exit['value']);
                }

                header('Location: /exits/show?id=' . $id);

                // we are redirecting so we don't want any content rendered
                return null;
            }
        }
        return $this->twig->render('Exit/edit.html.twig', [
            'exit' => $exit,
            'typesJumpsByExit' => $typeJumpByExitId,
            'typesJumps' => $typeJump,
            'islogin' => $isLogIn,
            'error_messages' => $errorMessages
        ]);
    }

    /**
     * Hide a specific exit
     */
    public function hide(): void
    {
        $isLogIn = AdminController::isLogIn();

        if (!$isLogIn) {
            header('Location: /login');
        } elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id = trim($_POST['id']);
            $name = trim($_POST['name']);
            $exitManager = new ExitManager();
            $exitManager->hide((int)$id);
            header('Location: /exits/?deleteExitName=' . $name);
        }
    }

    /**
     * Créer nouvel exit
     */
    public function add(): ?string
    {
        $isLogIn = AdminController::isLogIn();
        $errorMessages = [];
        $accessmessage = AdminController::accessDenied();
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $uploadDir = 'assets/images/'; // definir le dossier de stockage de l'image
            $exit = AddFormService::trimPostData(); // suppression des espace
            $uploadFile = $uploadDir . basename($_FILES['image']['name']);
            $errorMessages = AddFormService::isEmpty($exit, $errorMessages);
            $errorMessages = AddFormService::checkLengthData($exit, $errorMessages);
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
                $exit['image'] = $uploadFile;
                $exitManager = new ExitManager();
                $id = $exitManager->insert($exit);
                if (!empty($exit['jumpTypes'])) {
                    $exit['value'] = $exit['jumpTypes'];
                    $exitManager->insertJumpType($id, $exit['value']);
                }
                header('Location:/exits/show?id=' . $id);
                return null;
            }
        }
        return $this->twig->render('Exit/add.html.twig', [
            'error_messages' => $errorMessages,
            'islogin' => $isLogIn,
            'accessdenied' => $accessmessage
        ]);
    }

    /**
     * Unset filters
     */
    public function unsetFilters(): void
    {
        if (isset($_SESSION["filterByJumpTypes"])) {
            unset($_SESSION['filterByJumpTypes']);
        }

        if (isset($_SESSION["filterByDepartment"])) {
            unset($_SESSION['filterByDepartment']);
        }

        header('Location:/exits');
    }
}
