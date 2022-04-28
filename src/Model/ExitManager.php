<?php

/* creation of the ExitManager class to manage the connection to the database */

namespace App\Model;

class ExitManager extends AbstractManager
{
    public const TABLE = '`exit`';
    public const TABLE_HAS_TYPE_JUMP = '`exit_has_type_jump`';
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
    public function insert(array $exits): int
    {
        $statement = $this->pdo->prepare("INSERT INTO " . self::TABLE . " 
        (`name`, `department`, `country`, `height`, `access_duration`, `gps_coordinates`, `acces`,
        `remark`, `video`, `image`) 
        VALUES 
        (:name, :department, :country, :height, :access_duration, :gps_coordinates, :acces, :remark, :video, :image)");
        $statement->bindValue('name', $exits['name'], \PDO::PARAM_STR);
        $statement->bindValue('department', $exits['department'], \PDO::PARAM_STR);
        $statement->bindValue('country', $exits['country'], \PDO::PARAM_STR);
        $statement->bindValue('height', $exits['height'], \PDO::PARAM_STR);
        $statement->bindValue('access_duration', $exits['access_duration'] . ':00', \PDO::PARAM_STR);
        $statement->bindValue('gps_coordinates', $exits['gps_coordinates'], \PDO::PARAM_STR);
        $statement->bindValue('acces', $exits['acces'], \PDO::PARAM_STR);
        $statement->bindValue('remark', $exits['remark'], \PDO::PARAM_STR);
        $statement->bindValue('video', $exits['video'], \PDO::PARAM_STR);
        $statement->bindValue('image', $exits['image'], \PDO::PARAM_STR);
        $statement->execute();
        return (int)$this->pdo->lastInsertId();
    }

    /**
     * Insert exit has jump type in database
     */
    public function insertJumpType(int $id, array $jumpTypes): void
    {
        foreach ($jumpTypes as $jumpType) {
            $statement = $this->pdo->prepare("INSERT INTO " . self::TABLE_HAS_TYPE_JUMP . "(`id_exit`, `id_type_jump`) 
            values (:id_exit, :id_type_jump)");
            $statement->bindValue('id_exit', $id, \PDO::PARAM_INT);
            $statement->bindValue('id_type_jump', $jumpType, \PDO::PARAM_INT);
            $statement->execute();
        }
    }

    /**
     * Insert exit has jump type in database
     */
    public function updateExitHasTypeJump(int $id, array $jumpTypes): void
    {
        $statement = $this->pdo->prepare("DELETE FROM " . self::TABLE_HAS_TYPE_JUMP . " WHERE id_exit=:id_exit");
        $statement->bindValue('id_exit', $id, \PDO::PARAM_INT);
        $statement->execute();

        foreach ($jumpTypes as $jumpType) {
            $statement = $this->pdo->prepare("INSERT INTO " . self::TABLE_HAS_TYPE_JUMP . "(`id_exit`, `id_type_jump`) 
            values (:id_exit, :id_type_jump)");
            $statement->bindValue('id_exit', $id, \PDO::PARAM_INT);
            $statement->bindValue('id_type_jump', $jumpType, \PDO::PARAM_INT);
            $statement->execute();
        }
    }

    /**
     * Update exit in database
     */
    public function update(array $exit): bool
    {
        $statement = $this->pdo->prepare("UPDATE " . self::TABLE . " SET
        `name` = :name,
        `department` = :department,
        `country` = :country,
        `height` = :height,
        `access_duration` = :access_duration,
        `gps_coordinates` = :gps_coordinates,
        `acces` = :acces,
        `remark` = :remark,
        `video` = :video,
        `image` = :image
        WHERE id=:id");

        $statement->bindValue('id', $exit['id'], \PDO::PARAM_INT);
        $statement->bindValue('name', $exit['name'], \PDO::PARAM_STR);
        $statement->bindValue('department', $exit['department'], \PDO::PARAM_STR);
        $statement->bindValue('country', $exit['country'], \PDO::PARAM_STR);
        $statement->bindValue('height', $exit['height'], \PDO::PARAM_STR);
        $statement->bindValue('access_duration', $exit['access_duration'], \PDO::PARAM_STR);
        $statement->bindValue('gps_coordinates', $exit['gps_coordinates'], \PDO::PARAM_STR);
        $statement->bindValue('acces', $exit['acces'], \PDO::PARAM_STR);
        $statement->bindValue('remark', $exit['remark'], \PDO::PARAM_STR);
        $statement->bindValue('video', $exit['video'], \PDO::PARAM_STR);
        $statement->bindValue('image', $exit['image'], \PDO::PARAM_STR);

        return $statement->execute();
    }
}
