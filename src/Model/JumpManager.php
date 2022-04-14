<?php

namespace App\Model;

class JumpManager extends AbstractManager
{
    public const TABLE = 'jump_log';

    /**
     * Insert new jump in database
     */
    public function insert(array $jump): int
    {
        $statement = $this->pdo->prepare("INSERT INTO " . self::TABLE . " (`title`) VALUES (:title)");
        $statement->bindValue('title', $jump['title'], \PDO::PARAM_STR);

        $statement->execute();
        return (int)$this->pdo->lastInsertId();
    }

    /**
     * Update jump in database
     */
    public function update(array $jump): bool
    {
        $statement = $this->pdo->prepare("UPDATE " . self::TABLE . " SET `title` = :title WHERE id=:id");
        $statement->bindValue('id', $jump['id'], \PDO::PARAM_INT);
        $statement->bindValue('title', $jump['title'], \PDO::PARAM_STR);

        return $statement->execute();
    }
}
