<?php

namespace App\Model;

class JumpLogManager extends AbstractManager
{
    public const TABLE = 'jump_log';

    /**
     * Get all jump with exit from database.
     */
    public function selectJumpExit(string $orderBy = '', string $direction = 'ASC'): array
    {
        $query = 'SELECT jump_log.*, u.pseudo AS \'u_pseudo\', e.name AS \'e_name\', tj.name AS \'tj_name\' 
                    FROM ' . self::TABLE . ' INNER JOIN `user` u ON u.id = jump_log.id_user 
                    INNER JOIN `exit` e ON e.id = jump_log.id_exit 
                    INNER JOIN type_jump tj ON tj.id = jump_log.id_type_jump ';
        if ($orderBy) {
            $query .= ' ORDER BY ' . $orderBy . ' ' . $direction;
        }

        return $this->pdo->query($query)->fetchAll();
    }

        /**
     * Delete jump from jumplog
     */
    public function deleteJump(int $id): void
    {
        $statement = $this->pdo->prepare("DELETE FROM " . static::TABLE . " WHERE id=:id");
        $statement->bindValue('id', $id, \PDO::PARAM_INT);
        $statement->execute();
    }
}
