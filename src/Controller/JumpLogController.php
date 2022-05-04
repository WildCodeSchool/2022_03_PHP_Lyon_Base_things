<?php

/* creation of the ExitController class to pass requests to the database */
namespace App\Controller;

use App\Model\JumpLogManager;
use App\Controller\AdminController;
use App\Service\AddFormService;

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
        $errorMessages = [];
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $uploadDir = 'assets/images/'; // definir le dossier de stockage de l'image
            //$jumpLog = AddFormService::trimPostData(); // suppression des espaces
            $jumpLog = $_POST;
            $pseudo = $_POST['pseudo'];
            var_dump($_POST);
            $uploadFile = $uploadDir . basename($_FILES['image']['name']);
            // $errorMessages = AddFormService::isEmpty($jumpLog, $errorMessages);
            // $errorMessages = AddFormService::checkLengthData($jumpLog, $errorMessages);
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
                var_dump($jumpLog);
                $jumpLogManager = new JumpLogManager();
                $idUser = $jumpLogManager->insertPseudo($pseudo);
                $jumpLogManager->insertJumpLog($idUser, $jumpLog);
                var_dump($jumpLog);
                return null;
            }
        }
        return $this->twig->render('jumplog/add.html.twig', [
            'error_messages' => $errorMessages,
        ]);
    }
}
