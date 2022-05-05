<?php

/* creation of the ExitController class to pass requests to the database */
namespace App\Controller;

use App\Model\JumpLogManager;
use App\Controller\AdminController;
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
        $jumpLogs = $jumpLogManager->selectJumpExit('date_of_jump');

        return $this->twig->render('JumpLog/index.html.twig', ['jumpLogs' => $jumpLogs, 'islogin' => $isLogIn]);
    }

    /**
     * Créer nouveau saut
     */
    public function add(): ?string
    {
        $jumpLogManager = new JumpLogManager();
        $exits = $jumpLogManager->selectExits();
        $errorMessages = [];
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $uploadDir = 'assets/images/';
            $jumpLog = [];
            foreach ($_POST as $key => $val) {
                $jumpLog[$key] = trim($val);
            }
            $pseudo = $_POST['pseudo'];
            $uploadFile = $uploadDir . basename($_FILES['image']['name']);
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
                echo $idUser;
                var_dump($jumpLog);
                $jumpLogManager->insertJumpLog($idUser, $jumpLog);
                header('Location:/jumplog');
                return null;
            }
        }
        return $this->twig->render('jumplog/add.html.twig', [
            'error_messages' => $errorMessages,
            'exits' => $exits
        ]);
    }
}
