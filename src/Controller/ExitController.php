<?php

/* creation of the ExitController class to pass requests to the database */

namespace App\Controller;

use App\Model\ExitManager;
use App\Model\TypeJumpManager;
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
        $isFilterActive = $this->isFilterActive();
        $listOfActiveFilters = [];
        if (!empty($this->retrieveFilters())) {
            $filter = $this->retrieveFilters();
            $listOfActiveFilters = $this->listOfActiveFilters($filter);
            $exits = $exitManager->exitsFiltered($filter);
        } else {
            $exits = $exitManager->selectAll('name');
            $filter = null;
        }
        return $this->twig->render(
            'Exit/index.html.twig',
            ['exits' => $exits,'islogin' => $isLogIn, 'filter' => $filter,
            'isFilterActive' => $isFilterActive, 'listOfActiveFilters' => $listOfActiveFilters]
        );
    }

    /**
    * Retrieve filters from user
    */
    public function retrieveFilters()
    {
       // retrieve data from user
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!empty($_POST)) {
                if (!empty($_POST['jumpTypes'])) {
                    $filterByJumpTypes = $_POST['jumpTypes'];
                    $_SESSION['filterByJumpTypes'] = $filterByJumpTypes;
                } else {
                    $filterByJumpTypes = [];
                };
                if (!empty($_POST['department'])) {
                    $filterByDepartment = $_POST['department'];
                    $_SESSION['filterByDepartment'] = $filterByDepartment;
                } else {
                    $filterByDepartment = [];
                };
                $filter = [$filterByDepartment, $filterByJumpTypes];
                return $filter;
            };
        };
    }

    /**
    * List the active filters as a string in order to be reminded to user
    */
    public function listOfActiveFilters($filter)
    {
        if ($this->isFilterActive() == true) {
            $filterByDepartment = $filter[0];
            $filterByJumpTypes = $filter[1];
            if (count($filterByDepartment) == 0 && count($filterByJumpTypes) == 0) {
                $listOfActiveFilters = [];
            } elseif (count($filterByDepartment) == 0) {
                $filterByJumpTypes = $this->convertTypeJumpValueInId($filterByJumpTypes);
                $listOfActiveFilters = implode(", ", $filterByJumpTypes);
            } elseif (count($filterByJumpTypes) == 0) {
                $listOfActiveFilters = implode(", ", $filterByDepartment);
            } else {
                $filterByJumpTypes = $this->convertTypeJumpValueInId($filterByJumpTypes);
                $listOfActiveFilters = implode(", ", $filterByDepartment) . ", " . implode(", ", $filterByJumpTypes);
            };
            return $listOfActiveFilters;
        };
    }

    public function convertTypeJumpValueInId($filterByJumpTypes): array|string
    {
        $convertTable = ["Static-line", "Sans Glisseur", "Lisse", "Track Pantz", "Track Pantz Monopièce", "Wingsuit"];
        $convertedFilter = [];
        foreach ($filterByJumpTypes as $filterByJumpType) {
            $convertedFilter [] = $convertTable[$filterByJumpType - 1];
        }
        return $convertedFilter;
    }

    /**
    * Indicates if a filter have been done
    */
    public function isFilterActive(): bool
    {
        if (!empty($this->retrieveFilters())) {
            return true;
        } else {
            return false;
        };
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
        $errorMessage = [];

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
                $authorizedExtensions = ['jpg', 'jpeg', 'png']; // definir les extension autorisé
                $maxFileSize = 2000000; // definir le poid max de l'image
                if (empty($_FILES['image']['name'])) { // verifié si on upload une image
                    // on renvoi l'ancien chemin pour mettre en BDD
                    $uploadFile = $exit['image'];
                } else { // on ajoute un uniqid au nom de l'image
                    $explodeName = explode('.', basename($_FILES['image']['name']));
                    $name = $explodeName[0];
                    $extension = $explodeName[1];
                    $uniqName = $name . uniqid('', true) . "." . $extension;
                    $uploadFile = $uploadDir . $uniqName;
                }
                if ((!in_array($extension, $authorizedExtensions))) {
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
            'islogin' => $isLogIn
        ]);
    }

    /**
     * Delete a specific exit
     */
    public function delete(): void
    {
        $isLogIn = AdminController::isLogIn();

        if (!$isLogIn) {
            header('Location: /login');
        } elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
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
            $datas += array($key => (trim($data)));
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
