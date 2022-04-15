<?php

namespace App\Controller;

use App\Model\ExitManager;

class ExitController extends AbstractController
{
    /**
     * List exits
     */
    public function index(): string
    {
        $exitManager = new ExitManager();
        $exits = $exitManager->selectAll('title');

        return $this->twig->render('Exit/index.html.twig', ['exits' => $exits]);
    }

    /**
     * Show informations for a specific exit
     */
    public function show(int $id): string
    {
        $exitManager = new ExitManager();
        $exit = $exitManager->selectExitTypeJump($id);

        return $this->twig->render('Exit/show.html.twig', ['exit' => $exit]);
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
     * Add a new exit
     */
    public function add(): ?string
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            // clean $_POST data
            $exit = array_map('trim', $_POST);

            // TODO validations (length, format...)

            // if validation is ok, insert and redirection
            $exitManager = new ExitManager();
            $id = $exitManager->insert($exit);

            header('Location:/exits/show?id=' . $id);
            return null;
        }

        return $this->twig->render('Exit/add.html.twig');
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
}
