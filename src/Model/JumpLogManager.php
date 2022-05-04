<?php

namespace App\Model;

class JumpLogManager extends AbstractManager
{
    public const TABLE = 'jump_log';

    /**
     * Get all jump with exit from database.
     */
    public function selectJumpExit(string $orderBy = '', string $direction = 'ASC', string $filterActivated = ''): array
    {
        $query = 'SELECT jump_log.*, u.pseudo AS \'u_pseudo\', e.name AS \'e_name\', tj.name AS \'tj_name\' 
                    FROM ' . self::TABLE . ' INNER JOIN `user` u ON u.id = jump_log.id_user 
                    INNER JOIN `exit` e ON e.id = jump_log.id_exit 
                    INNER JOIN type_jump tj ON tj.id = jump_log.id_type_jump ';
        if ($filterActivated) {
            $query .= " WHERE u.pseudo IN ('" . $filterActivated . "')";
        }
        if ($orderBy) {
            $query .= ' ORDER BY ' . $orderBy . ' ' . $direction;
        }

        return $this->pdo->query($query)->fetchAll();
    }
}
