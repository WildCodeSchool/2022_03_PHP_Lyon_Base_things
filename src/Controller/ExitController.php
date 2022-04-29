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
        if (!empty($this->retrieveFilters())) {
            $filter = $this->retrieveFilters();
            $exits = $exitManager->exitsFiltered($filter);
        } else {
            $exits = $exitManager->selectAll('name');
            $filter = null;
        }

        return $this->twig->render(
            'Exit/index.html.twig',
            ['exits' => $exits,'islogin' => $isLogIn, 'filter' => $filter]
        );
    }

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

    /**
    * List filtered exits
    */
}
