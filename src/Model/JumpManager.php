<?php

namespace App\Model;

class JumpManager extends AbstractManager
{
    public const TABLE = 'jump_log';

    /**
     * Get all jump with exit from database.
     */
    public function selectJumpExit(string $orderBy = '', string $direction = 'ASC'): array
    {
        $query = 'SELECT jump_log.*, u.pseudo AS \'user_pseudo\', e.name AS \'exit_name\', tj.name AS \'type_jump_name\' 
                    FROM ' . self::TABLE . ' INNER JOIN `user` u ON u.id = jump_log.id_user 
                    INNER JOIN `exit` e ON e.id = jump_log.id_exit 
                    INNER JOIN type_jump tj ON tj.id = jump_log.id_type_jump ';
        if ($orderBy) {
            $query .= ' ORDER BY ' . $orderBy . ' ' . $direction;
        }

        return $this->pdo->query($query)->fetchAll();
    }

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
