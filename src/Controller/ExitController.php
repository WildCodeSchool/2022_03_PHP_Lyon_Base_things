<?php

/* creation of the ExitController class to pass requests to the database */
namespace App\Controller;

use App\Model\ExitManager;
use Doctrine\Common\Collections\Expr\Value;

class ExitController extends AbstractController
{
    /**
     * List exits
     */
    public function index(): string
    {
        $exitManager = new ExitManager();
        $isLogIn = AdminController::isLogIn();
        $exits = $exitManager->selectAll('name');
        return $this->twig->render('Exit/index.html.twig', ['exits' => $exits,'islogin' => $isLogIn]);
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

        return $this->twig->render('Exit/show.html.twig', ['exit' => $exit,
                                                            'typeJumpByExit' => $typeJumpByExit,
                                                            'islogin' => $isLogIn]);
    }

    /**
     * Edit a specific exit
     */
    public function edit(int $id): ?string
    {
        $exitManager = new ExitManager();
        $exit = $exitManager->selectOneById($id);
        $isLogIn = AdminController::isLogIn();

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            // clean $_POST data
            $exit = array_map('trim', $_POST);

            // TODO validations (length, format...)

            // if validation is ok, update and redirection
            $exitManager->update($exit);

            header('Location: /exits/show?id=' . $id);

            // we are redirecting so we don't want any content rendered
            return null;
        }

        return $this->twig->render('Exit/edit.html.twig', [
            'exit' => $exit,
            'islogin' => $isLogIn]);
    }
    /**
     * Delete a specific exit
     */
    public function delete(): void
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id = trim($_POST['id']);
            $exitManager = new ExitManager();
            $exitManager->delete((int)$id);

            header('Location:/exits');
        }
    }

    /**
     * Créer nouvel exit
     */
    public function add(): ?string
    {
        $isLogIn = AdminController::isLogIn();
        $errorMessage = '';
        $accesmessage = AdminController::accessDenied();
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $exit = $this->trimPostData(); // nettoyage des données
            // verifié si certain champ sont vide
            if (ExitController::isEmpty($exit, $errorMessage)) {
                $errorMessage = ExitController::isEmpty($exit, $errorMessage);
            }
            if (ExitController::checkDataLength($exit, $errorMessage)) {
                $errorMessage = ExitController::checkDataLength($exit, $errorMessage);
            } else {
                $uploadDir = 'assets/images/'; // definir le dossier de stockage de l'image
                $extension = strToLower(pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION));
                $authorizedExtensions = ['jpg','jpeg','png']; // definir les extension autorisé
                $maxFileSize = 2000000; // definir le poid max de l'image
                if (empty($_FILES['image']['name'])) { // verifié si on upload une image
                    // on renvoi une chaine vide pour mettre en BDD
                    $uploadFile = "";
                } else { // on ajoute un uniqid au nom de l'image
                    $explodeName = explode('.', basename($_FILES['image']['name']));
                    $name = $explodeName[0];
                    $extension = $explodeName[1];
                    $uniqName = $name . uniqid('', true) . "." . $extension;
                    $uploadFile = $uploadDir . $uniqName;
                } if ((!in_array($extension, $authorizedExtensions))) {
                    $errorMessage = "Format d'image non supporté !
                    Seuls les formats Jpg , Jpeg ou Png sont supportés.";
                }
                if (
                    file_exists($_FILES['image']['tmp_name']) &&
                    filesize($_FILES['image']['tmp_name']) > $maxFileSize
                ) {
                    $errorMessage = 'Votre image doit faire moins de 2M !';
                }
                move_uploaded_file($_FILES['image']['tmp_name'], $uploadFile);
                $exit ['image'] = $uploadFile;
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
        return $this->twig->render('Exit/add.html.twig', ['error_message' => $errorMessage,
                                                            'islogin' => $isLogIn,
                                                            'acessdenied' => $accesmessage]);
    }

    public function trimPostData(): array
    {
        $datas = [];
        foreach ($_POST as $key => $data) {
            if (is_array($data)) {
                $datas += array($key => $data);
                continue;
            }
            $datas += array( $key => (trim($data)));
        }
        return $datas;
    }

    public static function checkDataLength(array $exit, string $errorMessage): string
    {
        if (strlen($exit['name']) > 150) {
            $errorMessage = 'Le champs Nom doit être inferieur a 150 caractères';
        }
        if (strlen($exit['height']) > 150) {
            $errorMessage = 'Les champ Hauteur doit être inferieur a 150 caractères';
        }
        if (strlen($exit['department']) > 50) {
            $errorMessage = 'Le champ Département doit être inferieur a 50 caractères';
        }
        if (strlen($exit['country']) > 50) {
            $errorMessage = 'Le champ Pays doit être inferieur a 50 caractères';
        }
        if (strlen($exit['gps_coordinates']) > 50) {
            $errorMessage = 'Le champ Coordonnées GPS doit être inferieur a 50 caractères';
        }
        return $errorMessage;
    }

    public static function isEmpty(array $exit, string $errorMessage): string
    {
        if (
            empty($exit['name']) ||
            empty($exit['department']) ||
            empty($exit['country']) ||
            empty($exit['height']) ||
            empty($exit['acces']) ||
            empty($exit['jumpTypes'])
        ) {
            $errorMessage = 'Les champs Nom, Pays, Département, Hauteur, Accès,
            et Type de saut sont obligatoire';
        }
        return $errorMessage;
    }
}
