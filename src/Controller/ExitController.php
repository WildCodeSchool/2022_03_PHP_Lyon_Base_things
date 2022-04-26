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
        $errorMessage = "";
        $errorMessageImg = "";
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!empty($_POST)) { // verifié si le formulaire est vide
                $exit = $this->trimPostData(); // nettoyage des données
                $uploadDir = 'assets/images/'; // definir le dossier de stockage de l'image
                $extension = pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION);
                $authorizedExtensions = ['jpg','jpeg','png']; // definir les extension autorisé
                $maxFileSize = 2000000; // definir le poid max de l'image
                if (!empty($exit['image'])) { // verifié si on upload une image
                    $explodeName = explode('.', basename($_FILES['image']['name']));
                    $name = $explodeName[0];
                    $uniqName = $name . uniqid('', true) . "." . $extension;
                    $uploadFile = $uploadDir . $uniqName;
                } else { // on garde le nom de base si on upload pas d'image
                    $uploadFile = $uploadDir . basename($_FILES['image']['name']);
                }
                if ((!in_array($extension, $authorizedExtensions))) {
                    $errorMessageImg = "Format d'image non supporté !
                    Seuls les formats Jpg, Jpeg ou Png sont supportés.";
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
                                                            'error_message_img' => $errorMessageImg,
                                                            'islogin' => $isLogIn]);
    }

    public function trimPostData(): array
    {
        foreach ($_POST as $data) {
            if (is_array($data)) {
                $_POST[] = $data;
                continue;
            }
            $_POST[] = trim($data);
        }
        return $_POST;
    }
}
