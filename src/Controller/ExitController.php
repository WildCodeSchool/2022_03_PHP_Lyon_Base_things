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
        if (!empty($this->retrieveFilters())) {
            $filter = $this->retrieveFilters();
            $exits = $exitManager->exitsFiltered($filter);
        } else {
            $exits = $exitManager->selectAll('name');
        }

        return $this->twig->render('Exit/index.html.twig', ['exits' => $exits,'islogin' => $isLogIn]);
    }

    public function retrieveFilters()
    {
       // retrieve data from user
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!empty($_POST['jumpTypes'])) {
                $filterByJumpTypes = $_POST['jumpTypes'];
            } else {
                $filterByJumpTypes = [];
            }
            if (!empty($_POST['department'])) {
                $filterByDepartment = $_POST['department'];
            } else {
                $filterByDepartment = [];
            };
            $filter = [$filterByDepartment, $filterByJumpTypes];
            return $filter;
        }
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
        $errorMessages = [];
        $accessmessage = AdminController::accessDenied();
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $uploadDir = 'assets/images/'; // definir le dossier de stockage de l'image
            $extension = strToLower(pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION));
            $authorizedExtensions = ['jpg','jpeg','png']; // definir les extension autorisé
            $maxFileSize = 2000000; // definir le poid max de l'image
            $exit = $this->trimPostData(); // nettoyage des données
            $uploadFile = $uploadDir . basename($_FILES['image']['name']);
            if (empty($_FILES['image']['name'])) {
                $uploadFile = $uploadDir . basename($_FILES['image']['name']);
            } elseif ((!in_array($extension, $authorizedExtensions))) {
                $errorMessages[] = "Format d'image non supporté !
                Seuls les formats Jpg , Jpeg ou Png sont supportés.";
                $explodeName = explode('.', basename($_FILES['image']['name']));
                $name = $explodeName[0];
                $extension = $explodeName[1];
                $uniqName = $name . uniqid('', true) . "." . $extension;
                $uploadFile = $uploadDir . $uniqName;
            } if (
                file_exists($_FILES['image']['tmp_name']) &&
                filesize($_FILES['image']['tmp_name']) > $maxFileSize
            ) {
                $errorMessages[] = 'Votre image doit faire moins de 2M !';
            } if (ExitController::isEmpty($exit, $errorMessages)) {
                    $errorMessages = ExitController::isEmpty($exit, $errorMessages);
            } if (ExitController::checkDataLength($exit, $errorMessages)) {
                $errorMessages = ExitController::checkDataLength($exit, $errorMessages);
            } else {
                move_uploaded_file($_FILES['image']['tmp_name'], $uploadFile);
                $exit ['image'] = '/' . $uploadFile;
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
        return $this->twig->render('Exit/add.html.twig', ['error_messages' => $errorMessages,
                                                            'islogin' => $isLogIn,
                                                            'accessdenied' => $accessmessage]);
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

    public static function checkDataLength(array $exit, array $errorMessages): array
    {
        if (strlen($exit['name']) > 150) {
            $errorMessages[] = 'Le champs Nom doit être inferieur a 150 caractères';
        }
        if (strlen($exit['height']) > 150) {
            $errorMessages[] = 'Les champ Hauteur doit être inferieur a 150 caractères';
        }
        if (strlen($exit['department']) > 50) {
            $errorMessages[] = 'Le champ Département doit être inferieur a 50 caractères';
        }
        if (strlen($exit['country']) > 50) {
            $errorMessages[] = 'Le champ Pays doit être inferieur a 50 caractères';
        }
        if (strlen($exit['gps_coordinates']) > 50) {
            $errorMessages[] = 'Le champ Coordonnées GPS doit être inferieur a 50 caractères';
        }
        return $errorMessages;
    }

    public static function isEmpty(array $exit, array $errorMessages): array
    {
        if (
            empty($exit['name']) ||
            empty($exit['department']) ||
            empty($exit['country']) ||
            empty($exit['height']) ||
            empty($exit['acces'])
        ) {
            $errorMessages[] = 'Les champs Nom, Pays, Département, Hauteur, Accès sont obligatoire';
        }
        if (empty($exit['jumpTypes'])) {
            $errorMessages[] = 'Vous devez choisir au moins un Type de saut';
        }
        return $errorMessages;
    }

    /**
    * List filtered exits
    */
}
