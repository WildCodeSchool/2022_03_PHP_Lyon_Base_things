<?php

/* creation of the ExitController class to pass requests to the database */
namespace App\Controller;

use App\Model\ExitManager;
use App\Controller\AdminController;

class ExitController extends AbstractController
{
    /**
     * List exits
     */
    public function index(): string
    {
        $adminController = new AdminController();
        $exitManager = new ExitManager();
        $isLogIn = $adminController->isLogIn();
        $exits = $exitManager->selectAll('name');
        return $this->twig->render('Exit/index.html.twig', ['exits' => $exits,'islogin' => $isLogIn]);
    }

    /**
     * Show informations for a specific exit
     */
    public function show(int $id): string
    {
        $adminController = new AdminController();
        $exitManager = new ExitManager();
        $exit = $exitManager->selectOneById($id);
        $isLogIn = $adminController->isLogIn();
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
        ]);
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
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
             // Nettoie $_POST data
            $exit = array_map('trim', $_POST);
            // Securité en php
            // chemin vers un dossier sur le serveur qui va recevoir les fichiers uploadés
            // (attention ce dossier doit être accessible en écriture)
            $uploadDir = 'assets/images/';
            // le nom de fichier sur le serveur est ici généré à partir du nom de fichier sur le poste du client
            // (mais d'autre stratégies de nommage sont possibles)
            $uploadFile = $uploadDir . basename($_FILES['image']['name']);
            // Récupère l'extension du fichier
            $extension = pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION);
            // Extensions autorisées
            $authorizedExtensions = ['jpg','jpeg','png'];
            // Poids max géré par PHP par défaut est de 2M
            $maxFileSize = 2000000;
            // Je sécurise et effectue mes tests
            // Si l'extension est autorisée
            if ((!in_array($extension, $authorizedExtensions))) {
                echo 'Veuillez sélectionner une image de type Jpg ou Jpeg ou Png !';
            }
            // Vérifie si l'image existe et si le poids est autorisé en octets
            if (file_exists($_FILES['image']['tmp_name']) && filesize($_FILES['image']['tmp_name']) > $maxFileSize) {
                echo 'Votre fichier doit faire moins de 2M !';
            }
            move_uploaded_file($_FILES['image']['tmp_name'], $uploadFile);
            // Ajout du nom de l'image dans le tableau "exit"
            $exit ['image'] = $uploadFile;
            $exitManager = new ExitManager();
            $id = $exitManager->insert($exit);
/*          $exit['jumpTypes'] = [1,2,5];
            echo $exit['jumpTypes'][0]; */
            // Redirige vers le détail de l'éxit que l'on vient de créer
            header('Location:/Exit/index?id=' . $id);
            return null;
        }
        return $this->twig->render('Exit/add.html.twig');
    }
}
