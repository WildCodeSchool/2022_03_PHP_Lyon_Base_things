<?php

/* creation of the ExitManager class to manage the connection to the database */
namespace App\Model;

class ExitManager extends AbstractManager
{
    public const TABLE = '`exit`';

    /**
    * Get all row exit with type_jump from database.
    */
    public function selectTypeJumpByExitId(int $id): array|false
    {
        // prepared request
        $statement = $this->pdo->prepare("SELECT tj.name FROM " . self::TABLE . " e 
        INNER JOIN exit_has_type_jump ehtj ON ehtj.id_exit = e.id
        INNER JOIN type_jump tj ON tj.id = ehtj.id_type_jump
        WHERE e.id=:id");
        $statement->bindValue('id', $id, \PDO::PARAM_INT);
        $statement->execute();

        return $statement->fetchAll();
    }

    /**
    * Insert new exit in database
    */
    public function insert(array $exit): int
    {
        $statement = $this->pdo->prepare("INSERT INTO " . self::TABLE . " (`title`) VALUES (:title)");
        $statement->bindValue('title', $exit['title'], \PDO::PARAM_STR);

        $statement->execute();
        return (int)$this->pdo->lastInsertId();
    }

    /**
    * Update exit in database
    */
    public function update(array $exit): bool
    {
        $statement = $this->pdo->prepare("UPDATE " . self::TABLE . " SET `title` = :title WHERE id=:id");
        $statement->bindValue('id', $exit['id'], \PDO::PARAM_INT);
        $statement->bindValue('title', $exit['title'], \PDO::PARAM_STR);

        return $statement->execute();
    }

    public function exitsFiltered($filter)
    {
        if ($filter[0] == []) {
            $filterByJumpTypes = implode(', ', $filter[1]);
            $query = "SELECT exit.name, exit.image, exit.department, exit.height, exit.id 
           from `exit`
           left join `exit_Has_Type_Jump` on `id_exit`=exit.id
           left join `type_Jump` on `id_type_jump`=type_jump.id
           WHERE type_jump.id IN (" . $filterByJumpTypes . ");";
            return $this->pdo->query($query)->fetchAll();
        } elseif ($filter[1] == []) {
            $filterByDepartment = "'" . $filter[0][0] . "'";
            $filterLength = count($filter[1]);
            if (count($filter[0]) > 1) {
                for ($i = 1; $i < $filterLength; $i++) {
                    $filterByDepartment .=  ", '" . $filter[0][$i] . "'";
                };
            };
            echo $filterByDepartment;
            $query = "SELECT exit.name, exit.image, exit.department, exit.height, exit.id 
            from `exit`
            left join `exit_Has_Type_Jump` on `id_exit`=exit.id
            left join `type_Jump` on `id_type_jump`=type_jump.id
            WHERE exit.department IN (" .  $filterByDepartment . ");";
            return $this->pdo->query($query)->fetchAll();
        } else {
            $filterByJumpTypes = implode(', ', $filter[1]);
            $filterByDepartment = "'" . $filter[0][0] . "'";
            $filterLength = count($filter[1]);
            if (count($filter[0]) > 1) {
                for ($i = 1; $i < $filterLength; $i++) {
                    $filterByDepartment .=  ", '" . $filter[0][$i] . "'";
                };
            };
            $query = "SELECT exit.name, exit.image, exit.department, exit.height, exit.id 
            from `exit`
            join `exit_Has_Type_Jump` on `id_exit`=exit.id
            join `type_Jump` on `id_type_jump`=type_jump.id
            WHERE type_jump.id IN (" . $filterByJumpTypes . ") AND exit.department IN ('Vaucluse');";
            return $this->pdo->query($query)->fetchAll();
        };
    }
}
