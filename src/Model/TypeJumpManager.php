<?php

namespace App\Model;

class TypeJumpManager extends AbstractManager
{
    public const TABLE = 'type_jump';

    /**
     * Insert new typeJump in database
     */
    public function insert(array $typeJump): int
    {
        $statement = $this->pdo->prepare("INSERT INTO " . self::TABLE . " (`title`) VALUES (:title)");
        $statement->bindValue('title', $typeJump['title'], \PDO::PARAM_STR);

        $statement->execute();
        return (int)$this->pdo->lastInsertId();
    }

    /**
     * Update typeJump in database
     */
    public function update(array $typeJump): bool
    {
        $statement = $this->pdo->prepare("UPDATE " . self::TABLE . " SET `title` = :title WHERE id=:id");
        $statement->bindValue('id', $typeJump['id'], \PDO::PARAM_INT);
        $statement->bindValue('title', $typeJump['title'], \PDO::PARAM_STR);

        return $statement->execute();
    }
}
